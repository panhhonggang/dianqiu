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
                      ->limit($page->firstRow.','.$page->listRows)
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
        if ($_POST['express'] && $_POST['mca']) {
            $work = M("orders");
            $order_id = $_GET['order_id'];
            $data['is_receipt'] = $is_receipt;
            $data['express'] = $_POST['express'];
            $data['mca'] = $_POST['mca'];
            // dump($data);die;
            $res = $work->where('order_id='.$order_id)->save($data); 
            if ($res) {
                $this->success('发货成功！',U('Orders/index'));        
            } else {
                $this->error('修改失败啦！');
            }
        }else{
            $this->error('请将快递信息输入完整！');
        }
        
    }

    /**
     * 订单详情
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function detail($order_id)
    {

        $orders = D("orders");
        $list = $orders->where('pub_orders.order_id='.$order_id)->getAll();
        $this->ajaxReturn($list,'JSON');

    }
 
    
    
}