<?php
namespace Home\Controller;
use Think\Controller;


class WaterPurifierController extends CommonController 
{
    // 净水机首页
    public function index()
    {
        // 显示模板
        $this->display();
    }

    // 净水记录页面
    public function record()
    {
        $this->display();
    }
    
    // 绑定指引页面
    public function binding()
    {
        $this->display();
    }
    

}

