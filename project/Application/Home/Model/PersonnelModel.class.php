<?php
namespace Home\Model;
use Think\Model;
class PersonnelModel extends Model
{
    protected $_validate = array(
        array('phone','require','登录账号不能为空'), //默认情况下用正则进行验证
        array('password','require','密码不能为空'), //默认情况下用正则进行验证
    );
    /*
     * 安装人员账号密码验证
     */
    protected function getInfo($map)
    {
        $info = M('personnel')->where($map)->find();
        if (empty($info)) {
            return ['code'=>403,'message'=>'账号或者密码错误'];
        } else {
            return ['code'=>200,'message'=>'登录成功','data'=>$info];
        }
    }

    /*
     * 安装设备详情
     */
    public function per_detail($map) {
        $info = M('work')->field('dcode')->where($map)->find();

        if ($info) {

            return ['code'=>200,'data'=>$info];
        } else {
            return ['code'=>403,'data'=>'数据有误'];
        }
    }
}