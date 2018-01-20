<?php
namespace Admin\Controller;
use Think\Controller;
use Admin\Controller\CommonController;
class IndexController extends CommonController {
    public function index(){
    	if (IS_AJAX) {
    		// 充值数额统计数量（本月列表显示）
	    	$flows = D('Flow')->getTotalByEveryDay();

	    	// 滤芯订单数量（以发货及未发货数量->以发货及未发货列表）
	    	$order_filters = D('OrderFilter')->getAll();

	    	// 保修数量统计->保修列表
	    	$repairs = D('Repair')->getAll();

	    	// 建议数量统计->建议列表
	    	$feeds = D('Feeds')->getAll();

	    	$data = [
	    		'flows' => $flows,
	    		'order_filters' => $order_filters,
	    		'$repairs' => $repairs,
	    		'feeds' => $feeds
	    	];
	    	$this->ajaxReturn($data);
    	}
        $this->display('index');
    }

    public function welcome()
    {
        $this->show('<h1>欢迎回来！</h1>');
    }
}

