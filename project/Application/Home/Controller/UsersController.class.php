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
	public function personalInformation()
	{
        // // 查询用户IC卡号 xp_card
        // $id = $_SESSION['homeuser']['id'];

        // // 查询用户名下已绑定的卡号
        // $user = M('Users')->field('name,phone,address')->where('`id`='.$id)->find();

        // // 分配数据
        // $this->assign('user',$user);

        // 显示模板
        $this->display();   
	}
}