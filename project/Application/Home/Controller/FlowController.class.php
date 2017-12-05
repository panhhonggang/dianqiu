<?php
namespace Home\Controller;
use Think\Controller;
use \Org\Util\WeixinJssdk;

class FlowController extends CommonController 
{
	// 充值
    public function recharge()
    {
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

    	// 充值成功修改用户余额
	}

    /**
     * 统一下单并返回数据
     * @return string json格式的数据，可以直接用于js支付接口的调用
     */
    public function uniformOrder()
    {
    	// 将金额强转换整数
    	$money = I('money') * 100;
        // 冲值测试额1分钱
        //$money = 1;
        // 用户在公众号的唯一ID
    	$openId = I('openId');
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

	// 充值记录
	public function rechargeNodes(){
        // 查询用户IC卡号 xp_card
        $id = $_SESSION['homeuser']['id'];

        // 查询用户名下已绑定的卡号
        $record = M('Flow')->field('money,time')->where('`uid`='.$id)->order('id desc')->select();
        //echo '<pre>';
        //print_r($record);die;
        // 分配数据
        $this->assign('record',$record);
		$this->display();
	}


}