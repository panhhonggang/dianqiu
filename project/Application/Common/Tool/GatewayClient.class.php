<?php
/**
 * Created by PhpStorm.
 * User: 李振东
 * Time: 2018/3/29 下午2:37
 */
namespace Common\Tool;
use Org\Util\Gateway;
use Think\Log;
class GatewayClient
{

    private static $actionlist = [
        '1'=>['ctrolCmd'=>1,'DeviceID'=>'','Pram'=>1],  //开机
        '2'=>['ctrolCmd'=>1,'DeviceID'=>'','Pram'=>0],  //关机
        '3'=>['ctrolCmd'=>2,'DeviceID'=>'','Pram'=>1],  //冲洗
        '4'=>['ctrolCmd'=>2,'DeviceID'=>'','Pram'=>0],  //取消冲洗
        '5'=>['ctrolCmd'=>3,'DeviceID'=>'','Pram'=>[]], //复位滤芯  "Pram":[1,2] 滤芯级数
        '6'=>['ctrolCmd'=>4,'DeviceID'=>'','Pram'=>1],  //绑定设备
        '7'=>['ctrolCmd'=>4,'DeviceID'=>'','Pram'=>0],  //解绑设备
        '8'=>['ctrolCmd'=>5,'DeviceID'=>'','Pram'=>['mode'=>2,'val'=>0]],//充值100天  "Pram":{"mode":2,”val”:100}
        '9'=>['ctrolCmd'=>5,'DeviceID'=>'','Pram'=>['mode'=>1,'val'=>0]],//充值100L   "Pram":{"mode":1,”val”:100}}
        '10'=>['ctrolCmd'=>6,'DeviceID'=>'','Pram'=>2], //租赁模式修改  'Pram' 0 买断模式  1 流量 2 时长 3 时长和流量
        '11'=>['ctrolCmd'=>7,'DeviceID'=>'','Pram'=>0], //滤芯模式修改  'Pram' 0 时长 1 流量 2 时长和流量
    ];

    const HOST = '192.168.0.113';
    const PORT = '9980';

    /**
     * 命令调用
     * @param $mode
     * @param $deviceID
     * @param string $data
     * @return bool
     */
    public static function action($mode, $deviceID, $data='')
    {
        if(empty($deviceID)){
            return false;
        }

        if( empty(self::$actionlist[$mode]) ){
            return false;
        }else{
            $message = self::$actionlist[$mode];
        }
        $message['DeviceID'] = $deviceID;

        $mode = (string)$mode;
        switch ($mode){
            case '5':
            case '8':
            case '9':
            case '10':
            case '11':
                $message['Pram'] = $data;
                break;
        }

        return self::sendMsg(json_encode($message) );
    }

    /**
     * TCP 信息发送
     * @param $message
     * @return bool
     */
    public static function sendMsg($message)
    {

        $socket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP) or die("Could not create  socket\n");
        socket_set_option($socket,SOL_SOCKET,SO_RCVTIMEO,array("sec"=> 3, "usec"=> 0 ) );
        $connection = socket_connect($socket, self::HOST, self::PORT) or die("Could not connet server\n");
        socket_write($socket, $message) or die("Write failed\n");

        while ($out = socket_read($socket, 1024)) {
             //echo "接收服务器回传信息成功！\n";
             //echo "接受的内容为:", $out;
            $res = json_decode($out);
            if(!empty($res->reqCode)){
                return true;
            }else{
                return false;
            }
        }
        return false;
    }

    // 设备绑定
    public static function bind( $client_id, $deviceID )
    {
        Gateway::joinGroup( $client_id, $deviceID );
        return true;
    }
}