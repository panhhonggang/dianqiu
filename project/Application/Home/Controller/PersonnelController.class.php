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
    public function  login() {
        if (IS_POST) {
            $where['phone'] = I('post.phone','','strip_tags');
            $where['password'] = MD5(I('post.password','','strip_tags'));
            $perSonnel = D('Personnel');
            $get_info  = $perSonnel->getInfo($where);
            if ($get_info['code'] == 403) {
                $this->error($get_info['message']);
            }
            if ($get_info['code'] == 200) {
                $this->success($get_info['message']);
            }

        }
    }
}