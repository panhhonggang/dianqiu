<?php
namespace Admin\Controller;
use Think\Controller;

/**
 * 产品控制器
 * 用来配置产品类型，配置滤芯等
 * 
 * @author 潘宏钢 <619328391@qq.com>
 */

class ProductController extends CommonController 
{
	/**
     * 产品类型列表
     * 设备的类型，型号
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function index()
    {	
       /*
            Excel导出
         */
        // 搜索功能
        $map = array(
            'typename' =>  array('like','%'.trim(I('post.typename')).'%'),
        );
        $minaddtime = strtotime(trim(I('post.minaddtime')))?:0;
        $maxaddtime = strtotime(trim(I('post.maxaddtime')))?:-1;
        if (is_numeric($maxaddtime)) {
            $map['addtime'] = array(array('egt',$minaddtime),array('elt',$maxaddtime));
        }
        if ($maxaddtime < 0) {
            $map['addtime'] = array(array('egt',$minaddtime));
        }

        $type = M('device_type');
        // PHPExcel 导出数据 
        if (I('output') == 1) {
            $data = $type->where($map)->select();
            $arr = ['addtime'=>'Y-m-d H:i:s'];
            replace_value($data,$arr);
            $filename = '产品类型列表数据';
            $title = '产品类型列表';
            $cellName = ['id','产品类型','一级滤芯','二级滤芯','三级滤芯','四级滤芯','五级滤芯','六级滤芯','七级滤芯','八级滤芯','添加时间'];
            // dump($data);die;
            $myexcel = new \Org\Util\MYExcel($filename,$title,$cellName,$data);
            $myexcel->output();
            return ;
        }

        
        $total =$type->where($map)->count();
        $page  = new \Think\Page($total,8);
        D('devices')->getPageConfig($page);
        $pageButton =$page->show();

