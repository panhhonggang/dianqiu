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

        $map = '';
        // 搜索功能

        if (trim(I('post.order_id'))) {
            $map['pub_orders.order_id'] = array('like','%'.trim(I('post.order_id')).'%');
        }
        if (trim(I('post.nickname'))) {
            $map['pub_wechat.nickname'] = array('like','%'.trim(I('post.nickname')).'%');
        }
        if (trim(I('post.total_num'))) {
            $map['pub_orders.total_num'] = array('like','%'.trim(I('post.total_num')).'%');
        }
        if (trim(I('post.name'))) {
            $map['pub_express_information.name'] = array('like','%'.trim(I('post.name')).'%');
        }
        if (trim(I('post.phone'))) {
            $map['pub_express_information.phone'] = array('like','%'.trim(I('post.phone')).'%');
        }
        if (trim(I('post.addres'))) {
            $map['pub_express_information.addres'] = array('like','%'.trim(I('post.addres')).'%');
        }

        if($this->get_level()){
            $map['pub_binding.vid'] = $_SESSION['adminuser']['id'];
        }

        $mintotal_price = trim(I('post.mintotal_price'))?:0;
        $maxtotal_price = trim(I('post.maxtotal_price'))?:-1;
        if (is_numeric($maxtotal_price)) {
            $map['pub_orders.total_price'] = array(array('egt',$mintotal_price*100),array('elt',$maxtotal_price*100));
        }
        if ($maxtotal_price < 0) {
            $map['pub_orders.total_price'] = array(array('egt',$mintotal_price*100));
        }
        $mincreated_at = strtotime(trim(I('post.mincreated_at')))?:0;
         $maxcreated_at = strtotime(trim(I('post.maxcreated_at')))?:-1;
         if (is_numeric($maxcreated_at)) {
             $map['pub_orders.created_at'] = array(array('egt',$mincreated_at),array('elt',$maxcreated_at));
         }
         if ($maxcreated_at < 0) {
             $map['pub_orders.created_at'] = array(array('egt',$mincreated_at));
         }
        // 删除数组中为空的值
        $map = array_filter($map, function ($v) {
            if ($v != "") {
                return true;
            }
            return false;
        });
        $order = M('orders');
        // PHPExcel 导出数据 
        if (I('output') == 1) {
            $data = $order->where($map)
                      ->join('pub_devices ON pub_orders.device_id = pub_devices.id')
                      ->join('pub_binding ON pub_devices.id = pub_binding.did ')
                      ->join('pub_users ON pub_orders.user_id = pub_users.id')
                      ->join('pub_express_information ON pub_orders.express_id = pub_express_information.id')
                      ->join('pub_wechat ON pub_users.open_id = pub_wechat.open_id')
                      ->field('pub_orders.order_id,pub_wechat.nickname,pub_orders.total_num,pub_orders.total_price,pub_express_information.name,pub_express_information.phone,pub_express_information.addres,pub_orders.is_pay,pub_orders.is_receipt,pub_orders.is_ship,pub_orders.is_recharge,pub_orders.created_at')
                      ->select();
            // 数组中枚举数值替换
            $arr = [
                'is_pay'=>['0'=>'未付款','1'=>'已付款','2'=>'已取消'],
                'is_receipt'=>['0'=>'未发货','1'=>'已发货'],
                'is_ship'=>['0'=>'未收货','1'=>'已收货'],
                'is_recharge'=>['0'=>'未充值','1'=>'已充值'],
                'created_at'=>'Y-m-d H:i:s',
            ];
            replace_value($data,$arr);

            $filename = '订单列表数据';
            $title = '订单列表';
            $cellName = ['订单编号','下单用户','购买商品数量','购买总额','收货人','收货人电话','收货地址','是否付款','是否发货','是否收获','是否充值','下单时间'];
            // dump($data);die;
            $myexcel = new \Org\Util\MYExcel($filename,$title,$cellName,$data);
            $myexcel->output();
            return ;
        }


        
        $total = $order->where($map)
                      ->join('pub_devices ON pub_orders.device_id = pub_devices.id')
                      ->join('pub_binding ON pub_devices.id = pub_binding.did ')
                      ->join('pub_users ON pub_orders.user_id = pub_users.id')
                      ->join('pub_express_information ON pub_orders.express_id = pub_express_information.id')
                      ->join('pub_wechat ON pub_users.open_id = pub_wechat.open_id')
                      ->field('pub_orders.*,pub_wechat.nickname,pub_express_information.name,pub_express_information.phone,pub_express_information.addres')
                        ->count();
        $page  = new \Think\Page($total,8);
        $pageButton =$page->show();

        $list = $order->where($map)
                      ->join('pub_devices ON pub_orders.device_id = pub_devices.id')
                      ->join('pub_binding ON pub_devices.id = pub_binding.did ')
                      ->join('pub_users ON pub_orders.user_id = pub_users.id')
                      ->join('pub_express_information ON pub_orders.express_id = pub_express_information.id')
                      ->join('pub_wechat ON pub_users.open_id = pub_wechat.open_id')
                      ->join('pub_vendors ON pub_binding.vid = pub_vendors.id')
                      ->field('pub_orders.*,pub_binding.vid,pub_vendors.name vname,pub_wechat.nickname,pub_express_information.name,pub_express_information.phone,pub_express_information.addres')
                      ->order('pub_orders.created_at desc')
                      ->limit($page->firstRow.','.$page->listRows)
                      ->select();

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
         $order = $orders->where('pub_orders.order_id='.$order_id.' AND status=1')->select();
        $filter = $orders->where('pub_orders.order_id='.$order_id.' AND status=1')->join('LEFT JOIN pub_order_filter ON pub_orders.order_id = pub_order_filter.order_id')
                      ->field('pub_order_filter.*')
                      ->select();
        $setmeal = $orders->where('pub_orders.order_id='.$order_id.' AND status=1')->join('LEFT JOIN pub_order_setmeal ON pub_orders.order_id = pub_order_setmeal.order_id')
                      ->field('pub_order_setmeal.*')
                      ->select();              
       
        $info['order'] = $order; 
        $info['filter'] = $filter; 
        $info['setmeal'] = $setmeal; 
        
        // $list = $orders->where('pub_orders.order_id='.$order_id)->getAll();
        // dump($info);
        $this->ajaxReturn($info,'JSON');

    }
 
    
    
}