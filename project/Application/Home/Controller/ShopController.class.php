<?php
namespace Home\Controller;
use Think\Controller;
use \Org\Util\WeixinJssdk;

class ShopController extends CommonController 
{

    // 商城充值套餐和滤芯产品filterElement
    public function index()
    {

        $dcode = I('get.dcode');
    	// 获取用户uid
        $uid = $_SESSION['homeuser']['id'];
        $did = $_SESSION['homeuser']['did'];
        $device = M('devices')->where('id='.$did)->find();

        // 获取用户绑定设备充值套餐
        if($uid){
            // 查询用户绑定设备使用的套餐产品
            // remodel:充值模式 money:套餐金额 flow:套餐流量/时长 describe:套餐描述
            // $setmeallist = M('Setmeal')->field('pub_setmeal.id,remodel,money,flow,describe')
            // // 当前设备表
            // ->join('pub_current_devices ON  pub_current_devices.uid='.$uid)
            // // 连接设备表
            // ->join('pub_devices ON pub_devices.id =pub_current_devices.did')
            // // 查询一条
            // ->select();

            $setmeallist = M('Setmeal')
                ->alias('s')
                ->where('cd.uid='.$uid)
                ->join('__DEVICES__ d ON s.tid=d.type_id','LEFT')
                ->join('__CURRENT_DEVICES__ cd ON d.id=cd.did','LEFT')
                ->field('cd.*,d.*,s.*')
                ->select();


            $Model = M('Filters');
            // 查询用户绑定设备使用的滤芯产品
            $filters = $Model->field('filter1,filter2,filter3,filter4,filter5,filter6,filter7,filter8')
            // 连接设备表
            ->join('pub_devices ON pub_devices.id ='.$did)
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

            // 查询用户购物车
            // 统计查询套餐产品数量
            $smealNum = M('cartSetmeal')->where("`uid`='{$uid}'")->sum('num');
            // 统计查询滤芯产品数量
            $filtersNum = M('cartFilters')->where("`uid`='{$uid}'")->sum('num');
            // 购物车商品数量
            $cartNum = $smealNum+$filtersNum;

            // 分配数据到模板
            $this->assign('setmeallist',$setmeallist);
            $this->assign('filtersList',$filtersList);
            $this->assign('device',$device);
            $this->assign('cartNum',$cartNum);
        }

        //调用微信JS-SDK类获取签名需要用到的数据
        $weixin = new WeixinJssdk;
        $signPackage = $weixin->getSignPackage();

        // 查询用户微信中的openid
        //$openId = $weixin->GetOpenid();
        // 调试用默认用户
        $openId = $_SESSION['homeuser']['open_id'];
        //分配数据        
        $this->assign('info',$signPackage);
        $this->assign('openId',$openId);
        if ($dcode !='') {

            if (empty(session('pid'))) {
                $this->error('请登录');
            }
            $where['device_code'] = $dcode;
            $where['uid'] = array('neq','');
            $info_code = M('Devices')->where($where)->find()['id'];
            if ($info_code) {
                $this->assign('dcode',$dcode);
                $this->display('daichong');
            } else {
                $this->error('该设备有误或者未绑定 请重新输入');
            }

        } else {
            $this->display();
        }

    }
    // 套餐确认
    public function sureSetmeal()
    {
        // 获取用户uid
        $uid = $_SESSION['homeuser']['id'];
        // 判断是否点击立即购买过去结算
        if($uid){
            // 遍历购物车
            // 遍历用户购物车套餐
            $setmeal = M('cartSetmeal')
            ->where("`uid`='{$uid}' AND `num`>0")
            ->join('pub_setmeal ON pub_setmeal.id = pub_cart_setmeal.sid')
            ->select();

            $totalAmount = 0;
            $totalNum = 0;
            // 统计套餐总金额
            foreach ($setmeal as $value) {
                $totalAmount += $value['num']*$value['money'];
                $totalNum += $value['num'];
            }

            // 分配数据
            $this->assign('setmeal',$setmeal);
            $this->assign('totalAmount',$totalAmount);
            $this->assign('totalNum',$totalNum);

            //调用微信JS-SDK类获取签名需要用到的数据
            $weixin = new WeixinJssdk;
            $signPackage = $weixin->getSignPackage();
            // 查询用户微信中的openid
            $openId = $weixin->GetOpenid();

            //分配数据        
            $this->assign('info',$signPackage);
            $this->assign('openId',$openId);

            // 显示模板
            $this->display(); 
        } 
    }
}

