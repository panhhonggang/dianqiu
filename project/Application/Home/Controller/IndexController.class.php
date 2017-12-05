<?php
namespace Home\Controller;
use Think\Controller;
class IndexController extends CommonController 
{
    public function index()
    {
    	
    	// 读取用户余额
    	$money = (int) M('users')->where('id='.$_SESSION['homeuser']['id'])->find()['balance'];
    	//分配数据        
        $this->assign('money',$money/100);
    	$this->display();
	}
}