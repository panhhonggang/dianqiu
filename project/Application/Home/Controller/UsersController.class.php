<?php
namespace Home\Controller;
use Think\Controller;
class UsersController extends CommonController 
{
	//我的
    public function mine()
    {
        // 查询用户IC卡号 xp_card
        $id = $_SESSION['homeuser']['id'];

        // 查询用户名下已绑定的卡号
        $name = M('Users')->field('name')->where('`id`='.$id)->find()['name'];
        // print_r($name);die;
        // 分配数据
        $this->assign('name',$name);

        // 显示模板
        $this->display();        
    }
	
	//个人信息
	public function personalInformation()
	{
        // 查询用户IC卡号 xp_card
        $id = $_SESSION['homeuser']['id'];

        // 查询用户名下已绑定的卡号
        $user = M('Users')->field('name,phone,address')->where('`id`='.$id)->find();

        // 分配数据
        $this->assign('user',$user);

        // 显示模板
        $this->display();   
	}
}