<?php
namespace Admin\Model;

use Think\Model;

/**
 * Class 滤芯订单数据处理
 * @package Admin\Model
 * @author 潘宏钢 <619328391@qq.com>
 */
class OrderFilterModel extends Model
{   

    /**
     * [getAll description]
     * @param  int $is_receipt 发货状态(0：未发货1：已发货)in(0,1)
     * @return array             [description]
     */
    public function getAll($is_receipt=null)
    {
       if (in_array($is_receipt, ['0','1'])) {
       		$maps['pub_orders.is_receipt'] = $is_receipt;
       } else {
       		$maps = '';
       }
       $total = $this
    				->where($maps)
                    ->count();
       $orderFilters = $this
                      ->join('LEFT JOIN pub_orders ON pub_order_filter.order_id = pub_orders.order_id')
                      ->where($maps)
                      ->field('pub_orders.*,pub_order_filter.*')
                      ->select();
        $data = ['total'=>$total,'list'=>$list];            
       return $orderFilters;       
    }
}