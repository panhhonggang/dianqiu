<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/10/20/0020
 * Time: 9:28
 */
namespace Api\Controller;
use Think\Controller;

class LoginController extends Controller
{
    // 登录方法
    public function login()
    {
        if (IS_POST) {
            

            $password = md5($_POST['password']);
            $info = M('vendors')->where("user='{$_POST['name']}'")->find();

            if ($info) {
                if ($info['password'] == $password) {
                    // 万事大吉
                    // $_SESSION['adminuser'] = $info;
                    
                    //验证成功
                    $this->ajaxReturn('1');
                } else {
                    $this->ajaxReturn('0');
                }
            } else {
                $this->ajaxReturn('0');
            }

        } else {
            $this->ajaxReturn('0');
            
        }
    }



    // public function logout()
    // {
    //     unset($_SESSION['adminuser']);
    //     $this->redirect('Login/login');
    // }

}
