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
    		// 模拟数据
    		//$_POST['data'] = '[{"sid":3,"num":5},{"fid":4,"num":3},{"fid":6,"num":2},{"fid":1,"num":1}]';

    		// 将json数据转换数组
	    	$data = json_decode($_POST['data'],true);
	    	// 定义数组准备装成功信息
    		$msg = array();
    		// 定义一个数组装失败信息
    		$msgerror = array();
	    	// 遍历添加购物车
	    	foreach ($data as $value) {
	    		// 判断是否有套餐
	    		if(!empty($value['sid'])){
	    			// 将套餐添加到购物车
	    			// 实例化购物车套餐对象
	    			$cartSetmeal = M('cartSetmeal');
	    			// 用户ID
	    			$finddata['uid'] = $_SESSION['homeuser']['id'];
	    			// 套餐ID
	    			$finddata['sid'] = $value['sid'];
	    			// 查询用户购物车是否已经存在该套餐"`sid`='{$value['sid']}'"
	    			$setmeal = $cartSetmeal->field('id,num')->where($finddata)->find();

	    			// 判断查询结果
	    			if(empty($setmeal)){
	    				// 套餐不存在，新增
	    				// 用户ID
	    				$adddata['uid'] = $_SESSION['homeuser']['id'];
	    				// 套餐ID
	    				$adddata['sid'] = $value['sid'];
	    				//套餐数量
	    				$adddata['num'] = $value['num'];
	    				// 创建时间
	    				$adddata['create_time'] = time();
	    				// 执行添加并返回结果
	    				$res = $cartSetmeal->add($adddata);
	    				// 判断添加结果
	    				if($res){
	    					// 套餐添加成功
	    					$msg[] = array(
	    						'error' => 0,
	    						'sid' 	=>$value['sid'],
	    						'num'	=>$value['num']
	    					);

	    				}else{
	    					// 套餐添加失败
	    					$msgerror[] = array(
	    						'error' => '套餐添加失败',
	    						'sid' 	=>$value['sid'],
	    						'num'	=>$value['num']
	    					);
	    				}
	    			}else{
	    				// 套餐已存在，更新
	    				// 套餐数量
	    				$savedata['num'] = $value['num']+$setmeal['num'];
	    				// 更新时间
	    				$savedata['update_time'] = time();
	    				$res = $cartSetmeal->where("`id`={$setmeal['id']}")->save($savedata);
	    				// 判断更新结果
	    				if($res){
	    					// 套餐更新成功
	    					$msg[] = array(
	    						'error' => 0,
	    						'sid' 	=>$value['sid'],
	    						'num'	=>$value['num']
	    					);		

	    				}else{
	    					$msgerror[] = array(
	    						'error' => '套餐更新失败',
	    						'sid' 	=>$value['sid'],
	    						'num'	=>$value['num']
	    					);
	    					//echo '套餐更新失败';

	    				}
	    			}
	    		}

	    		// 判断是否有滤芯
	    		if(!empty($value['fid'])){
	    			// 将滤芯添加到购物车
	    			$cartFilters = M('cartFilters');
	    			// 用户ID
	    			$finddata['uid'] = $_SESSION['homeuser']['id'];
	    			// 套餐ID
	    			$finddata['fid'] = $value['fid'];
	    			// 查询用户购物车是否已经存在该滤芯
	    			$filters = $cartFilters->field('id,num')->where($finddata)->find();

	    			// 判断查询结果
	    			if(empty($filters)){
	    				// 滤芯不存在，添加
	    				// 用户ID
	    				$adddata['uid'] = $_SESSION['homeuser']['id'];
	    				// 套餐ID
	    				$adddata['fid'] = $value['fid'];
	    				//套餐数量
	    				$adddata['num'] = $value['num'];
	    				// 创建时间
	    				$adddata['create_time'] = time();
	    				// 执行添加并返回结果
	    				$res = $cartFilters->add($adddata);
	    				// 判断添加结果
	    				if($res){
	    					// 滤芯添加成功
	    					$msg[] = array(
	    						'error' => 0,
	    						'fid' 	=>$value['fid'],
	    						'num'	=>$value['num']
	    					);


	    				}else{
	    					$msgerror[] = array(
	    						'error' => '滤芯添加失败',
	    						'fid' 	=>$value['fid'],
	    						'num'	=>$value['num']
	    					);
	    					//$res[] = "{'error':3,'fid':{$value['fid']},'num':{$value['num']}}";
	    					//echo '滤芯添加失败';
	    				}
	    			}else{
	    				// 滤芯已存在，更新
	    				// 滤芯数量 = 原来购物车滤芯 + 现在添加滤芯数量
	    				$savedata['num'] = $value['num']+$filters['num'];
	    				// 更新时间
	    				$savedata['update_time'] = time();
	    				$res = $cartFilters->where("`id`={$filters['id']}")->save($savedata);
	    				// 判断更新结果
	    				if($res){	
	    					$msg[] = array(
	    						'error' => 0,
	    						'fid' 	=>$value['fid'],
	    						'num'	=>$value['num']
	    					);

	    				}else{
	    					$msgerror[] = array(
	    						'error' => '滤芯更新失败',
	    						'fid' 	=>$value['fid'],
	    						'num'	=>$value['num']
	    					);
	    					//echo '滤芯更新失败';
	    					//$res[] = "{'error':4,'fid':{$value['fid']},'num':{$value['num']}}";
	    					
	    				}
	    			}
	    		}
	    	}
	    	// AJAX返回
	    	if(empty($msgerror)){
	    		// 状态码
	    		$feedback['status'] = 1;
	    		// 添加成功的产品信息
	    		$feedback['msg'] = $msg;
	    		$this->ajaxReturn($feedback);
	    	}else{
	    		// 状态码
	    		$feedback['status'] = -1;
	    		// 添加失败的产品信息
	    		$feedback['msgerror'] = $msgerror;
	    		$this->ajaxReturn($feedback);
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
