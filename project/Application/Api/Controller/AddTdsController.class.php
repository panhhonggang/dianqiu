<?php
namespace Api\Controller;
use Think\Controller;

/**
* 计划任务执行时，指将添加净水记录
*/
class AddTdsController extends Controller
{
    
    public function index()
    {
        // 查询所有的设备数据
        $data = M('devices_statu')->field('DeviceID,RawTDS,PureTDS')->select();
        // dump($data);die;
        self::action($data);
        
    }

    // 数据处理
    private static function action($data)
    {
        $map['day'] = date('d', time());
        $map['date'] = date('Ym', time());
        // 遍历存入数据库
        foreach($data as $key => $value)
        {
            $value['dcode'] = $value['deviceid'];
            $value['raw'] = $value['rawtds'];
            $value['pure'] = $value['puretds'];
            $value['dcode'] = $value['deviceid'];
            $arr = array_merge($map,$value);
            if($value['raw'] != null || $value['pure'] != null){
                $res = M('Tds')->add($arr);
            }
        }
    }
}