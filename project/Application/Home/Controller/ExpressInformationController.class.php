<?php
namespace Home\Controller;
use Think\Controller;
use \Org\Util\WeixinJssdk;

class ExpressInformationController extends CommonController 
{
    // 快递信息首页
    public function index()
    {

        // 显示模板
        $this->display();
    }

    // 添加快递地址
    public function add()
    {
        // 获取用户uid
        $uid = $_SESSION['homeuser']['id'];

        // 判断是否POST提交
        if(IS_POST){
            // 接收$_POST数据
            $name = I('post.name');
            $phone = I('post.phone');
            $addres = I('post.addres');

            // 准备错误提示数组
            $pregRes = [];

            // 正则验证用户名
            $nameRes = $this->isName($name);
            if($nameRes){
                $data['name'] = trim($name);
            }else{
                $pregRes['name'] = -1;
            }

            // 正则验证手机号
            $phoneRes = $this->isPhone($phone);
            if($phoneRes){
                $data['phone'] = trim($phone);
            }else{
                $pregRes['phone'] = -1;
            }

            // 正则验证地址
            $addresRes = $this->isAddress($addres);
            if($addresRes){
                $data['addres'] = trim($addres);
            }else{
                $pregRes['addres'] = -1;
            }

            // 错误提示数组为空
            if(empty($pregRes)){
                $data['user_id'] = $uid;
                // 没有错误
                // 查询数据库看用户收货地址是否已经存在
                $expressId = M('ExpressInformation')->field('id')->where($data)->find()['id'];

                // 如果快递信息已经存在，返回快递信息ID号
                if (!empty($expressId)) {
                    $pregRes['expressId'] = $expressId;
                }else{
                    $expressId = M('ExpressInformation')->add($data);
                }
                // 记录快递信息ID号
                $pregRes['expressId'] = $expressId;
            }
            
            // 返回数组
            $this->ajaxReturn($pregRes);       
        }
    }

    // 正则检测手机号码
    public function isPhone($value,$match='/^1[34578]\d{9}$/')  
    { 
        $v = trim($value); 
        if(empty($v)) 
        return false; 
        return preg_match($match,$v);
    }

    // 正则检测用户名
    public function isName($value,$match='/^[0-9a-zA-Z_\x{4e00}-\x{9fa5}]{2,30}$/u')  
    { 
        $v = trim($value); 
        if(empty($v)) 
        return false; 
        return preg_match($match,$v);
    }

    // 正则检测地址
    public function isAddress($value,$match='/^[0-9a-zA-Z_\x{4e00}-\x{9fa5}]{6,255}$/u')  
    { 
        $v = trim($value); 
        if(empty($v)) 
        return false; 
        return preg_match($match,$v);
    }
}

