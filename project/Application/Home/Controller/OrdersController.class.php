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
            
            // 待付款订单
            // 查询用户全部未支付订单号
            $orders = M('Orders')->order('created_at desc')->field('id,order_id,created_at,total_num,total_price')->where("`user_id`={$uid} AND `is_pay`=0 AND `status`=1")->select();
            // 实例化订单滤芯对象
            $orderFilter = M('OrderFilter');
            // 实例化订单套餐对象
            $orderSetmeal = M('OrderSetmeal');
            // 准备数组装未支付订单信息
            $orderPay = array();

            // 遍历订单未支付订单号
            foreach ($orders as $value) {
                // 订单编号
                $orderPay["{$value['order_id']}"]['order_id'] = $value['order_id'];
                // 订单时间：
                $orderPay["{$value['order_id']}"]['created_at'] = $value['created_at'];
                // 订单数量
                $orderPay["{$value['order_id']}"]['total_num'] = $value['total_num'];
                // 订单金额
                $orderPay["{$value['order_id']}"]['total_price'] = $value['total_price'];
                // 获取订单套餐明细
                $orderPay["{$value['order_id']}"]['orderSetmeal'] = $orderSetmeal->where("`order_id`='{$value['order_id']}'")->select();
                // 获取订单滤芯明细
                $orderPay["{$value['order_id']}"]['orderFilter'] = $orderFilter->where("`order_id`='{$value['order_id']}'")->select();
            }
            // 分配数据
            $this->assign('orderPay',$orderPay);

            // 待发货订单
            // 查询用户全部待发货订单
            $orders = M('Orders')->order('created_at desc')->field('id,order_id,created_at,total_num,total_price')->where("`user_id`={$uid} AND `is_receipt`=0 AND `is_pay`=1 AND `status`=1")->select();
            // 准备数组装待发货订单信息
            $orderSend = array();

            // 遍历订单未支付订单号
            foreach ($orders as $value) {

                $emptyFulfil = $orderFilter->where("`order_id`='{$value['order_id']}'")->select();

                if($emptyFulfil){
                    // 订单编号
                    $orderSend["{$value['order_id']}"]['order_id'] = $value['order_id'];
                    // 订单时间：
                    $orderSend["{$value['order_id']}"]['created_at'] = $value['created_at'];
                    // 订单数量
                    $orderSend["{$value['order_id']}"]['total_num'] = $value['total_num'];
                    // 订单金额
                    $orderSend["{$value['order_id']}"]['total_price'] = $value['total_price'];
                    // 获取订单套餐明细
                    $orderSend["{$value['order_id']}"]['orderSetmeal'] = $orderSetmeal->where("`order_id`='{$value['order_id']}'")->select();
                    // 获取订单滤芯明细
                    $orderSend["{$value['order_id']}"]['orderFilter'] = $emptyFulfil;   
                }

            }

            // 分配数据
            $this->assign('orderSend',$orderSend);

            // 待收货订单
             $orders = M('Orders')->order('created_at desc')->field('id,order_id,created_at,total_num,total_price,express,mca')->where("`user_id`={$uid} AND `is_receipt`=1 AND `is_ship`=0 AND `status`=1")->select();
            // 准备数组装待收货订单信息
            $orderTake = array();
            // 遍历订单未支付订单号
            foreach ($orders as $value) {
                // 订单编号
                $orderTake["{$value['order_id']}"]['order_id'] = $value['order_id'];
                // 订单时间：
                $orderTake["{$value['order_id']}"]['created_at'] = $value['created_at'];
                // 订单数量
                $orderTake["{$value['order_id']}"]['total_num'] = $value['total_num'];
                // 订单金额
                $orderTake["{$value['order_id']}"]['total_price'] = $value['total_price'];
                // 快递名称
                $orderTake["{$value['order_id']}"]['express'] = $value['express'];
                // 快递单号
                $orderTake["{$value['order_id']}"]['mca'] = $value['mca'];
                // 获取订单套餐明细
                $orderTake["{$value['order_id']}"]['orderSetmeal'] = $orderSetmeal->where("`order_id`='{$value['order_id']}'")->select();
                // 获取订单滤芯明细
                $orderTake["{$value['order_id']}"]['orderFilter'] = $orderFilter->where("`order_id`='{$value['order_id']}'")->select();
            }
            // 分配数据
            $this->assign('orderTake',$orderTake);

            // 已完成订单
            $orders = M('Orders')->order('created_at desc')->field('id,order_id,created_at,total_num,total_price,express,mca')->where("`user_id`={$uid} AND `is_ship`=1 AND `is_recharge`=1 AND `status`=1")->select();
            // 准备数组装待收货订单信息
            $orderFulfil = array();

            // 包含滤芯产品
            // 遍历订单已收货和已充值订单号
            foreach ($orders as $value) {
                // 订单编号
                $orderFulfil["{$value['order_id']}"]['order_id'] = $value['order_id'];
                // 订单时间：
                $orderFulfil["{$value['order_id']}"]['created_at'] = $value['created_at'];
                // 订单数量
                $orderFulfil["{$value['order_id']}"]['total_num'] = $value['total_num'];
                // 订单金额
                $orderFulfil["{$value['order_id']}"]['total_price'] = $value['total_price'];
                // 快递名称
                $orderFulfil["{$value['order_id']}"]['express'] = $value['express'];
                // 快递单号
                $orderFulfil["{$value['order_id']}"]['mca'] = $value['mca'];
                // 获取订单套餐明细
                $orderFulfil["{$value['order_id']}"]['orderSetmeal'] = $orderSetmeal->where("`order_id`='{$value['order_id']}'")->select();
                // 获取订单滤芯明细
                $orderFulfil["{$value['order_id']}"]['orderFilter'] = $orderFilter->where("`order_id`='{$value['order_id']}'")->select();
            }

            // 包含滤芯产品已已收货
            // 已完成订单
            $orders = M('Orders')->order('created_at desc')->field('id,order_id,created_at,total_num,total_price,express,mca')->where("`user_id`={$uid} AND `is_ship`=1 AND `status`=1")->select();

            // 包含滤芯产品
            // 遍历订单已收货和已收货订单号
            foreach ($orders as $value) {
                $emptySetmeal = $orderSetmeal->where("`order_id`='{$value['order_id']}'")->select();
                if(empty($emptySetmeal)){
                    // 订单编号
                    $orderFulfil["{$value['order_id']}"]['order_id'] = $value['order_id'];
                    // 订单时间：
                    $orderFulfil["{$value['order_id']}"]['created_at'] = $value['created_at'];
                    // 订单数量
                    $orderFulfil["{$value['order_id']}"]['total_num'] = $value['total_num'];
                    // 订单数量
                    $orderFulfil["{$value['order_id']}"]['express'] = $value['express'];
                    // 订单数量
                    $orderFulfil["{$value['order_id']}"]['mca'] = $value['mca'];
                    // 订单金额
                    $orderFulfil["{$value['order_id']}"]['total_price'] = $value['total_price'];
                    // 获取订单滤芯明细
                    $orderFulfil["{$value['order_id']}"]['orderFilter'] = $orderFilter->where("`order_id`='{$value['order_id']}'")->select();
                }
            }


            // 已完成充值
            $orders = M('Orders')->order('created_at desc')->field('id,order_id,created_at,total_num,total_price')->where("`user_id`={$uid} AND `is_recharge`=1 AND `status`=1")->select();

            // 不包含滤芯产品
            // 遍历订单已充值订单号
            foreach ($orders as $value) {
                $emptyFulfil = $orderFilter->where("`order_id`='{$value['order_id']}'")->select();
                if(empty($emptyFulfil)){
                    // 订单编号
                    $orderFulfil["{$value['order_id']}"]['order_id'] = $value['order_id'];
                    // 订单时间：
                    $orderFulfil["{$value['order_id']}"]['created_at'] = $value['created_at'];
                    // 订单数量
                    $orderFulfil["{$value['order_id']}"]['total_num'] = $value['total_num'];
                    // 订单金额
                    $orderFulfil["{$value['order_id']}"]['total_price'] = $value['total_price'];
                    // 获取订单套餐明细
                    $orderFulfil["{$value['order_id']}"]['orderSetmeal'] = $orderSetmeal->where("`order_id`='{$value['order_id']}'")->select();
                }
            }
            //show($orderFulfil);die;
            // 分配数据
            $this->assign('orderFulfil',$orderFulfil);

            //调用微信JS-SDK类获取签名需要用到的数据
            $weixin = new WeixinJssdk;
            $signPackage = $weixin->getSignPackage();
            // 查询用户微信中的openid
            $openId = $_SESSION['homeuser']['open_id'];

            //分配数据        
            $this->assign('info',$signPackage);
            $this->assign('openId',$openId);
            // show('未付款:');
            // show($orderPay);
            // show('已付款，待发货:');
            // show($orderSend);
            // show('已发货，待收货:');
            // show($orderTake);
            // show('完成:');
            // show($orderFulfil);
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
            $orders = M('Orders')->order('id desc')->field('id,order_id,created_at,total_num,total_price')->where("`user_id`={$uid} AND `is_pay`=0 AND `status`=1")->select();
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
            //$openId = $weixin->GetOpenid();
            $openId = $_SESSION['homeuser']['open_id'];

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
            // 查询用户全部待发货订单
            $orders = M('Orders')->order('id desc')->field('id,order_id,created_at,total_num,total_price')->where("`user_id`={$uid} AND `is_receipt`=0 AND `is_pay`=1 AND `status`=1")->select();
            // 实例化订单滤芯对象
            $orderFilter = M('OrderFilter');
            // 实例化订单套餐对象
            $orderSetmeal = M('OrderSetmeal');
            // 准备数组装未支付订单信息
            $ordersData = array();

            // 遍历订单未支付订单号
            foreach ($orders as $value) {

                $emptyFulfil = $orderFilter->where("`order_id`='{$value['order_id']}'")->select();

                if($emptyFulfil){
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
                    $ordersData["{$value['order_id']}"]['orderFilter'] = $emptyFulfil; 
                }

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
            $orders = M('Orders')->order('id desc')->field('id,order_id,created_at,total_num,total_price,express,mca')->where("`user_id`={$uid} AND `is_receipt`=1 AND `is_ship`=0 AND `status`=1")->select();
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
                // 快递名称
                $ordersData["{$value['order_id']}"]['express'] = $value['express'];
                // 快递单号
                $ordersData["{$value['order_id']}"]['mca'] = $value['mca'];
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

    public function index()
    {
        $this->display();
    }
}