        $list = $type->where($map)->limit($page->firstRow.','.$page->listRows)->order('addtime desc')->select();
        // dump($list);
        $this->assign('list',$list);
        $this->assign('button',$pageButton);
        $this->display();
    }

    public function edit()
    {
        if (IS_POST) {
            $id = I('post.id');
            $data = array(
                'typename' => I('post.typename'),
                'filter1' => I('post.filter1'),
                'filter2' => I('post.filter2'),
                'filter3' => I('post.filter3'),
                'filter4' => I('post.filter4'),
                'filter5' => I('post.filter5'),
                'filter6' => I('post.filter6'),
                'filter7' => I('post.filter7'),
                'filter8' => I('post.filter8'),
            );
//            $data = array_filter($data);
            $device_type = M('device_type');
            $res = $device_type->where('id='.$id)->save($data);
            if ($res) {
                $this->success('修改成功啦！',U('Admin/Product/index'));
            }else{
                $this->error('修改失败！');
            }
        } else {
            $id = I('get.id');
            $device_type = M('device_type');
            $data = $device_type->find($id);
            $filters = M('filters');
            $info = $filters->select();
            // dump($data);
            $this->assign('data',$data);
            $this->assign('list',$info);
            $this->display();
        }
    }

    public function add()
    {
        if (IS_POST) {
            $device_type = D('type');
            $info = $device_type->create();
            
            if($info){

                $res = $device_type->add();
                if ($res) {
                    $this->success('设置类型成功啦！！！',U('Product/index'));
                } else {
                    $this->error('设置类型失败啦！');
                }
            
            } else {
                // getError是在数据创建验证时调用，提示的是验证失败的错误信息
                $this->error($device_type->getError());
            }

        }else{
            $filters = M('filters');
            $info = $filters->select();
            $this->assign('list',$info);
            $this->display();
        }
    }

    /**
     * 删除类型方法（废除）
     * 不做删除，只做隐藏，如果要做删除产品类型，请确保产品类型没有被设备所用 
     *
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function del()
    {

    }

    /**
     * 添加滤芯方法
     * 
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function filter_add()
    {
        if (IS_POST) {
            // 先处理图片
            $picpath = $this->upload();
            if ($picpath) {
                $_POST['picpath'] = $picpath[0];

                $filter = D('filters');
                $info = $filter->create();
                
                if($info){

                    $res = $filter->add();
                    if ($res) {
                        $this->success('添加滤芯成功啦！！！',U('Product/filterlist'));
                    } else {
                        $this->error('添加滤芯失败啦！');
                    }
                
                } else {
                    // getError是在数据创建验证时调用，提示的是验证失败的错误信息
                    $this->error($filter->getError());
                }

            }else{
                $this->error('请上传滤芯图片');
            }
            
        }else{
            $this->display();
        }

    }

    /**
     * 滤芯列表
     * 
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function filterlist()
    {
        // 搜索功能
        $map = array(
            'filtername' =>  array('like','%'.trim(I('post.filtername')).'%'),
            'alias' => array('like','%'.trim(I('post.alias')).'%'),
            'url' => array('like','%'.trim(I('post.url')).'%'),
        );

        $minprice = trim(I('post.minprice'))?:0;
        $maxprice = trim(I('post.maxprice'))?:-1;
        if (is_numeric($maxprice)) {
            $map['price'] = array(array('egt',$minprice*100),array('elt',$maxprice*100));
        }
        if ($maxprice < 0) {
            $map['price'] = array(array('egt',$minprice*100));      
        }

        $mintimelife= trim(I('post.mintimelife'))?:0;
        $maxtimelife = trim(I('post.maxtimelife'))?:-1;
        if (is_numeric($maxtimelife)) {
            $map['timelife'] = array(array('egt',$mintimelife),array('elt',$maxtimelife));
        }
        if ($maxtimelife  < 0) {
            $map['timelife'] = array(array('egt',$mintimelife));       
        } 

        $minflowlife = trim(I('post.minflowlife'))?:0;
        $maxflowlife = trim(I('post.maxflowlife'))?:-1;
        if (is_numeric($maxflowlife)) {
            $map['flowlife'] = array(array('egt',$minflowlife),array('elt',$maxflowlife));
        }
        if ($maxflowlife < 0) {
            $map['flowlife'] = array(array('egt',$minflowlife));      
        } 

         $minaddtime = strtotime(trim(I('post.minaddtime')))?:0;
         $maxaddtime = strtotime(trim(I('post.maxaddtime')))?:-1;
         if (is_numeric($maxaddtime)) {
             $map['addtime'] = array(array('egt',$minaddtime),array('elt',$maxaddtime));
         }
         if ($maxaddtime < 0) {
             $map['addtime'] = array(array('egt',$minaddtime));
         }
        // 删除数组中为空的值
        $map = array_filter($map, function ($v) {
            if ($v != "") {
                return true;
            }
            return false;
        });

        $filter = M('filters');
        // PHPExcel 导出数据 
        if (I('output') == 1) {
            $data = $filter->where($map)
                            ->field('id,filtername,alias,price,timelife,flowlife,introduce,url,addtime')
                            ->select();
            $arr = ['addtime'=>'Y-m-d H:i:s'];
            replace_value($data,$arr);
            $filename = '滤芯列表数据';
            $title = '滤芯列表';
            $cellName = ['滤芯id','滤芯名称','滤芯别名','滤芯价格','时间寿命','流量寿命','滤芯简介','购买网址','最新添加时间'];
            // dump($data);die;
            $myexcel = new \Org\Util\MYExcel($filename,$title,$cellName,$data);
            $myexcel->output();
            return ;
        }

        
        
        $total =$filter->where($map)->count();
        $page  = new \Think\Page($total,8);
        D('devices')->getPageConfig($page);
        $pageButton =$page->show();

        $filterlist = $filter->where($map)->limit($page->firstRow.','.$page->listRows)->select();

        $this->assign('list',$filterlist);
        $this->assign('button',$pageButton);
        $this->display(); 
    }

    /**
     * 编辑滤芯方法
     * 仅做数据更新处理
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function filter_edit($id)
    {
        if(IS_POST){
            $picpath = $this->upload();
            $_POST['picpath'] = $picpath[0];
            // if ($picpath) {
            //   unlink("./Public".$_POST['oldpicpath']);    
            // }
            if (!$picpath) {
                // 如果没有上传新的图片，那么就取原来的老图片，也就是隐藏域的值
                $picpath = $_POST['oldpicpath'];
                $_POST['picpath'] = $picpath;
            }
            
            $mod = D('filters');
            $info = $mod->create();
            if($info){
                $res = $mod->where("id=".$_POST['id'])->save();

                if ($res) {
                    // 删除原图片
                    
                    $this->success('修改成功啦！',U('Product/filterlist'));
                }else{
                    $this->error('修改失败！');
                }
            }else{
                // getError是在数据创建验证时调用，提示的是验证失败的错误信息
                $this->error($mod->getError());
            }
           
        } else {
            $info = M('filters')->where("id=".$id)->select();
            $this->assign('info',$info);
            $this->display();
        }
    }

    /**
     * 删除滤芯方法（废除）
     * 不做删除，只做隐藏，如果要做删除滤芯，请确保滤芯没有被设备类型所用 
     *
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function filterdel($id)
    {
        
    }


    // 图片上传
    public function upload()
    {
        $upload = new \Think\Upload();// 实例化上传类
        $upload->maxSize   =     3145728 ;// 设置附件上传大小
        $upload->exts      =     array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型
        $upload->rootPath  =     './Public/'; // 设置附件上传根目录
        $upload->savePath  =     '/upload/'; // 设置附件上传（子）目录
        // 上传文件 
        $info   =   $upload->upload();
        if(!$info) {// 上传错误提示错误信息
            return false;
            // $this->error($upload->getError());
        }else{
            // 上传成功
            foreach ($info as $file) {
                // dump($info);die;
                $pic[] = $file['savepath'].$file['savename'];
            }
            // $this->success('上传成功！');
            return $pic;
        }
    }

}