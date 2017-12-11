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
        array('money','/^[1-9]\d*\.\d*|0\.\d*[1-9]\d*$/','套餐金额请输入正确数值，不要忘记小数点哦！',1,'regex'),
        array('flow','/^\+?[1-9][0-9]*$/','套餐量请输入正整数',1,'regex'),
        array('describe','require','套餐名称不能为空')
    );


    // 自动完成
    protected $_auto = array ( 
        array('addtime','time',3,'function'), // 对addtime字段在新增和编辑的时候写入当前时间戳 
    );



}