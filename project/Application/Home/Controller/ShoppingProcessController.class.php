<?php
namespace Home\Controller;
use Think\Controller;

/**
 * 订单确认
 */
class ShoppingProcessController extends CommonController 
{
	// 快递确认
    public function sureBill()
    {


        // 显示模板
        $this->display();        
    }

	//待付款订单
    public function surePay()
    {


        // 显示模板
        $this->display();        
    }

}