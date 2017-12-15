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
        // 获取用户uid
        $uid = $_SESSION['homeuser']['id'];
        // 判断是否点击立即购买过去结算
        if($uid){
            // 遍历购物车
            // 遍历用户购物车套餐
            $setmeal = M('cartSetmeal')
            ->where("`uid`='{$uid}' AND `num`>0")
            ->join('pub_setmeal ON pub_setmeal.id = pub_cart_setmeal.sid')
            ->select();

            // 遍历用户购物车滤芯
            $filters = M('cartFilters')
            ->where("`uid`='{$uid}'  AND `num`>0")
            ->join('pub_filters ON pub_filters.id = pub_cart_filters.fid')
            ->select();

            $totalAmount = 0;
            $totalNum = 0;
            // 统计套餐总金额
            foreach ($setmeal as $value) {
                $totalAmount += $value['num']*$value['money'];
                $totalNum += $value['num'];
            }
            // 统计滤芯总金额
            foreach ($filters as $value) {
                $totalAmount += $value['num']*$value['price'];
                $totalNum += $value['num'];
            }

            // 分配数据
            $this->assign('setmeal',$setmeal);
            $this->assign('filters',$filters);
            $this->assign('totalAmount',$totalAmount);
            $this->assign('totalNum',$totalNum);

            // 显示模板
            $this->display(); 
        } 
    }

	//待付款订单
    public function surePay()
    {


        // 显示模板
        $this->display();        
    }

}