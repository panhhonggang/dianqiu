<?php
namespace Home\Controller;
use Think\Controller;

class ConsumeController extends CommonController {
    /**
     * [index 饮水记录主页]
     *     1.显示用户名下所以IC卡 
     *     2.默认显示第一张卡消费情况
     */
    public function index()
    {
    	// 查询用户IC卡号 xp_card
    	$uid = $_SESSION['homeuser']['id'];
    	$icid = M('Card')->field('iccard,id')->where('`uid`='.$uid)->select();

    	// 查询第一张卡消费记录
    	$icidOne = M('Consume')->field('flow,address,time')->where('`icid`="'.$icid[0]['id'].'"')->order('id desc')->select();
        	
    	//分配数据        
        $this->assign('icid',$icid);
        $this->assign('icidOne',$icidOne);
        $this->display();
    }

    public function getIcIdConsume()
    {
        // 接收提交过来的icid
        $icid = I('icid');

        // 查询IC卡消费记录
        $icIdConsume = M('Consume')->field('flow,address,time')->where('`icid`="'.$icid.'"')->order('id desc')->select();

        // 采用JSON格式返回数据
        $this->ajaxReturn($icIdConsume);
    }
}