<?php
namespace Api\Model;

use Think\Model;

/**
 * Class 产品类型数据处理
 * @package Admin\Model
 * @author 潘宏钢 <619328391@qq.com>
 */
class TypeModel extends Model
{
    protected $trueTableName = 'pub_device_type';

    // 自动验证
    protected $_validate = array(
//        array('typename','require','类型名称不能为空'),
//        array('typename','/^[a-zA-Z0-9\x{4e00}-\x{9fa5}]{1,660}$/u','类型名称不能使用特殊字符',1,'regex'),
        array('typename','','该类型名称已存在，请换一个试试，如商务A型',0,'unique',1)

        // array('url','/@(?i)\b((?:[a-z][\w-]+:(?:/{1,3}|[a-z0-9%])|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:\'".,<>?«»“”‘’]))@','网址格式不对',1,'regex')
    );


    // 自动完成
    protected $_auto = array (
        array('addtime','time',3,'function'), // 对addtime字段在新增和编辑的时候写入当前时间戳

    );



}