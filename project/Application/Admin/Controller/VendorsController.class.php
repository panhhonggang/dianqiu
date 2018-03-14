<?php
namespace Admin\Controller;
use Think\Controller;

/**
 * 经销商控制器
 * 
 * @author 潘宏钢 <619328391@qq.com>
 */

class VendorsController extends CommonController 
{
	/**
     * 经销商列表（本质就是后台用户）
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function index()
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
            'user' => trim(I('post.user')),
            'name' => trim(I('post.name')),
            'phone' => trim(I('post.phone')),
            'email' => trim(I('post.email')),
            'address' => trim(I('post.address')),
            'idcard' => trim(I('post.idcard')),
            'leavel' => trim(I('post.leavel')),
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

        $user = D('vendors');
        // PHPExcel 导出数据
        if (I('output') == 1) {
            $data = $user->where($map)
                        ->field('id,user,name,phone,email,address,idcard,leavel,addtime')
                        ->select();
            $filename = '经销商列表数据';
            $title = '经销商列表';
            $cellName = ['用户Id','账号','昵称','手机号','邮箱','地址','身份证号','管理级别','最新添加时间'];
            // dump($data);die;
            $myexcel = new \Org\Util\MYExcel($filename,$title,$cellName,$data);
            $myexcel->output();
            return ;
        }



        $total = $user->where($map)->count();
        $page  = new \Think\Page($total,8);
        D('devices')->getPageConfig($page);
        $pageButton =$page->show();

        $userlist = $user->where($map)->limit($page->firstRow.','.$page->listRows)->getAll();

        $this->assign('list',$userlist);
        $this->assign('button',$pageButton);
        $this->display();
    }

    /**
     * 添加经销商方法
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function add()
    {
        if(IS_POST){

            $user = D('vendors');
            $info = $user->create();

            if($info){

                $res = $user->add();
                if ($res) {
                    $this->success('添加经销商成功啦！！！',U('Vendors/index'));
                } else {
                    $this->error('添加经销商失败啦！');
                }
            
            } else {
                // getError是在数据创建验证时调用，提示的是验证失败的错误信息
                $this->error($user->getError());
            }
        }else{
            $this->display();
        }
    }

    /**
     * 编辑经销商方法
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function edit($id)
    {
        if(IS_POST){
            $user = D('vendors');
            if(empty($_POST['password'])) {
                unset($_POST['password']);
            } else {
                $_POST['password'] = md5($_POST['password']);
            }
            // empty($_POST['password'])?unset($_POST['password']):$_POST['password'];
            $userinfo = $user->create();
            if ($userinfo) {
                $res = $user->save();
                if($res && $_SESSION['adminuser']['id'] == $_POST['id']) {
                    $this->success('编辑经销商成功啦！！！',U('Login/login'));
                    exit;
                }
                if ($res) {
                    $this->success('编辑经销商成功啦！！！',U('Vendors/index'));
                } else {
                    $this->error('编辑经销商失败啦！');
                }                
            }else{
                $this->error($user->getError());
            }

        } else {
            $info[] = D('vendors')->find($id);
            $this->assign('info',$info);
            $this->display();
        }
    }
    
    /**
     * 删除经销商方法
     * 需保证其没有下级，没有设备与之挂钩
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function del($id)
    {
        $userinfo = M('vendors')->where("id=".$id)->select();

        if ($userinfo[0]['leavel'] == 0 ) {
            $this->error('不能删除超级管理员！');
        }else{
            $res = M('binding')->where("vid=".$id)->select();
            if(!empty($res)){
                $this->error('已绑定设备，不可删除');
                return false;
            }
            // 查
            $res = D('vendors')->delete($id);
            if($res){
                $this->success('删除成功',U('index'));
            }else{
                $this->error('删除失败');
            }

        }
    }

    /**
     * 机组绑定经销商方法
     * 
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function devices_add()
    {
        if (IS_POST) {
            if ($_POST['did']) {

                if ($_POST['vid']) {
                   
                    $arr = array(
                        'vid' => I('vid'),
                        'did' => I('did'),
                        'operator' => $_SESSION['adminuser']['name'],
                        'addtime' => time(),
                    );
                    
                    // 添加
                    $binding = M('binding');
                    if ($binding->add($arr)) {
                        // 更改设备的绑定状态
                        $devices = M('devices');  
                        $devices->where('id='.$_POST['did'])->setField('binding_statu','1');

                        $this->success('添加成功',U('bindinglist'));
                    }else{
                        $this->error('添加失败啦');
                    }

                }else{
                    $this->error('经销商不存在！请在经销商管理中添加经销商后尝试！正在为您跳转至经销商管理',U('index')); 
                }

            }else{
                $this->error('设备不存在或已无未绑定设备！请在设备管理中添加设备后尝试！正在为您跳转至设备管理',U('Devices/show_add_device'),5);
            }   

        }else{

            if(!empty($_SESSION['adminuser'])){
                // 获取经销商信息
                $case = $_SESSION['adminuser']['leavel'];

                switch ($case) {
                    
                    case '0':
                        $user = D('vendors')->getAll();
                        break;

                    case '1':
                    // 一级经销商只能给二级经销商绑定设备，如需再往下分级，则case '2' leavel=3
                        $user = M('vendors')->where('leavel=2')->select();

                        break;    
                    
                    default:
                        # code...
                        break;
                }

                // 获取设备信息
                $devices = M('devices')->where('binding_statu=0')->select();

                $this->assign('user',$user);
                $this->assign('devices',$devices);
                $this->display();
            }else{
                $this->error('登录失效，请重新登陆！',U('Login/login'));
            }
            
        }

    }

    /**
     * 设备所属经销商列表
     * 
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function bindinglist()
    {
        if($this->get_level()){
            $map['pub_vendors.id'] = $_SESSION['adminuser']['id'];
        }
        /*
             Excel导出
          */
        require_once VENDOR_PATH.'PHPExcel.php';
        $phpExcel = new \PHPExcel();
        // dump($phpExcel);
        // 搜索功能
        $map = array(
            'pub_binding.vid' => trim(I('post.vid')),
            'pub_binding.did' => trim(I('post.did')),
            'pub_devices.device_code' => trim(I('post.device_code')),
            'pub_vendors.phone' => trim(I('post.phone')),
            'pub_vendors.name' => trim(I('post.name'))
        );
        // $minaddtime = trim(I('post.minaddtime'))?:0;
        // $maxaddtime = trim(I('post.maxaddtime'))?:-1;
        // if (is_numeric($maxaddtime)) {
        //     $map['pub_binding.addtime'] = array(array('egt',$minaddtime),array('elt',$maxaddtime));
        // }
        // if ($maxaddtime < 0) {
        //     $map['pub_binding.addtime'] = array(array('egt',$minaddtime));
        // }
        // 删除数组中为空的值
        $map = array_filter($map, function ($v) {
            if ($v != "") {
                return true;
            }
            return false;
        });

