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
        /*
            Excel导出
         */
        require_once VENDOR_PATH.'PHPExcel.php';
        $phpExcel = new \PHPExcel();
        // dump($phpExcel);
        // 搜索功能
        $map = array(
            'id' => trim(I('post.id')),
            'uid' => trim(I('post.uid')),
            'name' => trim(I('post.name')),
            'phone' => trim(I('post.phone')),
        );

        // $minaddtime = trim(I('post.minaddtime'))?:0;
        // $maxaddtime = trim(I('post.maxaddtime'))?:-1;
        // if (is_numeric($maxaddtime)) {
        //     $map['money'] = array(array('egt',$minaddtime),array('elt',$maxaddtime));
        // }
        // if ($maxaddtime < 0) {
        //     $map['money'] = array(array('egt',$minaddtime));      
        // }   
        // 删除数组中为空的值
        $map = array_filter($map, function ($v) {
            if ($v != "") {
                return true;
            }
            return false;
        });

        $user = M('feeds');
        // PHPExcel 导出数据 
        if (I('output') == 1) {
            $data = $user->where($map)
                        ->alias('f')
                        ->join('__DEVICES__ d ON f.uid = d.uid AND f.did = d.id', 'LEFT')
                        ->field('f.id,f.uid,d.name,d.phone,f.content,f.addtime')
                        ->order('f.addtime desc')
                        ->select();
            $filename = '建议列表数据';
            $title = '建议列表';
            $cellName = ['建议id','用户id','用户昵称','手机','反馈内容','报修时间'];
            // dump($data);die;
            $myexcel = new \Org\Util\MYExcel($filename,$title,$cellName,$data);
            $myexcel->output();
            return ;
        }

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
         /*
            Excel导出
         */
        require_once VENDOR_PATH.'PHPExcel.php';
        $phpExcel = new \PHPExcel();
        // dump($phpExcel);
        // 搜索功能
        $map = array(
            'uid' => trim(I('post.uid')),
            'device_code' => trim(I('post.device_code')),
            'name' => trim(I('post.name')),
            'phone' => trim(I('post.phone')),
            'address' => trim(I('post.address')),
            'status' => trim(I('post.status')),
        );

        // $minaddtime = trim(I('post.minaddtime'))?:0;
        // $maxaddtime = trim(I('post.maxaddtime'))?:-1;
        // if (is_numeric($maxaddtime)) {
        //     $map['money'] = array(array('egt',$minaddtime),array('elt',$maxaddtime));
        // }
        // if ($maxaddtime < 0) {
        //     $map['money'] = array(array('egt',$minaddtime));      
        // }   
        // 删除数组中为空的值
        $map = array_filter($map, function ($v) {
            if ($v != "") {
                return true;
            }
            return false;
        });

        $user = M('repair');
        // PHPExcel 导出数据 
        if (I('output') == 1) {
            $data = $user->where($map)
                        ->alias('f')
                        ->join('__DEVICES__ d ON f.uid = d.uid AND f.did = d.id', 'LEFT')
                        ->join('pub_binding bd ON  d.id = bd.did', 'LEFT')
                        ->field('f.uid,d.device_code,d.name,d.phone,f.content,f.address,f.status,f.addtime')
                        ->order('f.addtime desc')
                        ->select();
            $filename = '报修列表数据';
            $title = '报修列表';
            $cellName = ['用户id','设备编码','用户昵称','经销商手机','报修内容','报修地址','状态','报修时间'];
            // dump($data);die;
            $myexcel = new \Org\Util\MYExcel($filename,$title,$cellName,$data);
            $myexcel->output();
            return ;
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