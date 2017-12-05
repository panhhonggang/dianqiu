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
       // 根据类型名称进行搜索
        $map = '';
        if(!empty($_GET['typename'])) $map['typename'] = array('like',"%{$_GET['typename']}%");

        $type = M('device_type');
        
        $total =$type->where($map)->count();
        $page  = new \Think\Page($total,8);
        $pageButton =$page->show();

        $list = $type->where($map)->limit($page->firstRow.','.$page->listRows)->select();
        
        $this->assign('list',$list);
        $this->assign('button',$pageButton);
        $this->display();
    }

    public function add()
    {
        if (IS_POST) {
            // dump($_POST);die;
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
       // 根据用户昵称进行搜索
        $map = '';
        if(!empty($_GET['filtername'])) $map['filtername'] = array('like',"%{$_GET['filtername']}%");

        $filter = M('filters');
        
        $total =$filter->where($map)->count();
        $page  = new \Think\Page($total,8);
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
            $mod = D('filters');
            $info = $mod->create();
            
            if($info){
                $res = $mod->where("id=".$_POST['id'])->save();

                if ($res) {
                    $this->success('修改成功啦！',U('Product/filterlist'));
                }else{
                    $this->error('修改失败！');
                }
            }else{
                // getError是在数据创建验证时调用，提示的是验证失败的错误信息
                $this->error($filter->getError());
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

}