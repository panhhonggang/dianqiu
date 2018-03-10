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
        /// 查询条件
        $map = '';
        if (!empty($_GET['key']) && !empty($_GET['value'])) {
            switch ($_GET['key']) {
                case '1':
                    $map['d.name'] = array('like',"%{$_GET['value']}%");
                    break;
                case '2':
                    $map['d.phone'] = array('like',"%{$_GET['value']}%");
                    break;
                default:
                    # code...
                    break;
            }
        }

        $user = M('feeds');
        $total = $user->where($map)
                        ->alias('f')
                        ->join('__DEVICES__ d ON f.uid = d.uid AND f.did = d.id', 'LEFT')
                        ->field('d.*,f.id,f.content,f.addtime')
                        ->order('f.addtime desc')
                        ->count();
        $page  = new \Think\Page($total,8);
        $pageButton =$page->show();
        $userlist = $user->where($map)
                        ->alias('f')
                        ->join('__DEVICES__ d ON f.uid = d.uid AND f.did = d.id', 'LEFT')
                        ->field('d.*,f.id, f.content,f.addtime')
                        ->order('f.addtime desc')
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
         /// 查询条件
        $map = '';
        if (!empty($_GET['key']) && !empty($_GET['value'])) {
            switch ($_GET['key']) {
                case '1':
                    $map['d.name'] = array('like',"%{$_GET['value']}%");
                    break;
                case '2':
                    $map['d.phone'] = array('like',"%{$_GET['value']}%");
                    break;
                case '3':
                    $map['d.address'] = array('like',"%{$_GET['value']}%");
                    break;
                default:
                    # code...
                    break;
            }
        }

        if($this->get_level()){
            $map['bd.vid'] = $_SESSION['adminuser']['id'];//数据关系待分析 后续完善 
        }
        $user = M('repair');
        $total = $user->where($map)
                        ->alias('f')
                        ->join('__DEVICES__ d ON f.uid = d.uid AND f.did = d.id', 'LEFT')
                        ->join('pub_binding bd ON  d.id = bd.did', 'LEFT')
                        ->field('d.*,f.id, f.content,f.addtime,f.picpath')
                        ->order('f.addtime desc')
                        ->count();
        $page  = new \Think\Page($total,8);
        $pageButton =$page->show();
        $userlist = $user->where($map)
                        ->alias('f')
                        ->join('__DEVICES__ d ON f.uid = d.uid AND f.did = d.id', 'LEFT')
                        ->join('pub_binding bd ON  d.id = bd.did', 'LEFT')
                        ->field('d.*,f.id, f.content,f.addtime,f.picpath,f.status')
                        ->order('f.addtime desc')
                        ->limit($page->firstRow.','.$page->listRows)
                        ->select();
        // dump($userlist);die;                
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