<?php
namespace Api\Controller;
use Think\Controller;
use Think\Log;
use Org\Util\Gateway;
class TmpController extends Controller
{
    public function __construct()
    {
        parent::__construct();
        Gateway::$registerAddress = '127.0.0.1:9504';
    }

    /**
     * 发送信息
     * @param $msg
     */
    public function sendMsg($msg)
    {
        if($msg['DeviceID']){
            Gateway::sendToUid($msg['DeviceID'],$msg);
        }
    }

    public function test()
    {
        if(IS_POST){

        }
        $this->display();
    }
}