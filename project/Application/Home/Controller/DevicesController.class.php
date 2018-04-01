<?php
namespace Home\Controller;
use Think\Controller;
use \Org\Util\WeixinJssdk;
use Think\Log;

class DevicesController extends CommonController 
{
    // 设备首页
    public function index()
    {
        // 显示模板
        $this->display();
    }
    // 设备管理页面
    public function manage()
    {
        // 获取用户uid
        $uid = $_SESSION['homeuser']['id'];

        // 查询用户设备
        $devices = M('Devices')->where("`uid`={$uid}")->field('id,device_code')->select();
        
        // 查找用户当前设备
        $currentDevices = M('currentDevices')->where("`uid`={$uid}")->field('did')->find();
        //show($currentDevices);die;
        // 分配数据
        $this->assign('devices',$devices);
        $this->assign('currentDevices',$currentDevices);

        //调用微信JS-SDK类获取签名需要用到的数据
        $weixin = new WeixinJssdk;
        $signPackage = $weixin->getSignPackage();
        // 查询用户微信中的openid
        //$openId = $weixin->GetOpenid();
        // 调试用默认用户
        $openId = $_SESSION['homeuser']['open_id'];
        //分配数据        
        $this->assign('info',$signPackage);
        $this->assign('openId',$openId);
        //show($openId);die;
        // 显示模板
        $this->display();
    }

    // 设置当前设备
    public function setNowDevices()
    {
        if(IS_POST){
            $uid = $_SESSION['homeuser']['id'];
            $device_code = I('post.device_code');
            $data['did'] = M('Devices')->where("`device_code`={$device_code}")->field('id')->find()['id'];
            $res = M('currentDevices')->where("`uid`={$uid}")->save($data);

            if($res){
                $_SESSION['homeuser']['did'] = $data['did'];
                echo 1;
            }else{
                echo -1;
            }
        }
        
    }

    /*
        设备绑定流程：
            
    
    
    */
    // 设备绑定
    public function bind()
    {
        // 获取用户uid
        $data['uid'] = $_SESSION['homeuser']['id'];
        // 获取设备编码
        $device_code = I('post.device_code');

        // 查询设备是否存在
        $deviceInfo = M('Devices')->field('id,uid')->where("`device_code`={$device_code}")->find();

        // 判断设备是否已被绑定
        if(!empty($deviceInfo['uid'])){
            echo -2;
            exit;
        }

        // 如果设备部不存在返回-1
        if(empty($deviceInfo)){
            echo -1;
            exit;
        }else{
            $data['updatetime'] = time();
            // 绑定设备
            $res = M('Devices')->where("`device_code`={$device_code}")->save($data);

            // 查询当前用户是否有设备
            $currenRes = M('currentDevices')->where('`uid`='.$_SESSION['homeuser']['id'])->find()['id'];

            Log::write(json_encode($currenRes), '存储数据');

            // 查询设备的ID
            $currentDevicesData['did'] = M('Devices')->where("`device_code`={$device_code}")->find()['id'];
            // echo 1;die;
            // 将设备的ID存储起来
            $did = $currentDevicesData['did'];

            // 判断当前设备是否存在
            if(!empty($currenRes)){
                // 设备存在，则更新当前设备
                $currentDevicesRes = M('currentDevices')->where('`uid`='.$data['uid'])->save($currentDevicesData);

            }else{
                // 设备不存在，则新增当前设备
                $currentDevicesData['uid'] = $data['uid'];
                $currentDevicesRes = M('currentDevices')->add($currentDevicesData);
            }
            if($currentDevicesRes) $_SESSION['homeuser']['did'] = $did;
            
            
            // 写入设备详细数据
            $devicesStatuData['DeviceID'] = $device_code;
            if(!M('devicesStatu')->where($devicesStatuData)->find()) M('devicesStatu')->add($devicesStatuData);
            
            if($res){
                echo 1;
                exit;
            }else{
                // 设备绑定失败
                echo -3;
                exit;
            }  
        }
    }

}

