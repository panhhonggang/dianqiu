<?php
namespace Home\Controller;
use Think\Controller;

/**
 * 购物车
 */
class ShoppingCartController extends CommonController 
{
	//购物车
    public function shopBill()
    {


        // 显示模板
        $this->display();        
    }

	//购物车
    public function shopAdd()
    {
    	$data = json_decode($_POST['data'],true);

    	
        print_r($data);


    }
	
}