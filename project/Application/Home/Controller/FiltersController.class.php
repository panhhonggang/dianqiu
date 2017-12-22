<?php
namespace Home\Controller;
use Think\Controller;


class FiltersController extends CommonController 
{
    // 商城首页
    public function index()
    {
        // 显示模板
        $this->display();
    }

    // 商城充值套餐和滤芯产品
    public function filterDetails()
    {
        $this->display();
    }

}

