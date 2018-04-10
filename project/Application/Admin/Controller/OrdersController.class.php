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
            $map['o.order_id'] = array('like','%'.trim(I('post.order_id')).'%');
        }
        if (trim(I('post.nickname'))) {
            $map['w.nickname'] = array('like','%'.trim(I('post.nickname')).'%');
        }
        if (trim(I('post.total_num'))) {
            $map['o.total_num'] = trim(I('post.total_num'));
        }
        if (trim(I('post.name'))) {
            $map['e.name'] = array('like','%'.trim(I('post.name')).'%');
        }
        if (trim(I('post.phone'))) {
            $map['e.phone'] = array('like','%'.trim(I('post.phone')).'%');
        }
        if (trim(I('post.addres'))) {
            $map['e.addres'] = array('like','%'.trim(I('post.addres')).'%');
        }

        if($this->get_level()){
            $map['b.vid'] = $_SESSION['adminuser']['id'];
        }

        $mintotal_price = trim(I('post.mintotal_price'))?:null;
        $maxtotal_price = trim(I('post.maxtotal_price'))?:null;
        if (is_numeric($maxtotal_price)) {
            $map['o.total_price'] = array(array('egt',$mintotal_price*100),array('elt',$maxtotal_price*100));
        }
        if ($maxtotal_price < 0) {
            $map['o.total_price'] = array(array('egt',$mintotal_price*100));
        }

         $mincreated_at = strtotime(trim(I('post.mincreated_at')))?:null;
         $maxcreated_at = strtotime(trim(I('post.maxcreated_at')))?:null;
         if (is_numeric($maxcreated_at)) {
             $map['o.created_at'] = array(array('egt',$mincreated_at),array('elt',$maxcreated_at));
         }
         if ($maxcreated_at < 0) {
             $map['o.created_at'] = array(array('egt',$mincreated_at));
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
                        ->alias('o')
                        ->join('pub_devices d on o.device_id = d.id','LEFT')
                        ->join('pub_users u on o.user_id = u.id','LEFT')
                        ->join('pub_wechat w ON u.open_id = w.open_id','LEFT')
                        ->join('pub_express_information e ON o.express_id = e.id','LEFT')
                        ->join('pub_binding b on o.device_id = b.did','LEFT')
                        ->join('pub_vendors v on b.vid = v.id','LEFT')
                        ->order('o.created_at desc')
                        ->field([
                            'o.order_id','w.nickname','v.name vname','o.total_num','o.total_price','e.name','e.phone','e.addres','o.is_pay',
                            'o.is_receipt','o.is_ship','o.created_at'
                        ])
                        ->select();
            // 数组中枚举数值替换
            $arr = [
                'total_price'=>['price'],
                'created_at'=>['date','Y-m-d H:i:s']
            ];

            $data = replace_array_value($data,$arr);

            foreach($data as $key => $val){
                if($val['is_pay'] == 0){
                    $data[$key]['status'] = '待付款';
                } elseif($val['is_pay'] == 2){
                    $data[$key]['status'] = '订单已取消';
                } elseif($val['is_pay'] == 1){
                    if($val['is_receipt'] == 0){
                        $data[$key]['status'] = '待发货';
                    } else {
                        if($val['is_ship'] == 0){
                            $data[$key]['status'] = '待收货';
                        } elseif($val['is_ship'] == 1){
                            $data[$key]['status'] = '已收货';
                        } else{
                            $data[$key]['status'] = '订单完成';
                        }
                    }                   
                }                
                unset($data[$key]['is_pay']);
                unset($data[$key]['is_receipt']);
                unset($data[$key]['is_ship']);
            }

            $filename = '订单列表数据';
            $title = '订单列表';
            $cellName = ['订单编号','下单用户','经销商名称','购买商品数量','购买总额','收货人','收货人电话','收货地址','下单时间','订单状态'];
            // dump($data);die;
            $myexcel = new \Org\Util\MYExcel($filename,$title,$cellName,$data);
            $myexcel->output();
            return ;
        }

        $total = $order
                    ->where($map)
                    ->alias('o')
                    ->join('pub_devices d on o.device_id = d.id','LEFT')
                    ->join('pub_users u on o.user_id = u.id','LEFT')
                    ->join('pub_wechat w ON u.open_id = w.open_id','LEFT')
                    ->join('pub_express_information e ON o.express_id = e.id','LEFT')
                    ->join('pub_binding b on o.device_id = b.did','LEFT')
                    ->join('pub_vendors v on b.vid = v.id','LEFT')->count();
        $page  = new \Think\Page($total,8);
        $pageButton =$page->show();
        
        $list = $order
                    ->where($map)
                    ->alias('o')
                    ->join('pub_devices d on o.device_id = d.id','LEFT')
                    ->join('pub_users u on o.user_id = u.id','LEFT')
                    ->join('pub_wechat w ON u.open_id = w.open_id','LEFT')
                    ->join('pub_express_information e ON o.express_id = e.id','LEFT')
                    ->join('pub_binding b on o.device_id = b.did','LEFT')
                    ->join('pub_vendors v on b.vid = v.id','LEFT')
                    ->limit($page->firstRow.','.$page->listRows)
                    ->field([
                        'o.*','w.nickname','v.name vname','e.name','e.phone','e.addres'
                        ])
                    ->order('o.created_at desc')
                    ->select();
        // dump($list);die;
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