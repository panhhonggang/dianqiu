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
        $devices = M('Devices')->where("`uid`={$uid}")->field('device_statu,device_code')->select();

        show($devices);die;
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
        $this->display();
    }

}

