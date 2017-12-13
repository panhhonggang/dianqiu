<?php
namespace Home\Controller;
use Think\Controller;
use \Org\Util\WeixinJssdk;
/**
 * 前共控制器
 * 前台控制器除login外必须继承我
 * @author 吴智彬 <519002008@qq.com>
 */

class CommonController extends Controller 
{
	/**
     * 初始化
     * @author 吴智彬 <519002008@qq.com>
     */
    public function _initialize()
    {	
    	// 获取用户open_id
    	$weixin = new WeixinJssdk;
    	//$openId = $weixin->GetOpenid();
    	$openId = 'oXwY4t2gearWoyg8z19ygjD34vDk';
    	// 查询用户信息
    	$info = M('Users')->where("open_id='{$openId}'")->find();
    	// 将用户信息缓存
    	$_SESSION['homeuser'] = $info;
    }


}