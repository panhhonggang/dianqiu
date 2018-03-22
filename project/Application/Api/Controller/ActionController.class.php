<?php
namespace Api\Controller;
use Think\Controller;
use Think\Log;
use Org\Util\Gateway;

class ActionController extends Controller
{
    public function __construct()
    {
        Gateway::$registerAddress = '127.0.0.1:9504';
    }
    //测试
    public function Initialize($device_code) {

        $client_id = Gateway::getClientIdByUid($device_code);
        return $client_id;


    }
    public function ssss()
    {
        // $msg['PackNum'] = ['30'=>401];
        // file_put_contents('./PackNum_868575025672835',serialize($msg));


        // // $this->get_PackNum('868575025672835',300);
        // $rr = unserialize(file_get_contents('./PackNum/PackNum_868575025672835'));
        dump($rr);


// {"DeviceID":"868575025672835","PackType":"SetData","Vison":0,"Reday":80,"PackNum":81}
        // die;
        // $this->sysnc_web('868575025672835');

        // $msg['PackType']="SetData";
        // $msg['DeviceID']="868575025672835";//$dcode;
        // $msg['Vison']="0";
        // $msg['ReFlow'] = 0;//empty($data['reflow'])? 0 : $data['reflow'];
        // $msg['Reday'] = 100;//empty($data['reday'])? 0 : $data['reday'];
        // $msg['PackNum'] = 30;
        // // $msg = ["DeviceID"=>"868575025672835","PackType"=>"SetData","Vison"=>0,"DeviceStause"=>8];
        // // $res = Gateway::getClientIdByUid("868575025672835");
        // // dump($res);
        // // dump(Gateway::isUidOnline('868575025672835'));
        // // $acl="";
        // // foreach ($res as $key => $value) {
        // //     // $res = array_pop($res);
        // // }
        //     // dump($res);
            // dump(Gateway::sendToUid("868575025672835",$msg));

        //     dump(Gateway::sendToClient($acl,$msg));
        // dump(Gateway::isUidOnline($res));
    }

    // 接收信息
    public function receive()
    {
        $message = I('post.');
        $client_id = $message['client_id'];
        unset($message['client_id']);
        if(empty($message['DeviceID'])){
            $mes  = Gateway::getSession($client_id);
            $message['DeviceID']  = $mes['DeviceID'];
            
        }
        // 判断数据传输的对象
        if( $message['soure']=='Close')
        {
            $this->Close($message['DeviceID']);
        }
        else if( $message['soure']=='TCP'){
            $this->gettcp($client_id, $message);
           
        } else {
            $this->getws($client_id, $message);
        }
    }
    public function Close($DeviceID)
    {
        $this->updateNetStase($DeviceID,0);
    }

    public function updateNetStase($DeviceID,$NetStause)
    {
        $status_id = M('devices_statu')->where("DeviceID=" . $DeviceID)->getField('id');

        $data = [
            'NetStause'   => $NetStause,
        ];
        $this->updateData($status_id, $data);
    }

    /**
     * [sendMsg 向设备发送信息 信息推送]
     * @param  [type] $device_code [设备码]
     * @param  [type] $message     [信息串]
     * @return [type]              [description]
     */
     public function sendMsg($device_code,$message)
     {
         sleep(1);
         Gateway::sendToUid($device_code, $message);
     }

    // 设备消息处理
    public function gettcp($client_id, $message)
    {
        if( empty( Gateway::getSession($client_id) ) ){
            Gateway::setSession($client_id, $message);
        } else {
            $res = Gateway::getSession($client_id);

            $message['DeviceID'] = $res['DeviceID'];
        }
        
        $this->updateNetStase($message['DeviceID'],1);
        if($message['PackType'] == 'login'){
            
            Gateway::bindUid($client_id, $message['DeviceID']);

        }

        switch ($message['PackType']) {
            case 'login':
                /*$message = */$this->loginAction($message);
                break;
            // 设备设置
            case 'Select':

       
                
                /*$message = */$this->selectAction($message);
                break;

            case 'SetData':

                if(isset($message['PackNum'])){
                    if($message['PackNum'] >= 30 && $message['PackNum']<=100){
                        // Log::write(json_encode($message), 'AAAAAAA');

                        $arr=unserialize(file_get_contents('./PackNum/PackNum_'.$message['DeviceID']));

                        $id=isset($arr['PackNum'][$message['PackNum']])?$arr['PackNum'][$message['PackNum']]:false;
                        if($id){
                            $res = M('order_setmeal')->where('id='.$id)->save(['is_play'=>1]);
                            // Log::write($res, 'BBBBBBBBBB');
                            if($res){
                                unset($arr['PackNum'][$message['PackNum']]);

                                file_put_contents('./PackNum/PackNum_'.$message['DeviceID'],unserialize($arr));
                            }
                        }
                    }
                }
                break;

            default:
                # code...
                break;
        }

        if( isset($message['DeviceID']) ){
            if( Gateway::getClientCountByGroup($message['DeviceID']) > 0 ){
                Gateway::sendToGroup( $message['DeviceID'], json_encode($message) );
            }
        }
        Gateway::sendToClient($client_id, $message);

        if($message['PackType'] == 'login'){
            $this->sysnc_web($message['DeviceID']);
        }
        
    }

