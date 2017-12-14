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

	// 加入购物车
    public function shopAdd()
    {
    	// 接收POST过来的添加购物车数据
    	if(IS_POST){
    		// 将json数据转换数组
	    	$data = json_decode($_POST['data'],true);

	    	// 遍历添加购物车
	    	foreach ($data as $value) {
	    		// 判断是否有套餐
	    		if(!empty($value['sid'])){
	    			// 将套餐添加到购物车
	    			
	    		}

	    		// 判断是否有滤芯
	    		if(!empty($value['fid'])){
	    			// 将滤芯添加到购物车
	    		}
	    		// print_r($value);
	    	}
	    	
	        
    	}
    }	
}

// Array
// (
//     [0] => Array
//         (
//             [sid] => 1
//             [num] => 1
//         )

//     [1] => Array
//         (
//             [fid] => 4
//             [num] => 4
//         )

//     [2] => Array
//         (
//             [fid] => 6
//             [num] => 3
//         )

//     [3] => Array
//         (
//             [fid] => 1
//             [num] => 1
//         )

// )
