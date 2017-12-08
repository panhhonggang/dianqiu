<?php
namespace Admin\Controller;
use Think\Controller;
use Think\Auth;

/**
 * 公共控制器
 * 后台控制器除login外必须继承我
 * @author 潘宏钢 <619328391@qq.com>
 */

class CommonController extends Controller 
{
	/**
     * 初始化
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function _initialize()
    {	
    	// 登录检测
    	if(empty($_SESSION['adminuser'])) $this->redirect('Login/login');

        $bool = $this->rule_check(session('adminuser.id'));

        if(!$bool){
            $this->error('权限不足');
        }
    }

    public function rule_check($uid)
    {
        $auth = new \Think\Auth();

        if( session('adminuser.user') == 'admin' ){
            return true;
        }

        $name = CONTROLLER_NAME."/".ACTION_NAME;
        dump($name);
        return $auth->check($name, $uid);
    }
}