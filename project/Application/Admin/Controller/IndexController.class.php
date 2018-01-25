<?php
namespace Admin\Controller;
use Think\Controller;
use Admin\Controller\CommonController;
class IndexController extends CommonController {
    public function index(){
    	if (IS_AJAX) {
    		// 充值数额统计数量 （本月列表显示）
	    	$flows = D('Flow')->getTotalByEveryDay();

	    	// 滤芯订单数量（已发货及未发货数量->以发货及未发货列表）
	    	$order_filters = D('Orders')
	    						->join('pub_express_information ON pub_orders.express_id = pub_express_information.id')
	    						->field('distinct(order_id)')
	    	                    ->select();
	    	$order_filter['total'] = count($order_filters); 

	    	// 保修数量统计->保修列表  
	    	$repairs['total'] = D('Repair')->count();	    	

	    	// 建议数量统计->建议列表
	    	$feeds['total'] = D('Feeds')->count();

	    	$data = [
	    		'flows' => $flows,
	    		'order_filters' => $order_filter,
	    		'repairs' => $repairs,
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

