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
        /*
             Excel导出
          */
        // dump($phpExcel);
        // 搜索功能
        if (trim(I('post.name'))) {
            $map['name'] = array('like','%'.trim(I('post.name')).'%');
        }
        if (trim(I('post.phone'))) {
            $map['phone'] = array('like','%'.trim(I('post.phone')).'%');
        }

        if($this->get_level()){
            $map['v_id'] = $_SESSION['adminuser']['id'];
        }

        $mincreate_time = strtotime(trim(I('post.mincreate_time')))?:0;
        $maxcreate_time = strtotime(trim(I('post.maxcreate_time')))?:-1;
        if (is_numeric($maxcreate_time)) {
            $map['unix_timestamp(create_time)'] = array(array('egt',$mincreate_time),array('elt',$maxcreate_time));
        }
        if ($maxcreate_time < 0) {
            $map['unix_timestamp(create_time)'] = array(array('egt',$mincreate_time));
        }
        // 删除数组中为空的值
        $map = array_filter($map, function ($v) {
            if ($v != "") {
                return true;
            }
            return false;
        });

        // PHPExcel 导出数据
        if (I('output') == 1) {
            $data =M('personnel')->where($map)
                                ->field('id,name,phone,create_time')
                                ->order('id desc')
                                ->select();
            $filename = '安装人员列表数据';
            $title = '安装人员列表';
            $cellName = ['用户id','昵称','手机','最新添加时间'];
            // dump($data);die;
            $myexcel = new \Org\Util\MYExcel($filename,$title,$cellName,$data);
            $myexcel->output();
            return ;
        }

        $total = M('personnel')->where($map)->count();
        $page  = new \Think\Page($total,8);
        $pageButton =$page->show();

        $list =  M('personnel')->where($map)->limit($page->firstRow.','.$page->listRows)->order('id desc')->select();
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

                $password = I('post.password','','strip_tags');
                $repassword = I('post.repassword','','strip_tags');


                if (strlen($password) < 6) {
                    $this->error('密码少于6位！');
                }
                if ($password != $repassword) {
                    $this->error('两次密码有误！');
                }


                $data['v_id'] = $uid;
                $data['name'] = I('post.name','','strip_tags');
                $data['phone'] = I('post.phone','','strip_tags');
                $data['password'] = MD5($password);
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