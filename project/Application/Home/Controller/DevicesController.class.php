<?php
namespace Home\Controller;
use Think\Controller;

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
        // 分配数据
        $this->assign('devices',$devices);
        $this->assign('currentDevices',$currentDevices);

        // 显示模板
        $this->display();
    }

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
        if(!empty($deviceInfo['uid'] || $deviceInfo['uid']==0)){
            echo -2;
            exit;
        }

        // 如果设备部不存在返回-1
        if(empty($deviceInfo)){
            echo -1;
            exit;
        }else{
            // 绑定设备
            $res = M('Devices')->where("`device_code`={$device_code}")->save($data);

            if($res){
                echo 1;
            }else{
                // 设备绑定失败
                echo -3;
            }  
        }
    }

}

