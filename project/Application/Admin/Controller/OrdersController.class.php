<?php
namespace Admin\Controller;
use Think\Controller;

/**
 * 订单控制器
 * 
 * @author 潘宏钢 <619328391@qq.com>
 */

class OrdersController extends CommonController 
{
	/**
     * 订单列表
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function index()
    {	
        // 根据用户昵称进行搜索
        $map = '';
    	if(!empty($_GET['name'])) $map['name'] = array('like',"%{$_GET['name']}%");
        $map['is_pay'] = '1'; 

        $order = M('orders');

        $total = $order->where($map)
                      ->join('pub_devices ON pub_orders.device_id = pub_devices.id')
                      ->join('pub_users ON pub_orders.user_id = pub_users.id')
                      ->join('pub_express_information ON pub_orders.express_id = pub_express_information.id')
                      ->join('pub_wechat ON pub_users.open_id = pub_wechat.open_id')
                      ->field('pub_orders.*,pub_wechat.nickname,pub_express_information.name,pub_express_information.phone,pub_express_information.addres')
                        ->count();
        $page  = new \Think\Page($total,8);
        $pageButton =$page->show();

        $list = $order->where($map)
                      ->join('pub_devices ON pub_orders.device_id = pub_devices.id')
                      ->join('pub_users ON pub_orders.user_id = pub_users.id')
                      ->join('pub_express_information ON pub_orders.express_id = pub_express_information.id')
                      ->join('pub_wechat ON pub_users.open_id = pub_wechat.open_id')
                      ->field('pub_orders.*,pub_wechat.nickname,pub_express_information.name,pub_express_information.phone,pub_express_information.addres')
                      ->select();
        // dump($list);

        $this->assign('list',$list);
        $this->assign('button',$pageButton);
        $this->display();
    }

    

    /**
     * 更改状态
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function edit($order_id,$is_receipt)
    {
        dump($_POST);die;
        $work = M("orders");
        $data['is_receipt'] = $_GET['is_receipt'];
        $res = $work->where('order_id='.$order_id)->save($data); 
        if ($res) {
            $this->success('发货成功！',U('Orders/index'));        
        } else {
            $this->error('修改失败啦！');
        }
    }

    /**
     * 订单详情
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function detail($order_id)
    {

        $orders = M("orders");
        $res = $orders->where('pub_orders.order_id='.$order_id)
                      ->join('LEFT JOIN pub_order_filter ON pub_orders.order_id = pub_order_filter.order_id')
                      ->join('LEFT JOIN pub_order_setmeal ON pub_orders.order_id = pub_order_setmeal.order_id')
                      ->field('pub_order_filter.id fliter_id,pub_order_filter.filtername,pub_order_filter.alias,pub_order_filter.picpath,pub_order_filter.price filter_price,pub_order_filter.goods_num filter_goods_num,pub_order_filter.goods_price fliter_goods_price,pub_order_setmeal.*')
                      ->select(); 
        // dump($res);die;
        $this->ajaxReturn($res,'JSON');

    }
 
    
    
}