<?php
namespace Home\Model;
use Think\Model;
class PersonnelModel extends Model
{
    protected $_validate = array(
        array('phone','/^1[34578]\d{9}$/','电话号码格式不对',1,'regex'),
        array('password','require','密码不能为空'), //默认情况下用正则进行验证
    );
    /*
     * 安装人员账号密码验证
     */
    public  function getInfo($map)
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
        //查询工单
        $info = M('work')->field('device_code')->where(['id'=>$map['id']])->find();


        if ($info) {

            return ['code'=>200,'data'=>$info];
        } else {
            return ['code'=>403,'data'=>'数据有误'];
        }
    }
    /*
     * 查询设备编码是否是经销商并且未激活
     */
    public function status($map) {
//        $map['id'] = 23;
        $info = M('personnel')->field('v_id')->where(['id'=>$map['personnel_id']])->find();
        // dump($info);
        // echo M('personnel')->getlastsql();exit;

        $where['device_code'] = $map['dcode'];

        $list = M('devices')->field('id')->where($where)->find();
        // echo M('devices')->getlastsql();exit;
        $binding_info = M('binding')->where(['did'=>$list['id'],'vid'=>$info['v_id']])->find();
        // echo M('binding')->getlastsql();exit;
        if (empty($binding_info)) {
            return ['code'=>403,'message'=>'该设备号码有误'];
        } else {
            return ['code'=>200,'data'=>$binding_info['vid']];
        }






    }
}