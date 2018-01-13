<?php
namespace Admin\Model;

use Think\Model;

/**
 * Class 工单数据处理
 * @package Admin\Model
 * @author 潘宏钢 <619328391@qq.com>
 */
class SetmealModel extends Model
{   

    // 自动验证
    protected $_validate = array(
        array('flow','/^\+?[1-9][0-9]*$/','套餐量请输入正整数',1,'regex'),
        array('describe','require','套餐名称不能为空'),
        array('describe','/^[a-zA-Z0-9\x{4e00}-\x{9fa5}]{1,660}$/u','套餐名称不能使用特殊字符',1,'regex'),
    );


    // 自动完成
    protected $_auto = array ( 
        array('addtime','time',3,'function'), // 对addtime字段在新增和编辑的时候写入当前时间戳 
        array('money','money',3,'callback'), 
    );

    // 金额转单位为元
    protected function money($money)
    {
        return $money*100;
    }

}