<?php
/**
 * Created by PhpStorm.
 * User: 李振东
 * Time: 2018/3/29 下午2:37
 */
namespace Common\Tool;

use Think\Log;
class Common
{

    public static function toJson($e, $msg='', $status=200)
    {
        if(is_array($e)){
            $res=array_merge($e,['status'=>$status,'msg'=>$msg]);
        }else{
            $res = [
                'status' => $e->getCode(),
                'msg' =>   $e->getMessage(),
            ];
        }
        $data['state']   = (!empty($data['status']) and $data['status']== 200) ? "success" : "fail";

        header('Content-Type:application/json; charset=utf-8');
        exit(json_encode($data));
    }





}