<?php
namespace Home\Controller;
use Think\Controller;
use \Org\Util\WeixinJssdk;

class ShopController extends CommonController 
{
    // 商城首页
    public function index()
    {

        // 显示模板
        $this->display();
    }

    // 商城充值套餐和滤芯产品
    public function filterElement()
    {
    	// 获取用户open_id
        $openId = $_SESSION['homeuser']['open_id'];

        // 获取用户绑定设备充值套餐
        if($openId){
            // 查询用户绑定设备使用的套餐产品
            // remodel:充值模式 money:套餐金额 flow:套餐流量/时长 describe:套餐描述
            $setmeallist = M('Setmeal')->field('pub_setmeal.id,remodel,money,flow,describe')
            // 连接用户表 pub_users.open_id = 公众号唯一ID
            ->join('pub_users ON pub_users.open_id = "'.$openId.'"')
            // 连接用户和设备关联表
            ->join('pub_current_devices ON pub_current_devices.uid = pub_users.id')
            // 连接设备表
            ->join('pub_devices ON pub_devices.id = pub_current_devices.did')
            // 查询一条
            ->select();

            $Model = M('Filters');
            // 查询用户绑定设备使用的滤芯产品
            $filters = $Model->field('filter1,filter2,filter3,filter4,filter5,filter6,filter7,filter8')
            // 连接用户表 pub_users.open_id = 公众号唯一ID
            ->join('pub_users ON pub_users.open_id = "'.$openId.'"')
            // 连接用户和设备关联表
            ->join('pub_current_devices ON pub_current_devices.uid = pub_users.id')
            // 连接设备表
            ->join('pub_devices ON pub_devices.id = pub_current_devices.did')
            // 连接设备类型表
            ->join('pub_device_type ON pub_device_type.id = pub_devices.type_id')
            // 查询一条
            ->find();

            if(is_array($filters)){
                // 删除数组中的空元素
                $filters = array_filter($filters);
                // 准备新数组准备装切割后的值
                $newArr = array();
                // 切割数组中的值装进新数组
                foreach ($filters as $value) {
                    // 切割
                    $newArr[] = explode('-',$value,2);
                }

                $filtersList = array();
                // 遍历数组拼接查询语句
                foreach ($newArr as $value) {
                    $data['filtername'] = $value[0];
                    $data['alias'] = $value[1];
                    $filtersList[] = $Model->where($data)->find();
                }
            }
            $this->assign('setmeallist',$setmeallist);
            $this->assign('filtersList',$filtersList);
            // dump($filtersList);
        }

        $this->display();
    }
}