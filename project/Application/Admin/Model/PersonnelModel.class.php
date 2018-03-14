<?php
namespace Admin\Model;

use Think\Model;

/**
 * Class 经销商数据处理
 * @package Admin\Model
 * @author 潘宏钢 <619328391@qq.com>
 */
class PersonnelModel extends BaseModel
{   
    // 自动验证
    protected $_validate = array(

        array('name','/^[a-zA-Z0-9\x{4e00}-\x{9fa5}]{1,660}$/u','用户昵称不能使用特殊字符',1,'regex'),
        array('repassword','password','两次密码不相同',0,'confirm'), //验证确认密码是否和密码一致
        array('phone','/^1[34578]\d{9}$/','电话号码格式不对',1,'regex'),
        // array('idcard','/\d{17}[\d|x]|\d{15}/','身份证格式不对',1,'regex')
//        array('idcard',"/(^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$)|(^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{2}[0-9Xx]$)/",'身份证格式不对',1,'regex')
    );


    // 处理查询数据
    public function getInfo($map)
    {
        $info = M('personnel')->where($map)->find();
        if ($info) {
           return  '手机号码或者名字已存在';
        } else {
            return false;
        }
    }

}