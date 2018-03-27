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
            //接受安卓端的json数据
            // $json = file_get_contents("php://input");
            // $data = json_decode($json, true);

            // $data['password'] = '123';
            // $data['name'] = 'admin';

            // dump($data);

            $password = md5($_POST['password']);
            $info = M('vendors')->where("user='{$_POST['name']}'")->find();

            if ($info) {
                if ($info['password'] == $password) {
                    // 万事大吉
                    $_SESSION['adminuser'] = $info;
                    
                    //验证成功
                    echo json_encode('1');
                } else {
                    echo json_encode('2');
                }
            } else {
                echo json_encode('3');
            }
        } else {
            echo json_encode('4');
        }     

    }



    // public function logout()
    // {
    //     unset($_SESSION['adminuser']);
    //     $this->redirect('Login/login');
    // }

}
