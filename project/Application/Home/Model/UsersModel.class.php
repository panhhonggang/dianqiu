<?php
namespace Home\Model;
use Think\Model;
class UsersModel extends Model 
{
    protected $_validate = array(
        array('phone','require','手机号码不能为空'), //默认情况下用正则进行验证 
        array('name','require','姓名不能为空'), //默认情况下用正则进行验证 
        array('Installaddress','require','地址不能为空'), //默认情况下用正则进行验证 
    );
}