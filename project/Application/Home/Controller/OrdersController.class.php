<?php
namespace Home\Controller;
use Think\Controller;

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
           $orders = M('Orders');
            
        }
           
        // 显示模板
        $this->display();        
    }

	//待付款订单
    public function orderPay()
    {

        // 显示模板
        $this->display();        
    }

	//待发货订单
    public function orderSend()
    {


        // 显示模板
        $this->display();        
    }

	//待收货订单
    public function orderTake()
    {


        // 显示模板
        $this->display();        
    }
}