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
                $setmealData['order_id']        = $order['order_id'];
                // 套餐ID
                $setmealData['setmeal_id']      = $setmeal[0]['sid'];
                // 产品类型ID
                $setmealData['type_id']      = $setmeal[0]['tid'];                       
                // 充值模式                
                $setmealData['remodel']           = $setmeal[0]['remodel'];
                // 套餐价格
                $setmealData['money']           = $setmeal[0]['money'];
                // 套餐流量/时长
                $setmealData['flow']           = $setmeal[0]['flow'];
                // 套餐描述
                $setmealData['describe']           = $setmeal[0]['describe'];
                // 商品的购买数量
                $setmealData['goods_num']       = $setmeal[0]['num'];
                // 商品的购买金额
                $setmealData['goods_price']     = $setmeal[0]['money'];
                // 订单创建时间
                $setmealData['created_at']      = $order['created_at'];

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
                    // 准备订单数据
                    // 充值金额
                    $money = $setmealData['goods_price']-0;
                    // 订单号码
                    $order_id = $order['order_id'];
                    // 订单描述
                    $contentstr = $setmealData['describe'];
                    // 描述超长处理
                    $content = msubstr($contentstr, 0, 100);
                    // 订单创建成功，跳转到支付页面
                    return $this->uniformOrder($money,$order_id,$content);
                }else{
                    // 事务回滚
                    $orders->rollback();
                    $this->error('订单创建失败');
                }
            }

            // 情况二：购买套餐（1个套餐1件以上）购买套餐（多个套餐1件）购买套餐（多个套餐多件）
            if(empty($filters) && $setmealNum>1){
                show(2);
            }

            // 情况三：包含滤芯产品
            if($filters){
                show(3);
            }           
        }   
    }

    // 情况2：套餐确认支付
    public function sureSetmealPay()
    {
        // 获取用户uid
        $uid = $_SESSION['homeuser']['id'];
        if($uid){
        // 遍历购物车
            // 遍历用户购物车套餐
            $setmeal = M('cartSetmeal')
            ->where("`uid`='{$uid}' AND `num`>0")
            ->join('pub_setmeal ON pub_setmeal.id = pub_cart_setmeal.sid')
            ->select();

            if($setmeal){
                // 汇总套餐总金额
                $totalAmount = 0;
                // 汇总套餐总数量
                $totalNum = 0;
                // 统计套餐总金额
                foreach ($setmeal as $value) {
                    $totalAmount += $value['num']*$value['money'];
                    $totalNum += $value['num'];
                }

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
                $order['created_at']    = time();
                // 创建订单,返回插入ID
                $ordersRes = $orders->add($order);
                // 统计套餐数量
                $setmealCount = count($setmeal);
                $addSetmealNumIndex = 0;
                $delSetmealNumIndex = 0;
                $contentstr = '';
                foreach ($setmeal as $k => $v) {
                    // 准备数据
                    // 关联订单ID号
                    $setmealData['order_id']        = $order['order_id'];
                    // 套餐ID
                    $setmealData['setmeal_id']      = $v['sid'];
                    // 产品类型ID
                    $setmealData['type_id']      = $v['tid'];                       
                    // 充值模式                
                    $setmealData['remodel']           = $v['remodel'];
                    // 套餐价格
                    $setmealData['money']           = $v['money'];
                    // 套餐流量/时长
                    $setmealData['flow']           = $v['flow'];
                    // 套餐描述
                    $setmealData['describe']           = $v['describe'];
                    // 商品的购买数量
                    $setmealData['goods_num']       = $v['num'];
                    // 商品的购买金额
                    $setmealData['goods_price']     = $v['money']*$v['num'];
                    // 订单创建时间
                    $setmealData['created_at']      = $order['created_at'];

                    // 创建订单套餐
                    $orderSetmealRes = $orderSetmeal->add($setmealData);
                    if($orderSetmealRes){
                        $addSetmealNumIndex++;
                    }
                    $cartSetmealRes = $cartSetmeal->where("`uid`={$uid} AND `sid`={$v['sid']}")->delete();
                    if($cartSetmealRes){
                        $delSetmealNumIndex++;
                    }
                    // 拼接订单描述
                    $contentstr .= $setmealData['describe'].'X'.$setmealData['goods_num'].'  ';
                }

                if($ordersRes && $addSetmealNumIndex==$setmealCount && $delSetmealNumIndex==$setmealCount){
                    // 执行事务
                    $orders->commit();

                    // 准备订单数据
                    // 充值金额
                    $money = $totalAmount-0;
                    // 订单号码
                    $order_id = $order['order_id'];
                    // 描述超长处理
                    $content = msubstr($contentstr, 0, 120);
                    // show($money.'<br>');
                    // show($order_id.'<br>');
                    // show($content.'<br>');die;
                    // 订单创建成功，跳转到支付页面
                    return $this->uniformOrder($money,$order_id,$content);
                }else{
                    // 事务回滚
                    $orders->rollback();
                    //$this->error('订单创建失败');
                    echo 2;
                }
            }    
        }
    }
    // 情况3：套餐+产品确认支付
    public function sureBillPay()
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
            // 准备变量装总金额
            $totalAmount = 0;
            // 准备变量装总数量
            $totalNum = 0;

            // 判断套餐产品数量
            if($setmealNum>0){
                // 有套餐产品
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

                // 实例化订单对象
                $orders = M('Orders');    
                // 实例化套餐订单对象
                $orderSetmeal = M('OrderSetmeal');    
                // 实例化滤芯订单对象
                $orderFilter = M('orderFilter');    
                // 实例化套餐购物车对象
                $cartSetmeal = M('CartSetmeal');    
                // 实例化滤芯购物车对象
                $cartFilter = M('cartFilters');    
                // 开启事务 
                $orders->startTrans();

                // 准备订单表数据
                // 订单快递信息ID号
                $ordersData['express_id'] =  I('post.express_id')-0;

                // 唯一订单ID号
                $ordersData['order_id']      = gerOrderId();
                // 用户ID号
                $ordersData['user_id']       = $uid;
                // 关联的设备ID号
                $ordersData['device_id']     = M('Devices')->where("`uid`='{$uid}'")->find()['id'];
                // 商品的购买总数量
                $ordersData['total_num']     = $totalNum;
                // 商品的购买总金额
                $ordersData['total_price']   = $totalAmount;
                // 订单创建时间
                $ordersData['created_at']    = time();
                // 创建订单,返回插入ID
                $ordersRes = $orders->add($ordersData);
                
                // 统计套餐数量
                $setmealCount = count($setmeal);
                $addSetmealNumIndex = 0;
                $delSetmealNumIndex = 0;
                $contentstr = '';
                foreach ($setmeal as $k => $v) {
                    // 准备数据
                    // 关联订单ID号
                    $setmealData['order_id']        = $ordersData['order_id'];
                    // 套餐ID
                    $setmealData['setmeal_id']      = $v['sid'];
                    // 产品类型ID
                    $setmealData['type_id']      = $v['tid'];                       
                    // 充值模式                
                    $setmealData['remodel']           = $v['remodel'];
                    // 套餐价格
                    $setmealData['money']           = $v['money'];
                    // 套餐流量/时长
                    $setmealData['flow']           = $v['flow'];
                    // 套餐描述
                    $setmealData['describe']           = $v['describe'];
                    // 商品的购买数量
                    $setmealData['goods_num']       = $v['num'];
                    // 商品的购买金额
                    $setmealData['goods_price']     = $v['money']*$v['num'];
                    // 订单创建时间
                    $setmealData['created_at']      = $ordersData['created_at'];

                    // 创建订单套餐
                    $orderSetmealRes = $orderSetmeal->add($setmealData);
                    if($orderSetmealRes){
                        $addSetmealNumIndex++;
                    }
                    // 删除购物车套餐
                    $cartSetmealRes = $cartSetmeal->where("`uid`={$uid} AND `sid`={$v['sid']}")->delete();
                    if($cartSetmealRes){
                        $delSetmealNumIndex++;
                    }

                    // 拼接订单描述
                    $contentstr .= $setmealData['describe'].'X'.$setmealData['goods_num'].'  ';
                }

                // 统计滤芯数量
                $filterCount = count($filters);
                $addFilterNumIndex = 0;
                $delFilterNumIndex = 0;
                foreach ($filters as $k => $v) {
                    // show($v);die;
                    // 准备数据
                    // 关联订单ID号
                    $filterData['order_id']         = $ordersData['order_id'];
                    // 滤芯ID
                    $filterData['filter_id']        = $v['fid'];
                    // 滤芯名称
                    $filterData['filtername']       = $v['filtername'];                      
                    // 滤芯别名                
                    $filterData['alias']            = $v['alias'];
                    // 滤芯图片
                    $filterData['picpath']          = $v['picpath'];
                    // 时间寿命（小时）
                    $filterData['timelife']         = $v['timelife'];
                    // 流量寿命（升）
                    $filterData['flowlife']         = $v['flowlife'];
                    // 时间寿命使能
                    $filterData['balancatime']      = $v['balancatime'];
                    // 流量寿命使能
                    $filterData['balancaflow']      = $v['balancaflow'];
                    // 滤芯简介
                    $filterData['introduce']        = $v['introduce'];
                    // 滤芯购买网址
                    $filterData['url']              = $v['url'];
                    // 滤芯价格
                    $filterData['price']            = $v['price'];
                    // 购买数量
                    $filterData['goods_num']        = $v['num'];
                    // 购买金额
                    $filterData['goods_price']      = $v['num']*$v['price'];
                    // 订单创建时间
                    $filterData['created_at']       = $ordersData['created_at'];


                    // 创建订单套餐
                    $orderFilterlRes = $orderFilter->add($filterData);
                    if($orderFilterlRes){
                        $addFilterNumIndex++;
                    }
                    // 删除购物车套餐
                    $cartSetmealRes = $cartFilter->where("`uid`={$uid} AND `fid`={$v['fid']}")->delete();
                    if($cartSetmealRes){
                        $delFilterNumIndex++;
                    }
                    
                    // 拼接订单描述
                    $contentstr .= $filterData['filtername'].'X'.$filterData['goods_num'].'  ';
                }

                if($ordersRes && $addSetmealNumIndex==$setmealCount && $delSetmealNumIndex==$setmealCount && $filterCount==$addFilterNumIndex &&  $filterCount==$delFilterNumIndex){
                    // 执行事务
                    $orders->commit();

                    // 准备订单数据
                    // 充值金额
                    $money = $totalAmount-0;
                    // 订单号码
                    $order_id = $ordersData['order_id'];
                    // 描述超长处理
                    $content = msubstr($contentstr, 0, 120);
                    // show($money.'<br>');
                    // show($order_id.'<br>');
                    // show($content.'<br>');die;
                    // 订单创建成功，跳转到支付页面
                    return $this->uniformOrder($money,$order_id,$content);
                }else{
                    // 事务回滚
                    $orders->rollback();
                    //$this->error('订单创建失败');
                    echo 2;
                }
                //show($contentstr);                  
            }else{
                // 没有套餐产品
                // 统计滤芯总金额
                foreach ($filters as $value) {
                    $totalAmount += $value['num']*$value['price'];
                    $totalNum += $value['num'];
                }

                // 实例化订单对象
                $orders = M('Orders');       
                // 实例化滤芯订单对象
                $orderFilter = M('orderFilter');      
                // 实例化滤芯购物车对象
                $cartFilter = M('cartFilters');    
                // 开启事务 
                $orders->startTrans();

                // 准备订单表数据
                // 订单快递信息ID号
                $ordersData['express_id'] =  I('post.express_id')-0;
                // 唯一订单ID号
                $ordersData['order_id']      = gerOrderId();
                // 用户ID号
                $ordersData['user_id']       = $uid;
                // 关联的设备ID号
                $ordersData['device_id']     = M('Devices')->where("`uid`='{$uid}'")->find()['id'];
                // 商品的购买总数量
                $ordersData['total_num']     = $totalNum;
                // 商品的购买总金额
                $ordersData['total_price']   = $totalAmount;
                // 订单创建时间
                $ordersData['created_at']    = time();
                // 创建订单,返回插入ID
                $ordersRes = $orders->add($ordersData);

                // 统计滤芯数量
                $filterCount = count($filters);
                $addFilterNumIndex = 0;
                $delFilterNumIndex = 0;
                $contentstr = '';
                foreach ($filters as $k => $v) {
                    // show($v);die;
                    // 准备数据
                    // 关联订单ID号
                    $filterData['order_id']         = $ordersData['order_id'];
                    // 滤芯ID
                    $filterData['filter_id']        = $v['fid'];
                    // 滤芯名称
                    $filterData['filtername']       = $v['filtername'];                      
                    // 滤芯别名                
                    $filterData['alias']            = $v['alias'];
                    // 滤芯图片
                    $filterData['picpath']          = $v['picpath'];
                    // 时间寿命（小时）
                    $filterData['timelife']         = $v['timelife'];
                    // 流量寿命（升）
                    $filterData['flowlife']         = $v['flowlife'];
                    // 时间寿命使能
                    $filterData['balancatime']      = $v['balancatime'];
                    // 流量寿命使能
                    $filterData['balancaflow']      = $v['balancaflow'];
                    // 滤芯简介
                    $filterData['introduce']        = $v['introduce'];
                    // 滤芯购买网址
                    $filterData['url']              = $v['url'];
                    // 滤芯价格
                    $filterData['price']            = $v['price'];
                    // 购买数量
                    $filterData['goods_num']        = $v['num'];
                    // 购买金额
                    $filterData['goods_price']      = $v['num']*$v['price'];
                    // 订单创建时间
                    $filterData['created_at']       = $ordersData['created_at'];


                    // 创建订单套餐
                    $orderFilterlRes = $orderFilter->add($filterData);
                    if($orderFilterlRes){
                        $addFilterNumIndex++;
                    }
                    // 删除购物车套餐
                    $cartSetmealRes = $cartFilter->where("`uid`={$uid} AND `fid`={$v['fid']}")->delete();
                    if($cartSetmealRes){
                        $delFilterNumIndex++;
                    }
                    
                    // 拼接订单描述
                    $contentstr .= $filterData['filtername'].'X'.$filterData['goods_num'].'  ';
                }

                if($ordersRes && $filterCount==$addFilterNumIndex &&  $filterCount==$delFilterNumIndex){
                    // 执行事务
                    $orders->commit();

                    // 准备订单数据
                    // 充值金额
                    $money = $totalAmount-0;
                    // 订单号码
                    $order_id = $ordersData['order_id'];
                    // 描述超长处理
                    $content = msubstr($contentstr, 0, 120);

                    // 订单创建成功，跳转到支付页面
                    return $this->uniformOrder($money,$order_id,$content);
                }else{
                    // 事务回滚
                    $orders->rollback();
                    //$this->error('订单创建失败');
                    echo 2;
                }

            }
        }
    }


    /**
     * 统一下单并返回数据
     * @return string json格式的数据，可以直接用于js支付接口的调用
     * @param  [type] $money    [订单金额]
     * @param  [type] $order_id [订单号码]
     * @param  [type] $content  [订单详情]
     */
    public function uniformOrder($money,$order_id,$content)
    {
        // 将金额强转换整数
        //$money = I('money') * 100;
        // 冲值测试额1分钱
        $money = $money;
        // 用户在公众号的唯一ID
        $openId = $_SESSION['homeuser']['open_id'];
        //微信examle的WxPay.JsApiPay.php
        vendor('WxPay.jsapi.WxPay#JsApiPay');

        $tools = new \JsApiPay();

        //②、统一下单
        vendor('WxPay.jsapi.WxPay#JsApiPay');
        $input = new \WxPayUnifiedOrder();

        // 产品内容
        $input->SetBody($content);
        // 用户ID
        $input->SetAttach($_SESSION['homeuser']['id']);
        // 设置商户系统内部的订单号,32个字符内、可包含字母, 其他说明见商户订单号
        $input->SetOut_trade_no($order_id);
        // 产品金额单位为分
        $input->SetTotal_fee($money);
        // 设置订单生成时间
        // $input->SetTime_start(date("YmdHis"));
        // 设置订单失效时间
        // $input->SetTime_expire(date("YmdHis", time() + 300));
        // $input->SetGoods_tag("test");
        // 支付成功的回调地址
        //$input->SetNotify_url("http://xinpin.dianqiukj.com/index.php/Home/Weixinpay/notify.html");
        $input->SetNotify_url("http://wuzhibin.cn/Home/Weixinpay/notify.html");
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