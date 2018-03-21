<?php
namespace Admin\Controller;
use Admin\Controller\CommonController;
use Think\Controller;
class PersonnelController extends CommonController
{
    /*
     * 安装人员列表显示
     */
    public function index()
    {
        $map = [];
        $map = I('get.');
//        if ( !empty($map['key']) && !empty($map['value'])  && $map['key'] =='name') {
//            $where['name'] =  array('like', '%'.$map['value'].'%');
//        }
//
//        if ( !empty($map['key']) && !empty($map['value'] && $map['key'] =='phone')) {
//            $where['name'] =  array('like', '%'.$map['value'].'%');
//        }
        // BUG修改 优化搜索条件 2018年03月21日 李振东
        if(!empty($map['value'])){
            if(empty($map['key'])){
                $where['name'] =  array('like', '%'.$map['value'].'%');
                $where['phone'] =  array('like', '%'.$map['value'].'%');
                $where['_logic'] = 'OR';
            }else{
                if($map['key']=='phone'){
                    $where['phone'] = array('like', '%'.$map['value'].'%');
                }elseif($map['key']=='name'){
                    $where['name'] =  array('like', '%'.$map['value'].'%');
                }
            }
        }
//        $uid = $_SESSION['adminuser']['id'];
//        $where['v_id'] = $uid;
//dump($where);die;
        if($this->get_level()){
            $where['v_id'] = $_SESSION['adminuser']['id'];
        }
        $total = M('personnel')->where($where)->count();
        $page  = new \Think\Page($total,8);
        $pageButton =$page->show();

        $list =  M('personnel')->where($where)->limit($page->firstRow.','.$page->listRows)->select();
        $this->assign('list',$list);
        $this->assign('button',$pageButton);
        $this->display();
    }
    /*
     * 安装人员添加
     */
    public function add_pers()
    {
        if (IS_POST) {
            $uid = $_SESSION['adminuser']['id'];
            $personnel = D('personnel');
            $info = $personnel->create();
            if ($info) {
                $map['name'] = I('post.name','','strip_tags');
                $map['phone'] = I('post.phone','','strip_tags');
                $map['_logic'] = 'or';
                //查询用户名和手机是否存在
                $get_info = $personnel->getInfo($map);
                if ($get_info) {
                    $this->error($get_info);
                }
                $data['v_id'] = $uid;
                $data['name'] = I('post.name','','strip_tags');
                $data['phone'] = I('post.phone','','strip_tags');
                $data['password'] = MD5(I('post.password','','strip_tags'));
                $data['create_time'] = date('Y-m-d H:i:s');
                $res = $personnel->add($data);
                if ($res) {
                    $this->success('添加成功',U('Personnel/index'),2);
                } else {
                    $this->success('添加成功',U('Personnel/index'),2);
                }
            } else {
                    $this->error($personnel->getError());
            }
//            if(!preg_match("/^1[34578]{1}\d{9}$/",$phone)) {
//                $this->error('手机号码有误！');
//            }
//
//            if (strlen($password) < 6) {
//                $this->error('密码少于6位！');
//            }
//            if ($password != $repassword) {
//                $this->error('两次密码有误！');
//            }

//            $info = M('personnel')->where($map)->find();
//            if ($info) {
//                $this->error('手机号码或者名字已存在');
//            }
//            $data['name'] = $name;
//            $data['v_id'] = $uid;
//            $data['phone'] = $phone;
//            $data['password'] = MD5($password);
//            $data['create_time'] = date('Y-m-d H:i:s');
//
//            $num = M('personnel')->add($data);
//            if ($num) {
//                $this->success('提交成功',U('Personnel/index'),2);
//            } else {
//                $this->error('添加失败');
//            }
        } else {
            $this->display();
        }


    }
    /*
     * 安装工人删除
     */
    public  function del($id) {
        $where['id'] = $id;
        $where['v_id'] = $_SESSION['adminuser']['id'];
        $info = M('personnel')->where($where)->delete();
        if ($info) {
            $this->success('删除成功',U('Personnel/index'),2);
        } else {
            $this->error('删除失败');
        }
    }
    /*
     * 安装给工人修改
     */
    public function edit($id) {
        if (IS_POST) {
            $name = I('post.name','','strip_tags');
            $phone = I('post.phone','','strip_tags');
            $password = I('post.password','','strip_tags');
            $repassword = I('post.repassword','','strip_tags');
            if(!preg_match("/^1[34578]{1}\d{9}$/",$phone)) {
                $this->error('手机号码有误！');
            }

            if (strlen($password) < 6) {
                $this->error('密码少于6位！');
            }
            if ($password != $repassword) {
                $this->error('两次密码有误！');
            }

            //查询条件
            $map_w['id'] = I('post.id');
            $map_w['v_id'] = $_SESSION['adminuser']['id'];
            $data['name'] = $name;
            $data['phone'] = $phone;
            $data['password'] = MD5($password);
            $data['create_time'] = date('Y-m-d H:i:s');
            $info = M('personnel')->where($map_w)->save($data);
            if ($info) {
                $this->success('修改成功',U('Personnel/index'),2);
            } else {
                $this->error('修改失败');
            }
        } else {
            $where['id'] = $id;
            $where['v_id'] = $_SESSION['adminuser']['id'];
            $info = M('personnel')->where($where)->find();
            $this->assign('info',$info);
            $this->display();
        }
    }

}