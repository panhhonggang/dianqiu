<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/10/20/0020
 * Time: 9:28
 */
namespace Admin\Controller;
use Think\Controller;

class LoginController extends Controller
{   
    // 登录方法
    public function login()
    {
        if (IS_POST) {
            // 验证验证码是否OK
            $Verify = new \Think\Verify();
            $res = $Verify->check($_POST['code']);
            if(!$res) $this->error('验证码不对');

            $password = md5($_POST['password']);
            $info = M('vendors')->where("user='{$_POST['name']}'")->find();

            if($info){
                if ($info['password'] == $password) {
                    // 万事大吉
                    $_SESSION['adminuser'] = $info;
                    $this->redirect('Index/index');
                }else{
                    $this->error('您的密码输入错误！');
                }
            }else{
                $this->error('您输入的用户名不存在！');
            }

        }else{
            // 登录检测
            if(!empty($_SESSION['adminuser'])) $this->redirect('index/index');
            $this->display();
        }
    }


    // 验证码方法
    public function yzm()
    {
        $config = array(
            'font-Size' =>  60, //验证码大学
            'length'    =>  3,  //验证码个数
            'useNoise'  =>  false, //关闭验证码杂点
            'useCurve'  =>  false
        );
        $Verify = new \Think\Verify($config);
        $Verify->entry();
    }


    public function logout()
    {
        unset($_SESSION['adminuser']);
        $this->redirect('Login/login');
    }

}
