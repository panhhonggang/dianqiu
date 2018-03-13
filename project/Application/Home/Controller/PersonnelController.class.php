<?php
namespace Home\Controller;
use Think\Controller;
use \Org\Util\WeixinJssdk;
/**
 * 安装人员系统
 */
class PersonnelController extends Controller
{

    /*
     * 安装人员登录页面
     */
    public function login()
    {
        if (IS_POST) {
            $where['phone'] = I('post.phone', '', 'strip_tags');
            $where['password'] = MD5(I('post.password', '', 'strip_tags'));
            $perSonnel = D('Personnel');
            $get_info = $perSonnel->getInfo($where);
            if ($get_info['code'] == 403) {
                $this->error($get_info['message']);
            }
            if ($get_info['code'] == 200) {
                session('pid', $get_info['data']['id']);
                $this->success($get_info['message']);
            }
        }
        $this->display();
    }

    /*
     * 安装人员登录成功首页
     */
    public function index()
    {

        $this->display('index');

    }
    /*
     * 点击安装之后页面
     */
    public function personal(){
        //个人资料
        $user= M('personnel')->field('name,phone')->where('id', '=',23)->find();
        $this->assign('user', $user);
        $this->display();
    }
    /*
     * 安装设备列表
     */
    public function dutyList(){
        $this->display();
    }
    /*
     * 安装设备添加
     */
    public function per_detail()
    {
        $map['personnel_id'] = 23;
        $map['id'] = 2;
        //查询数据
        $perSonnel_info = D('Personnel');
        $info = $perSonnel_info->per_detail();


    }
}