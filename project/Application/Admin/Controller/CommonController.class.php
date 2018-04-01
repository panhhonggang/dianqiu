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
            echo '权限不足';
            die;
            redirect('Login/login',5,'权限不足');
        }

        // 分配菜单权限
        $nav_data=D('AdminMenu')->getTreeData('level','order_number,id');
        $assign=array(
            'nav_data'=>$nav_data
            );
        $this->assign($assign);

        //处理分页搜索条件使用POST方式提交
        $_POST = array_merge($_POST,$_GET);
        $_GET = $_POST;
    }

    public function rule_check($uid)
    {
        $auth = new \Think\Auth();

        if( session('adminuser.user') == 'admin' ){
            return true;
        }

        $name = MODULE_NAME."/".CONTROLLER_NAME."/".ACTION_NAME;
        return $auth->check($name, $uid);
    }

    // 经销商权限 
    public function get_level()
    {
        if($_SESSION['adminuser']['leavel'] > 0){
            return true;
        }
        return false;
    }
}