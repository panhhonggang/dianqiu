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
	    		// 查询用户当前设备ID号
    			$did = M('currentDevices')->field('did')->where('`uid`='.$user['id'])->find()['did'];
    			if($did){
    				// 根据用户当前设备查找设备类型ID号
    				$tid = M('deviceConfig')->field('dtid')->where('`did`='.$did)->find()['dtid'];
    				if($tid){
    					// 根据设备类型查找套餐setmeal
				    	// 充值套餐
				    	// 实例化User对象
						$setmeal = M('Setmeal'); 
						// 查询满足要求的总记录数
						$count      = $setmeal->where('`tid`='.$tid)->count();
						// 实例化分页类 传入总记录数和每页显示的记录数(5)
						$setmealPage       = new \Think\Page($count,5);
						// 分页显示输出
						$setmealshow       = $setmealPage->show();
						// 进行分页数据查询 注意limit方法的参数要使用Page类的属性
						$setmeallist = $setmeal->where('`tid`='.$tid)->limit($setmealPage->firstRow.','.$setmealPage->listRows)->select();
						// 赋值数据集
						$this->assign('setmeallist',$setmeallist);
						// 赋值分页输出
						$this->assign('setmealpage',$setmealshow);

    				}else{
	    				// 设备未配置(跳转地址后续补充)
	    				$this->success('设备未配置请联系管理员', '');	
    				}
    				
    			}else{
    				// 请先绑定设备(跳转地址后续补充)
    				$this->success('请先绑定设备', '');
    			}

	    	}else{
	    		$this->success('请先关注', 'https://mp.weixin.qq.com/mp/profile_ext?action=home&__biz=MzA3MzkwMjE3NQ==#wechat_redirect');

	    	}
    	}

    	// 实例化Filters对象
		$User = M('Filters');
		// 查询滤芯产品总记录数
		$count = $User->count();
		// 实例化分页类 传入总记录数和每页显示的记录数(25)
		$Page = new \Think\Page($count,5);
		// 分页显示输出
		$show = $Page->show();
		// 进行分页数据查询 注意limit方法的参数要使用Page类的属性
		$list = $User->limit($Page->firstRow.','.$Page->listRows)->select();
		// 赋值数据集
		$this->assign('list',$list);
		// 赋值分页输出
		$this->assign('page',$show);
        // 显示模板
        $this->display();
    }
}