<?php
namespace Home\Controller;
use Think\Controller;
class IndexController extends CommonController 
{
    public function index()
    {
    	$userInfo = $_SESSION['homeuser'];

    	if($userInfo){
	        // 获取用户当前设备
	        $did = $userInfo['did'];

	        if(empty($did)){
	        	// 请先绑定设备
	        	$this->success('请先绑定设备...', 'Home/Devices/manage');
	        }else{
	        	// 查询用户设备设备码
	        	$deviceInfo = M('Devices')
	        	->where('pub_devices.id='.$did)
	        	->join('pub_devices_statu ON pub_devices_statu.DeviceID=pub_devices.device_code')
	        	->field('RawTDS,PureTDS,ReFlow,SumFlow')
	        	->find();

            	// 分配数据到模板
            	$this->assign('deviceInfo',$deviceInfo);

            	// 显示模板
	        	$this->display();	
	        }
    	}

	}
}