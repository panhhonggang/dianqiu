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
    }

    /*
     * 安装人员登录成功首页
     */
    public function index()
    {
        //个人资料
        $info = M('personnel')->where('id', '=', session('pid'))->find();

        $this->assign('info', $info);

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