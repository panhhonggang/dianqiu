<?php
namespace Admin\Controller;
use Admin\Controller\CommonController;
use Think\Controller;

class RuleController extends CommonController
{
    public function getAllrules()
    {
        $res = M('auth_rule')->select();

        dump($res);

        $this->assign('res', $res);
        $this->display('rule_list');
    }

    public function user_group()
    {
        $res = M('auth_group')->select();
        $data = array_column($res, 'rules', 'id');
        dump($data);
        

        $this->assign('res', $res);
        $this->display('user_group_list');
    }
}