<?php
namespace Home\Controller;
use Think\Controller;
use \Org\Util\WeixinJssdk;

/**
 * 支付系统
 */
class PaymentSystemController extends CommonController 
{
    /**
     * [index 购买类型判断-分配支付流程]
     * @return [type] [description]
     */
    public function action()
    {
        // 获取用户uid
        $uid = $_SESSION['homeuser']['id'];

        // 判断用户是否存在
        if($uid){
            // 遍历购物车
            // 遍历用户购物车套餐
            $setmeal = M('cartSetmeal')
            ->where("`uid`='{$uid}' AND `num`>0")
            ->join('pub_setmeal ON pub_setmeal.id = pub_cart_setmeal.sid')
            ->select();

            // 遍历用户购物车滤芯
            $filters = M('cartFilters')
            ->where("`uid`='{$uid}'  AND `num`>0")
            ->join('pub_filters ON pub_filters.id = pub_cart_filters.fid')
            ->select();

            // 定义一个变量用来装套餐数量
            $setmealNum = 0;
            // 如果有套餐产品
            if($setmeal){
                // 遍历，统计套餐总数量
                foreach ($setmeal as $value) {
                    // 将套餐数量进行累加
                    $setmealNum += $value['num'];
                }   
            }

            $totalAmount = 0;
            $totalNum = 0;
            // 统计套餐总金额
            foreach ($setmeal as $value) {
                $totalAmount += $value['num']*$value['money'];
                $totalNum += $value['num'];
            }
            // 统计滤芯总金额
            foreach ($filters as $value) {
                $totalAmount += $value['num']*$value['price'];
                $totalNum += $value['num'];
            }


            // 异常处理，购物车没有产品
            if(empty($setmeal) && empty($filters)){
                //重定向到商城页面地址
                redirect(U('/Home/Shop/filterElement'), 1, '<p style="color:red;">请先选择产品...</p>'); 
            } 

            // 情况一：购买套餐（1个套餐1件）
            if(empty($filters) && $setmealNum==1){
                // 实例化订单模型
                $orders = D('Orders');
                // 实例化订单套餐模型
                $orderSetmeal = D('OrderSetmeal');
                // 实例化购物车模型
                $cartSetmeal = M('CartSetmeal');
                // 开启事务
                $orders->startTrans();

                // 准备数据
                // 唯一订单ID号
                $order['order_id']      = gerOrderId();
                // 用户ID号
                $order['user_id']       = $uid;
                // 关联的设备ID号
                $order['device_id']     = M('Devices')->where("`uid`='{$uid}'")->find()['id'];
                // 商品的购买总数量
                $order['total_num']     = $totalNum;
                // 商品的购买总金额
                $order['total_price']   = $totalAmount;
                // 订单创建时间
                $order['created_at']   = time();

                // 准备数据
                // 关联订单ID号
                $setmealData['order_id'] = $order['order_id'];
                // 套餐ID
                $setmealData['setmeal_id'] = $setmeal[0]['sid'];
                // 商品的购买数量
                $setmealData['goods_num'] = $setmeal[0]['num'];
                // 商品的购买金额
                $setmealData['goods_price'] = $setmeal[0]['money'];
                // 订单创建时间
                $setmealData['created_at']   = $order['created_at'];

                // 创建订单
                $ordersRes = $orders->add($order);
                // 创建订单套餐
                $orderSetmealRes = $orderSetmeal->add($setmealData);
                // 删除用户购物车产品
                $cartSetmealRes = $cartSetmeal->where("`uid`={$uid} AND `sid`={$setmeal[0]['sid']}")->delete(); 

                // 判断订单是否创建成功
                if($ordersRes && $orderSetmealRes && $cartSetmealRes){
                    // 执行事务
                    $orders->commit();
                    // 订单创建成功，跳转到支付页面
                    return $this->uniformOrder();
                }else{
                    // 事务回滚
                    $orders->rollback();
                    $this->error('订单创建失败');
                }
            }

            // 情况二：购买套餐（1个套餐1件以上）购买套餐（多个套餐1件）购买套餐（多个套餐多件）
            if(empty($filters) && $setmealNum>1){
                show('购买套餐（1个套餐1件以上）购买套餐（多个套餐1件）购买套餐（多个套餐多件）<br/>');
            }

            // 情况三：包含滤芯产品
            if($filters){
                show('包含滤芯产品<br/>');
            }

            // show('套餐情况：<br/>');
            // show($setmeal);
            // show('滤芯情况：<br/>');
            // show($filters);
            
        }   
    }

    /**
     * 统一下单并返回数据
     * @return string json格式的数据，可以直接用于js支付接口的调用
     */
    public function uniformOrder()
    {
        // 将金额强转换整数
        //$money = I('money') * 100;
        // 冲值测试额1分钱
        $money = 1;
        // 用户在公众号的唯一ID
        $openId = $_SESSION['homeuser']['open_id'];;
        //微信examle的WxPay.JsApiPay.php
        vendor('WxPay.jsapi.WxPay#JsApiPay');

        $tools = new \JsApiPay();

        //②、统一下单
        vendor('WxPay.jsapi.WxPay#JsApiPay');
        $input = new \WxPayUnifiedOrder();

        // 产品内容
        $input->SetBody("馨品净水设备-充值");
        // 用户ID
        $input->SetAttach($_SESSION['homeuser']['id']);
        // 设置商户系统内部的订单号,32个字符内、可包含字母, 其他说明见商户订单号
        $input->SetOut_trade_no(\WxPayConfig::MCHID.date("YmdHis").mt_rand(0,9999));
        // 产品金额单位为分
        $input->SetTotal_fee($money);
        // 设置订单生成时间
        // $input->SetTime_start(date("YmdHis"));
        // 设置订单失效时间
        // $input->SetTime_expire(date("YmdHis", time() + 300));
        // $input->SetGoods_tag("test");
        // 支付成功的回调地址
        $input->SetNotify_url("http://xinpin.dianqiukj.com/index.php/Home/Weixinpay/notify.html");
        //$input->SetNotify_url("http://wuzhibin.cn/Home/Weixinpay/notify.html");
        // 支付方式 JS-SDK 类型是：JSAPI
        $input->SetTrade_type("JSAPI");
        // 用户在公众号的唯一标识
        $input->SetOpenid($openId);
        // 统一下单 
        $order = \WxPayApi::unifiedOrder($input);
        
        // 返回支付需要的对象JSON格式数据
        $jsApiParameters = $tools->GetJsApiParameters($order);

        echo $jsApiParameters;
        exit;
    }

}