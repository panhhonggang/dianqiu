<?php
namespace Home\Controller;
use Think\Controller;
use \Org\Util\WeixinJssdk;

/**
 * 订单
 */
class OrdersController extends CommonController 
{
	//全部订单
    public function orderAll()
    {
        // 获取用户uid
        $uid = $_SESSION['homeuser']['id'];
        if($uid){
     

            
        }
           
        // 显示模板
        $this->display();        
    }

	//待付款订单
    public function orderPay()
    {
        // 获取用户uid
        $uid = $_SESSION['homeuser']['id'];

        if($uid){
            // 查询用户全部未支付订单号
            $orders = M('Orders')->order('id desc')->field('id,order_id,created_at,total_num,total_price')->where("`user_id`={$uid} AND `is_pay`=0")->select();
            // 实例化订单滤芯对象
            $orderFilter = M('OrderFilter');
            // 实例化订单套餐对象
            $orderSetmeal = M('OrderSetmeal');
            // 准备数组装未支付订单信息
            $ordersData = array();

            // 遍历订单未支付订单号
            foreach ($orders as $value) {
                // 订单编号
                $ordersData["{$value['order_id']}"]['order_id'] = $value['order_id'];
                // 订单时间：
                $ordersData["{$value['order_id']}"]['created_at'] = $value['created_at'];
                // 订单数量
                $ordersData["{$value['order_id']}"]['total_num'] = $value['total_num'];
                // 订单金额
                $ordersData["{$value['order_id']}"]['total_price'] = $value['total_price'];
                // 获取订单套餐明细
                $ordersData["{$value['order_id']}"]['orderSetmeal'] = $orderSetmeal->where("`order_id`='{$value['order_id']}'")->select();
                // 获取订单滤芯明细
                $ordersData["{$value['order_id']}"]['orderFilter'] = $orderFilter->where("`order_id`='{$value['order_id']}'")->select();
            }
            //show($ordersData);die;
            // 分配数据
            $this->assign('ordersData',$ordersData);

            //调用微信JS-SDK类获取签名需要用到的数据
            $weixin = new WeixinJssdk;
            $signPackage = $weixin->getSignPackage();
            // 查询用户微信中的openid
            $openId = $weixin->GetOpenid();

            //分配数据        
            $this->assign('info',$signPackage);
            $this->assign('openId',$openId);

            // 显示模板
            $this->display();       
        }
   
    }

	//待发货订单
    public function orderSend()
    {
        // 获取用户uid
        $uid = $_SESSION['homeuser']['id'];

        if($uid){
            // 查询用户全部未支付订单号
            $orders = M('Orders')->order('id desc')->field('id,order_id,created_at,total_num,total_price')->where("`user_id`={$uid} AND `is_receipt`=0 AND `is_pay`=1")->select();
            // 实例化订单滤芯对象
            $orderFilter = M('OrderFilter');
            // 实例化订单套餐对象
            $orderSetmeal = M('OrderSetmeal');
            // 准备数组装未支付订单信息
            $ordersData = array();

            // 遍历订单未支付订单号
            foreach ($orders as $value) {
                // 订单编号
                $ordersData["{$value['order_id']}"]['order_id'] = $value['order_id'];
                // 订单时间：
                $ordersData["{$value['order_id']}"]['created_at'] = $value['created_at'];
                // 订单数量
                $ordersData["{$value['order_id']}"]['total_num'] = $value['total_num'];
                // 订单金额
                $ordersData["{$value['order_id']}"]['total_price'] = $value['total_price'];
                // 获取订单套餐明细
                $ordersData["{$value['order_id']}"]['orderSetmeal'] = $orderSetmeal->where("`order_id`='{$value['order_id']}'")->select();
                // 获取订单滤芯明细
                $ordersData["{$value['order_id']}"]['orderFilter'] = $orderFilter->where("`order_id`='{$value['order_id']}'")->select();
            }
            //show($ordersData);die;
            // 分配数据
            $this->assign('ordersData',$ordersData);

            // 显示模板
            $this->display();       
        }    
    }

	//待收货订单
    public function orderTake()
    {
        // 获取用户uid
        $uid = $_SESSION['homeuser']['id'];

        if($uid){
            // 查询用户全部未支付订单号
            $orders = M('Orders')->order('id desc')->field('id,order_id,created_at,total_num,total_price')->where("`user_id`={$uid} AND `is_receipt`=1 AND `is_ship`=0")->select();
            // 实例化订单滤芯对象
            $orderFilter = M('OrderFilter');
            // 实例化订单套餐对象
            $orderSetmeal = M('OrderSetmeal');
            // 准备数组装未支付订单信息
            $ordersData = array();

            // 遍历订单未支付订单号
            foreach ($orders as $value) {
                // 订单编号
                $ordersData["{$value['order_id']}"]['order_id'] = $value['order_id'];
                // 订单时间：
                $ordersData["{$value['order_id']}"]['created_at'] = $value['created_at'];
                // 订单数量
                $ordersData["{$value['order_id']}"]['total_num'] = $value['total_num'];
                // 订单金额
                $ordersData["{$value['order_id']}"]['total_price'] = $value['total_price'];
                // 获取订单套餐明细
                $ordersData["{$value['order_id']}"]['orderSetmeal'] = $orderSetmeal->where("`order_id`='{$value['order_id']}'")->select();
                // 获取订单滤芯明细
                $ordersData["{$value['order_id']}"]['orderFilter'] = $orderFilter->where("`order_id`='{$value['order_id']}'")->select();
            }
            
            // 分配数据
            $this->assign('ordersData',$ordersData);

            // 显示模板
            $this->display();       
        }        
    }

    // 取消订单
    public function cancel()
    {

        // 获取用户uid
        $data['user_id'] = $_SESSION['homeuser']['id'];
        $data['order_id'] = I('post.oid');
        $date['is_pay'] = 2;
        $date['updated_at'] = time();
        $res = M('Orders')->where($data)->save($date);;
        // show($res);die;
        if($res){
            echo 1;
        }else{
            echo -1;
        }
    }

    // 确认收货
    public function confirm()
    {
        // 获取用户uid
        $data['user_id'] = $_SESSION['homeuser']['id'];
        $data['order_id'] = I('post.oid');
        $date['is_ship'] = 1;
        $date['updated_at'] = time();
        $res = M('Orders')->where($data)->save($date);;
        // show($res);die;
        if($res){
            echo 1;
        }else{
            echo -1;
        }
    }
}