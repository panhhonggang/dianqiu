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
//        $map = array(
//            'd.name' =>  array('like','%'.trim(I('post.name')).'%'),
//            'd.phone' => array('like','%'.trim(I('post.phone')).'%'),
//        );
        $map = '';
        $name = trim(I('post.name'));
        $phone = trim(I('post.phone'));
        if (!empty($name)){
            $map['d.name'] =  array('like','%'.$name.'%');
        }
        if (!empty($phone)){
            $map['d.phone'] = array('like','%'.$phone.'%');
        }

         $minaddtime = strtotime(trim(I('post.minaddtime')))?:0;
         $maxaddtime = strtotime(trim(I('post.maxaddtime')))?:-1;
         if (is_numeric($maxaddtime)) {
             $map['f.addtime'] = array(array('egt',$minaddtime),array('elt',$maxaddtime));
         }
         if ($maxaddtime < 0) {
             $map['f.addtime'] = array(array('egt',$minaddtime));
         }
        // 删除数组中为空的值
        $map = array_filter($map, function ($v) {
            if ($v != "") {
                return true;
            }
            return false;
        });

        if($this->get_level()){
            $map['v.id'] = $_SESSION['adminuser']['id'];
        }

        $user = M('feeds');
        // PHPExcel 导出数据
        if (I('output') == 1) {
            $data = $user->where($map)
                        ->alias('f')
                        ->join('__DEVICES__ d ON f.uid = d.uid AND f.did = d.id', 'LEFT')
                        ->join('pub_binding ON pub_binding.did = d.id')
                        ->join('pub_vendors ON pub_binding.vid = pub_vendors.id')
                        ->field('f.id,f.uid,d.name,d.phone,f.content,f.addtime')
                        ->order('f.addtime desc')
                        ->select();
            $arr = ['addtime'=>'Y-m-d H:i:s'];
            replace_value($data,$arr);
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
                        ->join('__BINDING__ bd ON bd.did = d.id')
                        ->join('__VENDORS__ v ON bd.vid = v.id')
                        ->field('d.*,f.id,f.content,f.addtime')
                        ->order('f.addtime desc');
//                        ->count();
        $ss=$total;
        $total=$total->count();
        $page  = new \Think\Page($total,8);
        $pageButton =$page->show();
        $userlist = $user->where($map)
                        ->alias('f')
                        ->join('__DEVICES__ d ON f.uid = d.uid AND f.did = d.id', 'LEFT')
                        ->join('__BINDING__ bd ON bd.did = d.id', 'LEFT')
                        ->join('__VENDORS__ v ON bd.vid = v.id', 'LEFT')
                        ->field('d.*,f.id, f.content,f.addtime')
                        ->order('f.addtime desc')
                        ->limit($page->firstRow.','.$page->listRows)
                        ->select();

//        dump($userlist);
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
        
        $device_code = trim(I('post.device_code'));
        $name = trim(I('post.name'));
        $phone = trim(I('post.phone'));
        $address = trim(I('post.address'));
        $status = I('post.status');
        if($device_code){
            $map['d.device_code'] = array('like','%'.$device_code.'%');
        }
        $name ? $map['d.name'] = array('like','%'.$name.'%') : '';
        $phone ? $map['d.phone'] = array('like','%'.$phone.'%') : '';
        $address ? $map['d.address'] = array('like','%'.$address.'%') : '';
        if(strlen($status)) $map['status'] = array('eq',$status);


        $minaddtime = strtotime(trim(I('post.minaddtime')))?:0;
        $maxaddtime = strtotime(trim(I('post.maxaddtime')))?:-1;
        if (is_numeric($maxaddtime)) {
            $map['f.addtime'] = array(array('egt',$minaddtime),array('elt',$maxaddtime));
        }
        if ($maxaddtime < 0) {
            $map['f.addtime'] = array(array('egt',$minaddtime));
        }
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
            $arr = ['addtime'=>'Y-m-d H:i:s'];
            replace_value($data,$arr);
            $filename = '报修列表数据';
            $title = '报修列表';
            $cellName = ['用户id','设备编码','用户昵称','经销商手机','报修内容','报修地址','状态','报修时间'];
            // dump($data);die;
            $myexcel = new \Org\Util\MYExcel($filename,$title,$cellName,$data);
            $myexcel->output();
            return ;
        }

        if($this->get_level()){
            $map['bd.vid'] = $_SESSION['adminuser']['id'];
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
                        ->field('d.*,f.id, f.content,f.addtime,f.picpath,f.status,bd.vid')
                        ->order('f.addtime desc')
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