<?php
namespace Admin\Controller;
use Think\Controller;
use Admin\Controller\CommonController;
class IndexController extends CommonController {
    public function index(){
        $this->display('index');
    }

    public function welcome()
    {
        $this->show('<h1>欢迎回来！</h1>');
    }
}