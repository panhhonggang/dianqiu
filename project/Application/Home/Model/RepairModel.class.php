<?php
namespace Home\Model;
use Think\Model;
class RepairModel extends Model 
{
    protected $_validate = array(
        array('name','require','请留下您的真实姓名，便于联系反馈'), //默认情况下用正则进行验证 
        // array('phone','require','请留下您的联系电话，便于联系反馈'), //默认情况下用正则进行验证 
        array('phone','/^1[34578]\d{9}$/','电话号码格式不对',1,'regex'),
        array('address','require','请留下您的地址，以便处理问题'), //默认情况下用正则进行验证 
    );
}