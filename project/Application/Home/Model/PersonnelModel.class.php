<?php
namespace Home\Model;
use Think\Model;
class PersonnelModel extends Model
{
    protected $_validate = array(
        array('phone','require','登录账号不能为空'), //默认情况下用正则进行验证
        array('password','require','密码不能为空'), //默认情况下用正则进行验证
    );
    // 账号密码是否匹配
    public function getInfo($map)
    {
        $info = M('personnel')->where($map)->find();
        if (empty($info)) {
            return ['code'=>403,'message'=>'账号或者密码错误'];
        } else {
                return ['code'=>200,'message'=>'登录成功'];
        }
    }
}