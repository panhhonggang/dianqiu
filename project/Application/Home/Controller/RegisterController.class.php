<?php
namespace Home\Controller;
use Think\Controller;

/**
 * 前共控制器
 * 前台控制器Register
 * @author 吴智彬 <519002008@qq.com>
 */
class RegisterController extends Controller 
{
    public function index()
    {
        $this->display();
    }

    // 用户注册-手机验证
    public function register()
    {
    	if(IS_POST){

            // 判断手机是否输入
            if(empty($_POST['phone'])) $this->error('请输入您的手机号码');

            // 判断手机号码长度
            if(strlen($_POST['phone']) == "11"){
                // 正则检查手机
                if(!preg_match("/^1[34578]{1}\d{9}$/",$_POST['phone'])){  
                    $this->error('请输入正确的手机号码'); 
                } 
            }else{
                $this->error('请输入11位数手机号码');
            }

            // 查询手机号码是否存在
            $user = M('Users');
            $map['phone'] = array('eq', $_POST['phone']);
            $res = $user->where($map)->find();
            if($res) $this->error('亲，您的手机号码已被注册');

            //判断验证码是否为空
            if(empty($_POST['phone_code'])) $this->error('请输入验证码！');

            // 判断手机验证码是否有效
            if($_SESSION['phone_code']!=$_POST['phone_code'])  $this->error('验证码错误，请重新输入');
               
            // 跳转到下一页
            $this->redirect('registerNext');
    	}else{
            $this->display();
        }
    }

    // 用户注册-资料填写
    public function registerNext()
    {
        if(IS_POST){

            //接收数据
            $password = $_POST['password'];
            $repassword = $_POST['repassword'];            

            
            if($password == $repassword){
                $user = D('Users');
                $info = $user->create();
                $info['phone'] = $_SESSION['phone'];
                $mes = $user->add($info);
                if($mes){
                    // 跳转到主页
                    $this->redirect('Index/index');
                }else{
                    $this->error('注册失败');
                }
            }else{
                $this->error('确密码不正确，请重新输入！');
            }
        }else{
            $this->display();
        }
    }

    // 用户密码自助找回-入口
    public function resetPassword()
    {
        if(IS_POST){

            // 判断手机是否输入
            if(empty($_POST['phone'])) $this->error('请输入您的手机号码');

            // 判断手机号码长度
            if(strlen($_POST['phone']) == "11"){
                // 正则检查手机
                if(!preg_match("/^1[34578]{1}\d{9}$/",$_POST['phone'])){  
                    $this->error('请输入正确的手机号码'); 
                } 
            }else{
                $this->error('请输入11位数手机号码');
            }

            // 查询手机号码是否存在
            $user = M('Users');
            $map['phone'] = array('eq', $_POST['phone']);
            $res = $user->where($map)->find();
            
            if(is_null($res)) $this->error('手机号不存在，请重新输入');
            
            //判断验证码是否为空
            if(empty($_POST['phone_code'])) $this->error('请输入验证码！');
            // 判断手机验证码是否有效
            if($_SESSION['phone_code']!=$_POST['phone_code'])  $this->error('验证码错误，请重新输入！');
            // 跳转到下一页
            $this->redirect('resetPasswordNext');
        }else{
            $this->display();
        }
    }

    // 用户密码自助找回-设置新密码
    public function resetPasswordNext()
    {
        if(IS_POST){

            //接收数据
            $password = $_POST['password'];
            $repassword = $_POST['repassword'];

            //检查两次输入密码是否一致
            if($password == $repassword){
                $data['password'] = md5($password);
                $user = M('Users');
                $mes = $user->where('phone="'.$_SESSION['phone'].'"')->save($data);
                if($mes){
                    // 跳转到主页
                    $this->redirect('Index/index');
                }else{
                    $this->error('密码修改失败');
                }
            }else{
                $this->error('确密码不正确，请重新输入!');
            }
        }else{
            $this->display();    
        }
    }

    // 检测输入的验证码是否正确，$code为用户输入的验证码字符串
    function check_verify($code, $id = ''){
        $verify = new \Think\Verify();
        return $verify->check($code, $id);
    }

    // 获取手机注册验证码
    public function getcode()
    {

        // 获取手机号
        $phone = $_POST['phone'];
        if(empty($phone)){
            exit('手机号不能为空');
        }

        // 生成的随机数
        $mobile_code = $this->random(6,1);

        // 实例化发短信模型
        $sms = new \Org\Util\SmsDemo;

        $response = $sms::sendSms(
            "阿里云短信测试专用", // 短信签名
            "SMS_112735031", // 短信模板编号
            $phone, // 短信接收者
            Array(  // 短信模板中字段的值
                "code"=>$mobile_code,
                "product"=>"dsd"
            ),
            "123"   // 流水号,选填
        );

        // 手机验证码信息发送成功
        if($response->Code=='OK'){
            $_SESSION['phone'] = $phone;
            $_SESSION['phone_code'] = $mobile_code;
        }
        // 返回状态码
        echo $response->Code;
    }

    // 获取手机修改密码验证码
    public function getresetcode()
    {

        // 获取手机号
        $phone = $_POST['phone'];
        if(empty($phone)){
            exit('手机号不能为空');
        }

        // 生成的随机数
        $mobile_code = $this->random(6,1);

        // 实例化发短信模型
        $sms = new \Org\Util\SmsDemo;

        $response = $sms::sendSms(
            "阿里云短信测试专用", // 短信签名
            "SMS_112735030", // 短信模板编号
            $phone, // 短信接收者
            Array(  // 短信模板中字段的值
                "code"=>$mobile_code,
                "product"=>"dsd"
            ),
            "123"   // 流水号,选填
        );

        // 手机验证码信息发送成功
        if($response->Code=='OK'){
            $_SESSION['phone'] = $phone;
            $_SESSION['phone_code'] = $mobile_code;
        }
        // 返回状态码
        echo $response->Code;
    }

    // random() 函数返回随机整数。
    protected function random($length = 6 , $numeric = 0) 
    {
        PHP_VERSION < '4.2.0' && mt_srand((double)microtime() * 1000000);
        if($numeric) {
            $hash = sprintf('%0'.$length.'d', mt_rand(0, pow(10, $length) - 1));
        } else {
            $hash = '';
            $chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789abcdefghjkmnpqrstuvwxyz';
            $max = strlen($chars) - 1;
            for($i = 0; $i < $length; $i++) {
                $hash .= $chars[mt_rand(0, $max)];
            }
        }
        return $hash;
    }
}