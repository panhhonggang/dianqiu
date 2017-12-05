<?php
namespace Home\Controller;
use Think\Controller;

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
    	// 登录检测
    	if(empty($_SESSION['homeuser'])) $this->redirect('Login/login');

    }


}