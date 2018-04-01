<?php
namespace Admin\Model;

use Think\Model;

/**
 * Class 经销商数据处理
 * @package Admin\Model
 * @author 潘宏钢 <619328391@qq.com>
 */
class VendorsModel extends BaseModel
{   
    // 自动验证
    protected $_validate = array(
        array('user','require','账户名不能为空'),
        array('password','require','密码不能为空'),
        // array('password','checkPwd','密码格式不正确',self::EXISTS_VALIDATE,'callback',self::MODEL_INSERT), // 自定义函数验证密码格式
        // array('user','((?=[\x21-\x7e]+)[^A-Za-z0-9])','登陆帐号不可以使用特殊字符'),
        // array('name','((?=[\x21-\x7e]+)[^A-Za-z0-9])','用户昵称不可以使用特殊字符'),
        array('user','/^[a-zA-Z0-9\x{4e00}-\x{9fa5}]{1,660}$/u','用户名不能使用特殊字符',1,'regex'),
        array('user','','该账户已存在，请换一个试试',0,'unique',1),
        array('name','/^[a-zA-Z0-9\x{4e00}-\x{9fa5}]{1,660}$/u','用户昵称不能使用特殊字符',1,'regex'),

        array('repassword','password','两次密码不相同',0,'confirm'), //验证确认密码是否和密码一致
        array('phone','/^1[34578]\d{9}$/','电话号码格式不对',1,'regex'),
        array('csphone','require','客服电话不能为空'),
        array('csphone','(^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)','客服电话不对',1,'regex'),
        array('email','/\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}/','邮箱格式不对',1,'regex'),
        array('name','require','用户昵称不能为空'),
        array('address','require','地址不能为空'),
        array('idcard',"/^[1-9][0-9]{5}(19|20)[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|31)|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}([0-9]|x|X)$/",'身份证号码格式不对','regex')
        // array('idcard','/\d{17}[\d|x]|\d{15}/','身份证格式不对',1,'regex')
//        array('idcard',"/(^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$)|(^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{2}[0-9Xx]$)/",'身份证格式不对',1,'regex')
    );


    // 自动完成
    protected $_auto = array ( 
        array('addtime','time',3,'function'), // 对addtime字段在新增和编辑的时候写入当前时间戳 
        array('password','md5',1,'function') , // 对password字段在新增的时候使md5函数处理
        
    );


    // 处理查询数据
    public function getAll()
    {
        $list = $this->select();

        $leavel = array('超级管理员','一级经销商','二级经销商');
        foreach ($list as $key => $val) {
            $list[$key]['leavel'] = $leavel[$val['leavel']];
        }
        return $list;
    }

    public function checkPwd()
    {

    }
}