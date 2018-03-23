<?php
namespace Api\Controller;
use Think\Controller;
use Think\Log;
class TestController extends Controller
{
    public function __construct()
    {
        //原速腾 的项目  测试服务器
        global $redis;
        $redis = new \Redis();
        $redis->connect('127.0.0.1',6379);
    }

    /**
     * 获取缓存
     * @param  string $pre [前缀]
     * @return Array       [缓存数据]
     */
    public function getCache($pre='')
    {
        global $redis;
        Log::write('重建 定时redis数据','Redis_Timer');
        $pre = empty($pre) ? '*' : $pre."*";
        $list = $redis->keys($pre);
        $items = [];
        for ($i=0; $i< count($list); $i++){
            $res = '';
            $res = json_decode($redis->get($list[$i]));
            $res->key = $list[$i];
            $items[]  =  $res;
            //$redis->delete($list[$i]);
        }
        return $items;
    }

    /**
     * [makeCache 重新生成缓存 容错处理 宕机时数据自动恢复 ]
     * @param  String $key [缓存的前缀]
     * @return [type]      []
     */
    public function makeCache($key='Timer_')
    {
        global $redis;
        $keys = array('Timer_');
        if (in_array($key,$keys)) {
            $data = M('task')->where('state=1')->select();
            foreach ($data as $val) {
                $k='';
                $k = $key.$val['id']; 
                
                $val['device_code'] = M('Devices')->where('id='.$val['did'])->getField('device_code');// 查询设备码

                $res=$redis->set($k,json_encode($val));
            }
        }
    }

    /**
     * [Timer 定时器]
     * 每天执行一次 每天 0:01运行 用于添加每天的任务
     */
    public function TimerOneDay()
    {
        global $redis;
        $k='Timer_';
        $map['state']=1;
        $map['repeat']=1;
        $data = M('task')->where($map)->select();
        foreach ($data as $val) {
            $k='';
            $k = $key.$val['id']; 
            
            $val['device_code'] = M('Devices')->where('id='.$val['did'])->getField('device_code');// 查询设备码

            $res=$redis->set($k,json_encode($val));
        }
    }

    /**
     * [Timer 定时器 每分钟执行一次]
     */
    public function Timer()
    {
        global $redis;
        $items = $this->getCache('Timer_');
        if(empty($items)){
            $this->makeCache('Timer_');
        }

        // 传到设备数据
        $msgs = [
            '0'=>['DeviceID'=>'', 'PackType'=>'SetData','Vison'=>'0','DeviceStause'=>'8'],//开机
            '1'=>['DeviceID'=>'', 'PackType'=>'SetData','Vison'=>'0','DeviceStause'=>'7'],//关机
//            '2'=>['DeviceID'=>'', 'PackType'=>'SetData','Vison'=>'0','DeviceStause'=>'8'],//开启加热
//            '3'=>['DeviceID'=>'', 'PackType'=>'SetData','Vison'=>'0','DeviceStause'=>'8'],//关闭加热
        ];

        $time = time();

        //发送设备命令
        $sc=A("Action");  //信息控制器
        foreach ($items as $k=>$li){
            //比对时间 设备控制
            $ftime = strtotime(date('Y-m-d',time()).' '.$li->hour.':'.$li->minute);
            if ($ftime <= $time) {
                $DeviceIDs[]= $li->device_code;
                $eqs[]=$li;
                $msg = $msgs[$li->type];
                $msg['DeviceID'] = $li->device_code;

                $sc->sendMsg($li->device_code,json_encode($msg));
            }
            unset($ftime);
            unset($msg);
        }

        //获取所有定时设备的状态
        $DeviceStauses = [];  //设备状态
        $DeviceIDs = implode(',',$DeviceIDs);
        $map=['DeviceID'=>['in',$DeviceIDs]];
        $list = M('devices_statu')->where($map)->field('DeviceID,DeviceStause')->select();
        foreach ($list as $li) {
            $DeviceStauses[trim($li['deviceid'])] = $li['devicestause'];
        }
   
        // 过滤已执行的缓存数据 （即设备已变换状态成功后 清除数据）
        // 缓存中的状态  0:开机，1：关机,2：开启加热，3：关闭加热
        // 数据库状态    0:制水 1:冲洗 2:水满 3:缺水 4漏水 5:检修 6:欠费停机 7:关机 8:开机(仅命令)
        $data_Stause =['0'=>'8', '1'=>'7' ];
        $m = M('task');
        foreach ($eqs as $k=>$li){
            $Stause=$DeviceStauses[$li->device_code];
            if($data_Stause[$li->type] == $Stause){
                $redis->delete($li->key);
                $data['state']=0;
                $m->where('id='.$li->id)->save($data);
            }
        }
    }
}