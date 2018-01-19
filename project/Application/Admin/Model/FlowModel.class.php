<?php
namespace Admin\Model;

use Think\Model;
use Org\Util\Date;
/**
 * Class 充值数据处理
 * @package Admin\Model
 * @author 潘宏钢 <619328391@qq.com>
 */
class FlowModel extends Model
{   

    // 处理查询数据
    public function getAll()
    {
       $data = $this->select();
       return $data;
    }

    // 获取当月充值数据
    public function getCurrentMonth()
    {
        $date = new Date();
        $firstDayOfMonth = $date->firstDayOfMonth();
        $firstat = strtotime($firstDayOfMonth);
        $lastDayOfMonth = $date->lastDayOfMonth();
        $lastat = strtotime($lastDayOfMonth) + 24*60*60;

       $map['addtime'] = array(array('gt',$firstat),array('lt',$lastat), 'and');
       $data = $this
                ->where($map)
                ->select();
       return $data;
    }
}