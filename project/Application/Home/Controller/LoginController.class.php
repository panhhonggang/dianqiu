<?php
namespace Home\Controller;
use Think\Controller;

/**
 * 前共控制器
 * 前台控制器login
 * @author 吴智彬 <519002008@qq.com>
 */
class LoginController extends Controller 
{
    public function index()
    {
        $this->display();
    }

    //用户登录
    public function login()
    {
        // 获取用户cookie
        $userInfo = cookie('homeuser');

        // 判断用户cookie
        if(!empty($userInfo)){

            // 查询数据库
            $data['phone'] = $userInfo['phone'];
            $data['password'] = $userInfo['password'];
            $user = M('Users')->where($data)->find();

            // 如果用户信息正确
            if($user){
                // 记录用户最后登录时间
                $data['login_time'] = time();
                // 记录用户最后登录IP
                $data['login_ip'] = get_client_ip();
                $mes = M('Users')->where('id='.$info['id'])->save($data);
                // 自动登录
                $_SESSION['homeuser'] = $userInfo;     
            }else{
                // 清除cookie
                cookie('homeuser',null);
            }
        }
        // 登录如果已经登录就不用重复登录了
        if(!empty($_SESSION['homeuser'])) $this->redirect('Index/index');

        if(IS_POST){ 
              
            // 判断验证码是否正确
            $Verify =  new \Think\Verify();
            $res = $Verify->check($_POST['verify_code']);
            if(!$res) $this->error('验证码不对');

            // 查询手机号
            $condition['phone'] = $_POST['phone'];
            $info = M('Users')->where($condition)->find();
            // 判断用户状态（0：禁用 1：启用）
            if($info['status']==0){
                $this->error('用户名已被禁用，请与管理员联系！');
            }
   
            if($info){
                // 接收密码
                $password = MD5($_POST['password']);
                // 密码验证
                if ($info['password'] == $password) {

                    // 记录用户最后登录时间
                    $data['login_time'] = time();
                    // 记录用户最后登录IP
                    $data['login_ip'] = get_client_ip();

                    $mes = M('Users')->where('id='.$info['id'])->save($data);

                    // 登录时间记录成功
                    if($mes){
                        // 判断是否选择自动登录
                        if(!empty(I('remember'))){
                            // 设置cookie有效期一周
                            cookie('homeuser',$info,604800);
                        }
                        // 登录成功
                        $_SESSION['homeuser'] = $info;
                        // 跳转到主页
                        $this->redirect('Index/index');  
                    }else{
                        // 登记失败退回去重新登录
                        $this->error('登录失败请重新登录');
                    }

                }else{
                    $this->error('您的密码输入错误！');
                }

            }else{
                $this->error('您输入的用户名不存在！');
            }

        }else{
            // 显示模板
           $this->display(); 
        } 
    }

    // 退出登录
    public function logout()
    {
        cookie('homeuser',null);
        unset($_SESSION['homeuser']);
        $this->redirect('Login/login');
    }

    // 用户登录验证码生成
    public function verifyCode(){
        $config =    array(
            'fontSize'    =>    20,    // 验证码字体大小
            'length'      =>    3,     // 验证码位数
            'useNoise'    =>    false, // 关闭验证码杂点
        );
        $Verify =     new \Think\Verify($config);
        $verify_code = $Verify->entry(); 
    }
}