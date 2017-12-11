<?php
namespace Home\Controller;
use Think\Controller;
use \Org\Util\WeixinJssdk;

class ShopController extends CommonController 
{
    // 商城首页
    public function index()
    {

        // 显示模板
        $this->display();
    }

    // 商城充值套餐和滤芯产品
    public function filterElement()
    {
    	// 获取用户open_id
    	$weixin = new WeixinJssdk;
    	//$openId = $weixin->GetOpenid();
    	$openId = 'oXwY4t2gearWoyg8z19ygjD34vDk';

    	// 如果获取用户在公众号唯一ID成功
    	if($openId){
	    	// 查询用户ID号
	    	$user = M('Users')->field('id,user_status')->where('`open_id`="'.$openId.'"')->find();

	    	// 判断用户是否有权限
	    	if($user['user_status']==1){
	    		// 查询用户绑定设备ID号
    			$devices = M('Devices')->field('id')->where('`uid`='.$user['id'])->select();
    			// 选择设备
    			$this->display();
	    		//dump($devices);

	    	}else{
	    		$this->success('请先关注', 'https://mp.weixin.qq.com/mp/profile_ext?action=home&__biz=MzA3MzkwMjE3NQ==#wechat_redirect');

	    	}
    	}



  //   	// 充值套餐
  //   	$setmeal =  M('Setmeal');

		// // 查询滤芯产品总记录数
		// $setmealCount = $setmeal->count();
		
		// // 实例化分页类 传入总记录数和每页显示的记录数(25)
		// $setmealPage = new \Think\Page($setmealCount,25);
		// // 分页显示输出
		// $setmealShow = $setmealPage->show();
		// // 进行分页数据查询 注意limit方法的参数要使用Page类的属性
		// $setmealList = $setmeal->limit($setmealPage->firstRow.','.$setmealPage->listRows)->select();
		// // 赋值数据集
		// $this->assign('setmealList',$setmealList);
		// // 赋值分页输出
		// $this->assign('setmealPage',$setmealShow);
		// // dump($setmealList);
		// // dump($setmealShow);
		// // die;


  //   	// 实例化Filters对象
		// $User = M('Filters');
		// // 查询滤芯产品总记录数
		// $count = $User->count();
		// // 实例化分页类 传入总记录数和每页显示的记录数(25)
		// $Page = new \Think\Page($count,25);
		// // 分页显示输出
		// $show = $Page->show();
		// // 进行分页数据查询 注意limit方法的参数要使用Page类的属性
		// $list = $User->limit($Page->firstRow.','.$Page->listRows)->select();
		// // 赋值数据集
		// $this->assign('list',$list);
		// // 赋值分页输出
		// $this->assign('page',$show);

		// // dump($list);die;
  //       // 显示模板
  //       $this->display();
    }
}