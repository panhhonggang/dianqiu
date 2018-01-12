<?php
namespace Home\Controller;
use Think\Controller;
class UsersController extends CommonController 
{
	//我的
    public function mine()
    {
        $open_id = $_SESSION['homeuser']['open_id'];
        // 查询用户微信头像
        $userInfo = M('Wechat')
        ->where('pub_wechat.open_id="'.$open_id.'"')
        ->join('pub_users ON pub_users.open_id=pub_wechat.open_id')
        ->join('pub_current_devices ON pub_current_devices.uid=pub_users.id')
        ->join('pub_devices ON pub_devices.id=pub_current_devices.did')
        ->find();

        // 分配数据到模板
        $this->assign('userInfo',$userInfo);
       
        // 显示模板
        $this->display();        
    }
	
	//个人信息
	public function personalinformation()
	{
        if(IS_POST){
            // 获取用户uid
            $uid = $_SESSION['homeuser']['id'];
            $did = $_SESSION['homeuser']['did'];

            // 用户用正则验证
            if($this->isName(I('post.name'))){
                $data['name'] = I('post.name');
            }else{
                $this->error('请输入正确的用户名');
            }

            // 手机正则验证
            if($this->isPhone(I('post.phone'))){
                $data['phone'] = I('post.phone');
            }else{
                $this->error('请输入正确的手机号码');
            }

            // 地址正则验证
            if($this->isAddress(I('post.Installaddress'))){
                $data['address'] = I('post.Installaddress');
            }else{
                $this->error('请输入正确的地址');
            }

            //$data['uid'] = $uid;
            $saveData['id'] = $did;

            $res = M('Devices')->where($saveData)->save($data);

            if($res){
                $this->redirect('Home/Index/index');    
            }else{
                $this->error('请输正确的安装信息');
            }
            //show($data);die;
        }else{
            // 显示模板
            $this->display();              
        }

	}

    // 正则检测手机号码
    public function isPhone($value,$match='/^((13[0-9])|(14[5|7])|(15([0-3]|[5-9]))|(18[0,5-9]))\d{8}$/')  
    { 
        $v = trim($value); 
        if(empty($v)) 
        return false; 
        return preg_match($match,$v);
    }

    // 正则检测用户名
    public function isName($value,$match='/^[a-zA-Z\x{4e00}-\x{9fa5}]{2,30}$/u')  
    { 
        $v = trim($value); 
        if(empty($v)) 
        return false; 
        return preg_match($match,$v);
    }

    // 正则检测地址
    public function isAddress($value,$match='/^[a-zA-Z\x{4e00}-\x{9fa5}]{6,255}$/u')  
    { 
        $v = trim($value); 
        if(empty($v)) 
        return false; 
        return preg_match($match,$v);
    }
}