<?php
namespace Admin\Controller;
use Think\Controller;

class MenuController extends CommonController
{
    public function index(){
        $data=D('AdminMenu')->getTreeData('tree','order_number,id');
        $assign=array(
            'data'=>$data
            );

        // dump($data['_data']);die;
        $this->assign($assign);
        $this->display();
    }

    /**
     * 添加菜单
     */
    public function add(){
        $data=I('post.');
        unset($data['id']);
        $result=D('AdminMenu')->addData($data);
        if ($result) {
            $this->success('添加成功',U('Admin/Menu/index'));
        }else{
            $this->error('添加失败');
        }
    }

    /**
     * 修改菜单
     */
    public function edit(){
        $data=I('post.');
        $map=array(
            'id'=>$data['id']
            );
        $result=D('AdminMenu')->editData($map,$data);
        if ($result) {
            $this->success('修改成功',U('Admin/Menu/index'));
        }else{
            $this->error('修改失败');
        }
    }

    /**
     * 删除菜单
     */
    public function delete(){
        $id=I('get.id');
        $map=array(
            'id'=>$id
            );
        $result=D('AdminMenu')->deleteData($map);
        if($result){
            $this->success('删除成功',U('Admin/Menu/index'));
        }else{
            $this->error('请先删除子菜单');
        }
    }

    /**
     * 菜单排序
     */
    public function order(){
        $data=I('post.');
        $result=D('AdminMenu')->orderData($data);
        if ($result) {
            $this->success('排序成功',U('Admin/Menu/index'));
        }else{
            $this->error('排序失败');
        }
    }

}