<?php
namespace Admin\Controller;
use Think\Controller;

/**
 * 订单控制器
 * 
 * @author 潘宏钢 <619328391@qq.com>
 */

class OrdersController extends CommonController 
{
	/**
     * 订单列表
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function index()
    {	
        // 根据用户昵称进行搜索
        $map = '';
    	if(!empty($_GET['name'])) $map['name'] = array('like',"%{$_GET['name']}%");

        $user = M('feeds');
        $total = $user->where($map)
                        ->join('pub_users ON pub_feeds.uid = pub_users.id')
                        ->field('pub_feeds.*,pub_users.name,pub_users.phone')
                        ->count();
        $page  = new \Think\Page($total,8);
        $pageButton =$page->show();

        $userlist = $user->where($map)
                        ->join('pub_users ON pub_feeds.uid = pub_users.id')
                        ->field('pub_feeds.*,pub_users.name,pub_users.phone')
                        ->limit($page->firstRow.','.$page->listRows)
                        ->select();

        $this->assign('list',$userlist);
        $this->assign('button',$pageButton);
        $this->display();
    }

    

    /**
     * 更改状态
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function edit($id,$status)
    {
        $work = M("repair");
        $data['status'] = $_GET['status'];
        $res = $work->where('id='.$id)->save($data); 
        if ($res) {
             $this->redirect('Feeds/repairlist');
        } else {
            $this->error('修改失败啦！');
        }
    }
    
}