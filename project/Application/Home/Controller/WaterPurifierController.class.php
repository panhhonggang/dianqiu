<?php
namespace Home\Controller;
use Think\Controller;
use \Org\Util\WeixinJssdk;

class WaterPurifierController extends CommonController 
{
    // 净水机首页
    public function index()
    {
        // 显示模板
        $this->display();
    }

    // 净水记录页面
    public function record()
    {
        $id = $_SESSION['homeuser']['did'];

        $map['dcode'] = M('devices')->where('id='.$id)->getField('device_code');
        $map['date'] = date("Ym", time());
        $data = M('Tds')->where($map)->select();
        $this->assign('data', $data);

        $this->display();
    }



    // 查询净水记录
    public function getTds()
    {
        try {
            $where['id'] = $_SESSION['homeuser']['did'];

            $map['dcode'] = M('devices')->where($where)->getField('device_code');
            $map['date'] = I('post.month');
            $data = M('Tds')->where($map)->select();
            $this->ajaxReturn($data);
        } catch (\Exception $e) {
            $err = [
                'code' => $e->getCode(),
                'msg' => $e->getMessage(),
            ];
            $this->ajaxReturn($err);
        }
    }
    
    // 绑定指引页面
    public function binding()
    {
        // 获取用户uid
        $uid = $_SESSION['homeuser']['id'];

        if($uid){
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
    

}