        $binding = M('binding');
        // PHPExcel 导出数据
        if (I('output') == 1) {
            $data = $binding->where($map)
                ->join('pub_vendors ON pub_binding.vid = pub_vendors.id')
                ->join('pub_devices ON pub_binding.did = pub_devices.id')
                ->field('pub_vendors.id,pub_binding.did,pub_devices.device_code,pub_vendors.name,pub_vendors.phone,pub_binding.addtime')
                ->select();
            $filename = '设备归属列表数据';
            $title = '设备归属列表';
            $cellName = ['经销商id','设备id','设备编码','经销商姓名','经销商手机','添加时间'];
            // dump($data);die;
            $myexcel = new \Org\Util\MYExcel($filename,$title,$cellName,$data);
            $myexcel->output();
            return ;
        }


        
        $total =$binding->where($map)
                    ->join('pub_vendors ON pub_binding.vid = pub_vendors.id')
                    ->join('pub_devices ON pub_binding.did = pub_devices.id')
                    ->field('pub_binding.*,pub_vendors.name,pub_vendors.phone,pub_devices.device_code')
                    ->count();
        $page  = new \Think\Page($total,8);
        $pageButton =$page->show();

        $bindinglist = $binding->where($map)
                                ->limit($page->firstRow.','.$page->listRows)
                                ->join('pub_vendors ON pub_binding.vid = pub_vendors.id')
                                ->join('pub_devices ON pub_binding.did = pub_devices.id')
                                ->field('pub_binding.*,pub_vendors.name,pub_vendors.phone,pub_devices.device_code')
                                ->select();
//        dump($map);
        $this->assign('list',$bindinglist);
        $this->assign('button',$pageButton);
        $this->display(); 
    }

    /**
     * 解除绑定方法
     * 
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function bindingdel($id,$did)
    {
        
        if ($_SESSION['adminuser']['leavel'] == 0) {
            
            $res = D('binding')->delete($id);
            if($res){
                // 更新设备绑定状态
                $devices = M('devices');  
                $devices->where('id='.$did)->setField('binding_statu','0');
                $this->success('解除成功',U('bindinglist'));
            }else{
                $this->error('解除失败');
            }

        }else{
           $this->error('对不起，您没有权限解除绑定！',U('bindinglist'));
        }
    }

    /**
     * 修改密码方法
     * 
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function password()
    {
        if (IS_POST) {
            $old = md5(I('oldpassword')); 
            $new = md5(I('newpassword')); 
            $re = md5(I('repassword'));
            $id = I('id');
            if($old === $new) $this->error('新密码与旧密码一致');
            if ($new == $re) {
                $user = M('Vendors');
                $info = $user->where('id='.$id)->getField('password');
                
                if ($old == $info) {
                    $res = $user->where('id='.$id)->setField('password',$new);
                    if ($res) {
                        $this->success('修改密码成功，请重新登录！',U('Login/logout'));
                    }else{
                        $this->error('修改密码失败！');
                    }

                }else{
                    $this->error('原密码错误，请重新输入！');
                }

            }else{
                $this->error('两次密码不一样，请重新输入！');
            }

        }else{
            $this->display();
        }
    }

}