    public function sysnc_web($devices)
    {

        $map['d.device_code'] = $devices;
        $map['od.is_play'] = 0;
        $map['o.is_pay'] = 1;
        // $data = M('devices_statu')->where($map)->field('reflow,reday')->find();
        $data = M('devices')
            ->alias('d')
            ->where($map)
            ->join('__ORDERS__ o ON d.id=o.device_id', 'LEFT')
            ->join('__ORDER_SETMEAL__ od ON o.order_id=od.order_id', 'LEFT')
            ->field('od.id,od.remodel,od.flow,od.goods_num')
            ->select();

        
        foreach ($data as $key => $value) {
            // M('order_setmeal')->startTrans();
            $arr = [];
            if($value['remodel'] == 1){
                $arr['reday'] = $value['flow'];
            } else {
                $arr['reflow'] = $value['flow'];
            }

            // $res = M('order_setmeal')->where('id='.$value['id'])->save(['is_play'=>1]);
            $arr['PackNum'] = (string)$this->get_PackNum($map['d.device_code'],$value['id']);
           
            $this->sysnc_info($devices,$arr);
        };
    }

    public function get_PackNum($did,$id)
    {
        $res = file_get_contents('./PackNum/PackNum_'.$did);
        if($res){
            $arr = unserialize($res);
        }
        $key =  array_keys($arr['PackNum'],$id);
        if(!empty($key)){
            return array_pop($key);
        }else{
            for ($i=30; $i <=100; $i++) {
            if(!isset($arr['PackNum'][$i])){
                $arr['PackNum'][$i] = $id;

                file_put_contents('./PackNum/PackNum_'.$did, serialize($arr));
                return $i;
            }
        }
        }
        
    }


    // json数据处理
    public function getws($client_id, $message)
    {
        if( $message['PackType'] == 'login' ){
            Gateway::joinGroup( $client_id, $message['DeviceID'] );
        } else {
            Gateway::sendToUid($message['DeviceID'], $message);

        }
    }

    // 登陆数据处理
    public function loginAction($message)
    {
        $data = [
            'DataCmd'     => $message['DataCmd'],
            'Device'      => $message['Device'],
            'PackType'    => $message['PackType'],
            'AliveStause' => $message['AliveStause'],
            'DeviceType'  => $message['DeviceType'],
            'DeviceID'    => $message['DeviceID'],
            'ICCID'       => $message['ICCID'],
            'CSQ'         => $message['CSQ'],
            'Loaction'    => $message['Loaction'],
            'NetStause'   =>1,
//            'Reday'       => $message['Reday'],
//            'ReFlow'      => $ReFlow,
        ];
        $devices_id = M('devices')->where("device_code={$message['DeviceID']}")->getField('id');
        $status_id  = M('devices_statu')->where("DeviceID={$message['DeviceID']}")->getField('id');
        if( empty($status_id) ){
            $res = $this->saveData($data);
            if($res){
                $data['updatetime'] = time();
                $data['device_status'] = 1;
                $result = M('devices')->where('device_code=' . $message['DeviceID'])->save($data);
            }
        } else {
            $res = $this->updateData($status_id, $data);
        }
        // if($res){
        //     return $data;
        // }
    }

    // 设备自动回复处理
    public function selectAction($message)
    {
        // $ReFlow = 0;
        // $Reday = 0;
  
        // $result = $this->sysnc_info($message['DeviceID']);
        // if(!empty($result)){
        //     $ReFlow = empty($result['reflow'])? 0 : $result['reflow'];
        //     $Reday = empty($result['reday'])? 0 : $result['reday'];
        // }

        $data = [
            'DeviceStause' => $message['DeviceStause'],
            'ReFlow'       => $message['ReFlow'],
            'ReDay'        => $message['Reday'],
            'SumFlow'      => $message['SumFlow'],
            'SumDay'       => $message['SumDay'],
            'RawTDS'       => $message['RawTDS'],
            'PureTDS'      => $message['PureTDS'],
            'Temperature'  => $message['Temperature'],
            'FilerNum'     => $message['FilerNum'],
            'LeasingMode'  => $message['LeasingMode'],
        ];
        if( $message['FilerNum'] != null ){
            $res = $this->filterAction($message);

            $data = array_merge( $data, $res );
        }

        $status_id = M('devices_statu')->where("DeviceID=" . $message['DeviceID'])->getField('id');
        if($this->updateData($status_id, $data)){
            return $data;
        }
    }


    // 存储数据 将数据存到 devices_statu表中
    public function saveData($data)
    {
        $data['addtime'] = time();
        return M('devices_statu')->add($data);
    }

    // 更新数据
    public function updateData($id, $data)
    {
        $data['updatetime'] = time();
        return M('devices_statu')->where("id={$id}")->save($data);
    }

    // 滤芯处理
    public function filterAction($message)
    {
        $data = array();
        for( $i = 1; $i <= $message['FilerNum']; $i ++)
        {
            $data['ReFlowFilter' . $i]   = $message['ReFlowFilter' . $i];
            $data['ReDayFilter' . $i]    = $message['ReDayFilter' . $i];
        }
        if ($data['ReFlowFilter1']==-1) {
            $data['FilterMode']=0;
        }
        if ( $data['ReDayFilter1']==-1 ){
            $data['FilterMode']=1;
        }
        if ($data['ReDayFilter1']>=0 and  $data['ReFlowFilter1']>=0) {
            $data['FilterMode']=2;
        }


        return $data;
    }

    // 同步数据库的流量剩余信息
    public function sysnc_info($dcode,$data)
    {
        $msg['PackType']="SetData";
        $msg['PackNum']=$data['PackNum'];
        $msg['DeviceID']=$dcode;
        $msg['Vison']="0";
        $msg['ReFlow'] = empty($data['reflow'])? 0 : $data['reflow'];
        $msg['Reday'] = empty($data['reday'])? 0 : $data['reday'];


        // Log::write(json_encode($msg), 'BBBBBBB');

        // if(Gateway::getClientIdByUid($dcode))
//         dump($msg);
            // die;
        sleep(2);
        $res = Gateway::sendToUid($dcode, $msg);
        // $res = $this->sendMsg($dcode, $msg);
        
        // return $res;
    }

}