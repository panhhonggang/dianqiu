<?php
namespace Home\Controller;
use Think\Controller;
use \Org\Util\WeixinJssdk;

class ShopController extends CommonController
{

    // 商城充值套餐和滤芯产品filterElement
      public function index()
    {

        $dcode =  I('get.dcode');

        if(!preg_match("/^\d*$/",$dcode)) {
            $this->error('设备号码有误');
        };
        // 获取用户uid
        $uid = $_SESSION['homeuser']['id'];
        if ($dcode !='') {
            $dcode = I('get.dcode');
            $device = M('devices')->where('device_code='.$dcode)->find();

            if (!empty($device)) {
                $did = $device['id'];
            } else {
                $this->error('无该设备码');
            }



        } else {
            $did = $_SESSION['homeuser']['did'];
            if (empty($did)) {
                $this->error('请填写设备号码');
            }
            $device = M('devices')->where('id='.$did)->find();
        }

//        $device = M('devices')->where('id='.$did)->find();
//        $device = M('devices')->where('device_code='.$did)->find();

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
//            $device = M('current_devices')->where('uid='.$uid)->select();
//            if ($device['bindtime']) {
//                $bindtime = $device['bindtime'];
//            }else{
//                $bindtime = time();
//            }



//            $flow = M('flow')->where('did='.$device[0]['id'])->order('addtime desc')->limit(0,1)->select();


//            $flowtime = $flow[0]['addtime'];
            // dump(time());die;

            $devices_alivestause = M('current_devices')
                ->alias('c')
                ->where(['c.uid'=>$uid])
                ->join('__DEVICES__ d ON c.did=d.id','LEFT')
                ->join('__DEVICES_STATU__ ds ON d.device_code=ds.DeviceID','LEFT')
                ->getfield('ds.alivestause');

            $devices_alivestause = isset($devices_alivestause)?$devices_alivestause:0;
            if ( $devices_alivestause!=0) {
                $where['cd.did'] = $did;
                $where['s.status'] = 0;
                $setmeallist = M('Setmeal')
                ->alias('s')
                ->where($where)
                ->join('__DEVICES__ d ON s.tid=d.type_id','LEFT')
                ->join('__CURRENT_DEVICES__ cd ON d.id=cd.did','LEFT')
                ->field('cd.*,d.*,s.*')
                ->select();
            }else{
                
                $where['cd.did'] = $did;
                $where['status'] = 1;
                $setmeallist = M('Setmeal')
                ->alias('s')
                ->where($where)
                ->join('__DEVICES__ d ON s.tid=d.type_id','LEFT')
                ->join('__CURRENT_DEVICES__ cd ON d.id=cd.did','LEFT')
                ->field('cd.*,d.*,s.*')
                ->select();
            }
        
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
    public function charge()
    {

        $dcode =  I('get.dcode');

        if(!preg_match("/^\d*$/",$dcode)) {
            $this->error('设备号码有误');
        };
        // 获取用户uid
        $uid = $_SESSION['homeuser']['id'];
        if ($dcode !='') {

            $dcode = I('get.dcode');
            $device = M('devices')->where('device_code='.$dcode)->find();

            if (!empty($device)) {
                $did = $device['id'];
            } else {
                $this->error('无该设备码');
            }
        } else {
            $this->error('请填写设备号码');
        }
        if($uid){


            $setmeallist = M('Setmeal')
                ->alias('s')
                ->where('cd.did='.$did)
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

//            if (empty(session('pid'))) {
//                $this->error('请登录');
//            }
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
            $this->display('daichong');
        }

    }
    // public function index()
    // {

    //     $dcode = I('get.dcode');
    // 	// 获取用户uid
    //     $uid = $_SESSION['homeuser']['id'];
    //     $did = $_SESSION['homeuser']['did'];
    //     $device = M('devices')->where('id='.$did)->find();

    //     // 获取用户绑定设备充值套餐
    //     if($uid){
    //         // 查询用户绑定设备使用的套餐产品
    //         // remodel:充值模式 money:套餐金额 flow:套餐流量/时长 describe:套餐描述
    //         // $setmeallist = M('Setmeal')->field('pub_setmeal.id,remodel,money,flow,describe')
    //         // // 当前设备表
    //         // ->join('pub_current_devices ON  pub_current_devices.uid='.$uid)
    //         // // 连接设备表
    //         // ->join('pub_devices ON pub_devices.id =pub_current_devices.did')
    //         // // 查询一条
    //         // ->select();

    //         $setmeallist = M('Setmeal')
    //             ->alias('s')
    //             ->where('cd.uid='.$uid)
    //             ->join('__DEVICES__ d ON s.tid=d.type_id','LEFT')
    //             ->join('__CURRENT_DEVICES__ cd ON d.id=cd.did','LEFT')
    //             ->field('cd.*,d.*,s.*')
    //             ->select();


    //         $Model = M('Filters');
    //         // 查询用户绑定设备使用的滤芯产品
    //         $filters = $Model->field('filter1,filter2,filter3,filter4,filter5,filter6,filter7,filter8')
    //         // 连接设备表
    //         ->join('pub_devices ON pub_devices.id ='.$did)
    //         // 连接设备类型表
    //         ->join('pub_device_type ON pub_device_type.id = pub_devices.type_id')
    //         // 查询一条
    //         ->find();
    //         if(is_array($filters)){
    //             // 删除数组中的空元素
    //             $filters = array_filter($filters);
    //             // 准备新数组准备装切割后的值
    //             $newArr = array();
    //             // 切割数组中的值装进新数组
    //             foreach ($filters as $value) {
    //                 // 切割
    //                 $newArr[] = explode('-',$value,2);
    //             }

    //             $filtersList = array();
    //             // 遍历数组拼接查询语句
    //             foreach ($newArr as $value) {
    //                 $data['filtername'] = $value[0];
    //                 $data['alias'] = $value[1];
    //                 $filtersList[] = $Model->where($data)->find();
    //             }
    //         }

    //         // 查询用户购物车
    //         // 统计查询套餐产品数量
    //         $smealNum = M('cartSetmeal')->where("`uid`='{$uid}'")->sum('num');
    //         // 统计查询滤芯产品数量
    //         $filtersNum = M('cartFilters')->where("`uid`='{$uid}'")->sum('num');
    //         // 购物车商品数量
    //         $cartNum = $smealNum+$filtersNum;

    //         // 分配数据到模板
    //         $this->assign('setmeallist',$setmeallist);
    //         $this->assign('filtersList',$filtersList);
    //         $this->assign('device',$device);
    //         $this->assign('cartNum',$cartNum);
    //     }

    //     //调用微信JS-SDK类获取签名需要用到的数据
    //     $weixin = new WeixinJssdk;
    //     $signPackage = $weixin->getSignPackage();

    //     // 查询用户微信中的openid
    //     //$openId = $weixin->GetOpenid();
    //     // 调试用默认用户
    //     $openId = $_SESSION['homeuser']['open_id'];
    //     //分配数据
    //     $this->assign('info',$signPackage);
    //     $this->assign('openId',$openId);
    //     if ($dcode !='') {
    //         $this->assign('dcode',$dcode);
    //         $this->display('daichong');
    //     } else {
    //         $this->display();
    //     }

    // }
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
    public function dcode() {
        $data = I('post.');

        $info = M('devices')->where(['devices_code'=>$data['dcode']])->find();
        if ($info) {
            return $this->ajaxReturn(['code'=>200]);
        } else {
            return $this->ajaxReturn(['code'=>404,'message'=>'查询不到该设备']);
        }
    }
    /*
    * 充值
    */
    public function topup() {

        $this->display('chongzhi');
    }
    // // 将套餐数据更新到数据库
    // public function deviceStatu()
    // {
    //     $data = I("post.");
    //     file_put_contents('./weixin.test',$data, FILE_APPEND);
    //     // dump($data);
    //     // $this->ajaxReturn( $data );
    // }
}

