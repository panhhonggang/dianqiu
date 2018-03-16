<?php
namespace Admin\Model;

use Think\Model;

/**
 * Class 客户保修数据处理
 * @package Admin\Model
 * @author 潘宏钢 <619328391@qq.com>
 */
class RepairModel extends Model
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
                    ->limit($page->firstRow.','.$page->listRows)
                    ->select();
        $data = ['page'=>$pageButton,'list'=>$list];
       return $data; 
    }
}