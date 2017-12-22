<?php
namespace Home\Controller;
use Think\Controller;


class DevicesController extends CommonController 
{
    // 设备首页
    public function index()
    {
        // 显示模板
        $this->display();
    }

    // 设备管理页面
    public function manage()
    {
        $this->display();
    }

}

