<?php
namespace Home\Controller;
use Think\Controller;


class FiltersController extends CommonController 
{

    // 滤芯详请
    public function filterDetails()
    {
        $code = M('devices')->where("id={$_SESSION['homeuser']['did']}")->find();
        $type = M('device_type')->where("id={$code['type_id']}")->find();
        unset($type['id'], $type['typename'], $type['addtime']);
        $sum = array_filter($type);
        foreach ($sum as $key => $value) {
            $str = stripos($value,'-');
            $map['filtername'] = substr($value, 0,$str);
            $map['alias'] = substr($value, $str+1);
            $res[] = M('filters')->where($map)->find();
        }
        $assign = array('res', json_encode($res));
        $this->assign($res);
        $this->display();
    }

}

