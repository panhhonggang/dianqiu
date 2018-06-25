<?php
namespace Home\Controller;
use Common\Tool\Common;
use Common\Tool\GatewayClient;
use Think\Controller;
class IndexController extends CommonController 
{
    public function index()
    {
    	$userInfo = $_SESSION['homeuser'];


    	if($userInfo){
	        // 获取用户当前设备
	        $did = $userInfo['did'];
            //show($did);die;
	        if(empty($did)){
	        	// 请先绑定设备
	        	$this->success('请先绑定设备...', '/Home/Devices/manage');
                // exit;
	        }else{
	        	// 查询用户设备设备码
	        	$deviceInfo = M('Devices')
	        	->where('pub_devices.id='.$did)
	        	->join('pub_devices_statu ON pub_devices_statu.DeviceID=pub_devices.device_code')
	        	->field('RawTDS,PureTDS,ReFlow,SumFlow')
	        	->find();
                // 滤芯详情
                $code = M('devices')->where("id={$_SESSION['homeuser']['did']}")->find();

                $status = M('devices_statu')->where("DeviceID='{$code['device_code']}'")->find();
                $type = M('device_type')->where("id={$code['type_id']}")->find();
                unset($type['id'], $type['typename'], $type['addtime']);
                $sum = array_filter($type);
                foreach ($sum as $key => $value) {
                    $str = stripos($value,'-');
                    $map['filtername'] = substr($value, 0,$str);
                    $map['alias'] = substr($value, $str+1);
                    $res[] = M('filters')->where($map)->find();
                }
                $assign = array(
                    'res' => json_encode($res),
                    'status' => json_encode($status),
                    'deviceInfo' => json_encode($deviceInfo),

                );

                // 分配数据到模板
                $this->assign($assign);
            	// 显示模板
	        	$this->display();	
	        }


    	}

	}

    // 滤芯数据
    public function filter()
    {
        // 滤芯详情
        $code = M('devices')->where("id={$_SESSION['homeuser']['did']}")->find();
        $status = M('devices_statu')->where("DeviceID='{$code['device_code']}'")->find();
        $type = M('device_type')->where("id={$code['type_id']}")->find();
        unset($type['id'], $type['typename'], $type['addtime']);
        $sum = array_filter($type);
        foreach ($sum as $key => $value) {
            $str = stripos($value,'-');
            $map['filtername'] = substr($value, 0,$str);
            $map['alias'] = substr($value, $str+1);
            $res[] = M('filters')->where($map)->find();
        }
        $assign = array(
            'res' => json_encode($res),
            'status' => json_encode($status),

        );
        // 分配数据到模板
        $this->assign($assign);
        // 显示模板
        $this->display();
    }




    // 新版 页面控制
    public function bind()
    {
        try {
            $post = I('post.');
            if (empty($post['client_id']) || empty($post['deviceID']) ) {
                E('数据不完整', 40001);
            }

            if(GatewayClient::bind($post['client_id'], $post['deviceID'])){
                E('成功',200);
            }else{
                E('成功',40010);
            }
        } catch (\Exception $e) {
            Common::toJson($e);
        }
    }

    /**
     * @param $post
     *  参数 mode
     *   1   //开机
     *   2   //关机
     *   3   //冲洗
     *   4   //取消冲洗
     *   5   //复位滤芯  "Pram":[1,2] 滤芯级数
     *   6   //绑定设备
     *   7   //解绑设备
     *   8   //充值100天  "Pram":{"mode":2,”val”:100}
     *   9   //充值100L   "Pram":{"mode":1,”val”:100}}
     *   10  //租赁模式修改  'Pram' 0 买断模式  1 流量 2 时长 3 时长和流量
     *   11  //滤芯模式修改  'Pram' 0 时长 1 流量 2 时长和流量
     *
     */
    public static function action($post)
    {
        try {
            $post = I('post.');



            $res = GatewayClient::action(8, '1231212312312',['mode'=>2,'val'=>0]);

            if($res){
                E('成功',200);
            }else{
                E('成功',40010);
            }
        } catch (\Exception $e) {
            Common::toJson($e);
        }
    }
}