<?php
namespace Admin\Model;

use Think\Model;

/**
 * Class 订单数据处理
 * @package Admin\Model
 * @author 潘宏钢 <619328391@qq.com>
 */
class OrdersModel extends Model
{   

    // 处理查询数据
    public function getAll()
    {
        // $res = $this->join('LEFT JOIN pub_order_filter ON pub_orders.order_id = pub_order_filter.order_id')
        //               ->join('LEFT JOIN pub_order_setmeal ON pub_orders.order_id = pub_order_setmeal.order_id')
        //               ->field('pub_order_filter.id filter_id,pub_order_filter.filtername,pub_order_filter.alias,pub_order_filter.picpath,pub_order_filter.price filter_price,pub_order_filter.goods_num filter_goods_num,pub_order_filter.goods_price fliter_goods_price,pub_order_setmeal.*')
        //               ->select();
        $order = $this->select();
        $filter = $this->join('LEFT JOIN pub_order_filter ON pub_orders.order_id = pub_order_filter.order_id')
                      ->field('pub_order_filter.*')
                      ->select();
        $setmeal = $this->join('LEFT JOIN pub_order_setmeal ON pub_orders.order_id = pub_order_setmeal.order_id')
                      ->field('pub_order_setmeal.*')
                      ->select();              
        // dump($order);
        // dump($filter);
        // dump($setmeal);
        $info['order'] = $order; 
        $info['filter'] = $filter; 
        $info['setmeal'] = $setmeal; 
        // foreach ($res as $key => $val) {
        //     foreach ($val as $keys => $value) {
        //         $ress[$keys][] = $value;   
        //     }
        // }
        // $ress['filter_id'] = array_unique($ress['filter_id']);
        // $ress['filtername'] = array_unique($ress['filtername']);
        // $ress['alias'] = array_unique($ress['alias']);
        // $ress['picpath'] = array_unique($ress['picpath']);
        // $ress['filter_price'] = array_unique($ress['filter_price']);
        // $ress['filter_goods_num'] = array_unique($ress['filter_goods_num']);
        // $ress['fliter_goods_price'] = array_unique($ress['fliter_goods_price']);
        // $ress['id'] = array_unique($ress['id']);
        // $ress['order_id'] = array_unique($ress['order_id']);
        // $ress['setmeal_id'] = array_unique($ress['setmeal_id']);
        // $ress['type_id'] = array_unique($ress['type_id']);
        // $ress['remodel'] = array_unique($ress['remodel']);
        // $ress['money'] = array_unique($ress['money']);
        // $ress['flow'] = array_unique($ress['flow']);
        // $ress['describe'] = array_unique($ress['describe']);
        // $ress['goods_num'] = array_unique($ress['goods_num']);
        // $ress['goods_price'] = array_unique($ress['goods_price']);
        // $ress['created_at'] = array_unique($ress['created_at']);
        // $ress['updated_at'] = array_unique($ress['updated_at']);
       
        return $info;
    }


}