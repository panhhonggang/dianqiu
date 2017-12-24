<?php
namespace Admin\Controller;
use Think\Controller;

/**
 * 客户建议及报修控制器
 * 
 * @author 潘宏钢 <619328391@qq.com>
 */

class FeedsController extends CommonController 
{
	/**
     * 建议列表
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function feedslist()
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
     * 客户建议的删除功能
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function feedsdel($id)
    {
        
        $res = M('feeds')->delete($id);
        if($res){
            $this->success('删除成功',U('Feeds/feedslist'));
        }else{
            $this->error('删除失败');
        }
    
    }

    /**
     * 报修列表
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function repairlist()
    {
        // 根据用户昵称进行搜索
        $map = '';
        if(!empty($_GET['name'])) $map['name'] = array('like',"%{$_GET['name']}%");

        $user = M('repair');
        $total = $user->where($map)
                        ->join('pub_users ON pub_repair.uid = pub_users.id')
                        ->field('pub_repair.*,pub_users.name,pub_users.phone')
                        ->count();
        $page  = new \Think\Page($total,8);
        $pageButton =$page->show();

        $userlist = $user->where($map)
                        ->join('pub_users ON pub_repair.uid = pub_users.id')
                        ->field('pub_repair.*,pub_users.name,pub_users.phone')
                        ->limit($page->firstRow.','.$page->listRows)
                        ->select();

        $this->assign('list',$userlist);
        $this->assign('button',$pageButton);
        $this->display(); 
    }

    /**
     * 报修更改状态
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function edit($id,$status)
    {
        $work = M("repair");
        $data['status'] = $_GET['status'];
        $res = $work->where('id='.$id)->save($data); 
        if ($res) {
            $this->success('修改成功',U('Feeds/repairlist'));
        } else {
            $this->error('修改失败啦！');
        }
    }
    
}