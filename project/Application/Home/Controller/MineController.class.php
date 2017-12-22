<?php
namespace Home\Controller;
use Think\Controller;


class MineController extends CommonController 
{
    // 我的首页
    public function index()
    {
        // 显示模板
        $this->display();
    }

    // 建议页面
    public function proposal()
    {
        $this->display();
    }

}

