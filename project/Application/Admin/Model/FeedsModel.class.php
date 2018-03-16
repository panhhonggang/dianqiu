<?php
namespace Admin\Model;

use Think\Model;

/**
 * Class 客户反馈数据处理
 * @package Admin\Model
 * @author 潘宏钢 <619328391@qq.com>
 */
class FeedsModel extends Model
{   

    // 处理查询数据
    public function getAll($maps='')
    {
       $total = $this
    				->where($maps)
                    ->count();
        $page  = new \Think\Page($total,8);
        D('devices')->getPageConfig($page);
        $pageButton =$page->show();

        $list = $this
        			->where($maps)
        			->join('pub_users ON pub_feeds.uid = pub_users.id')
                    ->field('pub_users.*,pub_feeds.*')
                    ->limit($page->firstRow.','.$page->listRows)
                    ->select();
        $data = ['page'=>$pageButton,'list'=>$list];
       return $data;       
    }

}