<?php
namespace Home\Controller;
use Think\Controller;
use \Org\Util\WeixinJssdk;

/**
 * 支付系统
 */
class PaymentSystemController extends Controller
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
        //echo 1;die;
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
        // 唯一订单ID
        $input->SetAttach($order_id);
        // 设置商户系统内部的订单号,32个字符内、可包含字母, 其他说明见商户订单号
        $input->SetOut_trade_no(gerOrderId());
        // 产品金额单位为分
        // $input->SetTotal_fee($money);
        // 调试用1分钱
        $input->SetTotal_fee(1);
        // 设置订单生成时间
        // $input->SetTime_start(date("YmdHis"));
        // 设置订单失效时间
        // $input->SetTime_expire(date("YmdHis", time() + 300));
        // $input->SetGoods_tag("test");
        // 支付成功的回调地址
        //$input->SetNotify_url("http://xinpin.dianqiukj.com/index.php/Home/Weixinpay/notify.html");
        $input->SetNotify_url('http://pub.dianqiukj.com/index.php/Home/PaymentSystem/notify');
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

    // 支付订单
    public function payOrder()
    {
        // 获取用户uid
        $data['user_id'] = $_SESSION['homeuser']['id'];
        $data['order_id'] = I('post.oid');

        if($data['order_id'] && $data['user_id']){
            // 实例化订单对象
            $orders = M('Orders');
            // 实例化套餐订单对象
            $orderSetmeal = M('OrderSetmeal');    
            // 实例化滤芯订单对象
            $orderFilter = M('orderFilter');    

            // 查询订单信息
            $orderData = $orders->where($data)->field('total_price')->find();
            $money = $orderData['total_price']-0;
            $order_id = $data['order_id'];

            // 查询订单套餐信息
            $orderSetmealData = $orderSetmeal->where($data)->field('describe,goods_num')->select();
            // 查询订单滤芯信息
            $orderFilterData = $orderFilter->where($data)->field('filtername,goods_num')->select();
            
            $contentstr = '';

            // 判断是否有套餐充值
            if($orderSetmealData){
                foreach ($orderSetmealData as $key => $value) {
                    // 拼接订单描述
                    $contentstr .= $value['describe'].'X'.$value['goods_num'].'  ';
                }
            }
            // 判断是否有滤芯产品
            if($orderFilterData){
                foreach ($orderFilterData as $key => $value) {
                    // 拼接订单描述
                    $contentstr .= $value['filtername'].'X'.$value['goods_num'].'  ';
                }
            }
            
            // 描述超长处理
            $content = msubstr($contentstr, 0, 120);
            // 调用发起微信下单
            // 订单创建成功，跳转到支付页面
            return $this->uniformOrder($money,$order_id,$contentstr);
        }
    }


    // 支付成功
    public function paySuccess()
    {
        // 显示模板
        $this->display(); 
    }

    // 支付失败
    public function failureToPay()
    {
        // 显示模板
        $this->display(); 
    } 

    /**
     * 处理订单写入数据
     * @return array 返回数组格式的notify数据
     */
    public function notify()
    {
        //echo 123;
        // 获取微信服务器返回的xml文档
        $xml=file_get_contents('php://input', 'r');
        //file_put_contents('./wx_pay.txt',$xml."\r\n", FILE_APPEND);
        //echo 1;die;
//         $xml = '<xml><appid><![CDATA[wxae48f3bbcda86ab1]]></appid>
// <attach><![CDATA[315037233979249849]]></attach>
// <bank_type><![CDATA[CFT]]></bank_type>
// <cash_fee><![CDATA[1]]></cash_fee>
// <fee_type><![CDATA[CNY]]></fee_type>
// <is_subscribe><![CDATA[Y]]></is_subscribe>
// <mch_id><![CDATA[1394894802]]></mch_id>
// <nonce_str><![CDATA[pl67wmh81v4mm9u8ku07nh3qvfo90ri0]]></nonce_str>
// <openid><![CDATA[oXwY4t-9clttAFWXjCcNRJrvch3w]]></openid>
// <out_trade_no><![CDATA[546871425788022934]]></out_trade_no>
// <result_code><![CDATA[SUCCESS]]></result_code>
// <return_code><![CDATA[SUCCESS]]></return_code>
// <sign><![CDATA[FC8E5247612B4A198C4136355577FFF7]]></sign>
// <time_end><![CDATA[20180111193923]]></time_end>
// <total_fee>1</total_fee>
// <trade_type><![CDATA[JSAPI]]></trade_type>
// <transaction_id><![CDATA[4200000060201801112325849443]]></transaction_id>
// </xml>';
// 
        if($xml){
            //解析微信返回数据数组格式
            $result = $this->notifyData($xml);
            file_put_contents('./wx_pay1.txt',$xml."\r\n", FILE_APPEND);
            // 如果订单号不为空
            if(!empty($result['out_trade_no'])){
                // 获取传回来的订单号
                $data['order_id'] = $result['attach'];

                // 查询订单是否已处理
                $orderData = M('Orders')->where($data)->field('is_pay,total_price')->find();

                // 1分钱测试数据
                $orderData['total_price'] = 1;
                // 如果订单未处理，订单支付金额等于订单实际金额
                if(empty($orderData['is_pay']) && $orderData['total_price'] == $result['total_fee']){
                    file_put_contents('./wx_pay121.txt',$xml."\r\n", FILE_APPEND);
                    //dump($result);
                    // 处理订单
                    // 实例化订单对象
                    $orders = M('Orders');  
                    // 实例化订单滤芯对象
                    $orderFilter = M('OrderFilter');
                    // 实例化订单套餐对象
                    $orderSetmeal = M('OrderSetmeal');
                    // 实例化设备详细信息对象
                    $devicesStatu = M('devicesStatu');
                    // 实例化设备对象
                    $device = M('Devices');
                    // 实例化充值流水对象
                    $flowObj = M('Flow');
                    
                    // 开启事务
                     $orders->startTrans();

                    // 修改订单状态为已付款
                    $isPay['is_pay'] = 1;
                    
                    
                    //show($isPayRes);die;
                    // 查询订单包含的全部套餐
                    $orderSetmealData = $orderSetmeal->where($data)->select();


                    if($orderSetmealData){
                        $isPay['is_recharge'] = 1;
                    }

                    $isPayRes = $orders->where($data)->save($isPay);
                    
                    // 充值状态
                    $status = 0;
                    if($orderSetmealData){
                        //show($orderSetmealData);die;
                        // 统计未处理套餐数量
                        $countNun = count($orderSetmealData);
                        // 定义计数器
                        $num     = 0;
                        $flownum = 0;

                        file_put_contents('./wx_payuid1.txt',$_SESSION['homeuser']['id']."\r\n", FILE_APPEND);
                        // 查询当前设备编号
                        $deviceId['id'] = M('CurrentDevices')->where("uid={$_SESSION['homeuser']['id']}")->find()['did'];
                        file_put_contents('./wx_payuid2.txt',$_SESSION['homeuser']['id']."\r\n", FILE_APPEND);
                        $deviceCode['DeviceID'] = $device->where($deviceId)->find()['device_code'];
                        
                        foreach ($orderSetmealData as $value) {
                            //show($value);die;
                            // 查询设备当前剩余流量
                            $devicesStatuReFlow = $devicesStatu->where($deviceCode)->find()['reflow']-0;

                            // 充值后流量应剩余流量
                            $Flow['ReFlow'] = $devicesStatuReFlow + ($value['flow']*$value['goods_num']);

                            // 修改设备剩余流量
                            $FlowRes = $devicesStatu->where($deviceCode)->save($Flow);

                            // 写充值流水
                            // 订单编号
                            $flowData['order_id']       = $value['order_id'];
                            // 用户ID
                            $flowData['uid']            = $_SESSION['homeuser']['id'];
                            // 充值金额
                            $flowData['money']          = $value['money'];
                            // 充值方式
                            $flowData['mode']           = 1;
                            // 充值流量
                            $flowData['flow']           = $value['flow'];
                            // 套餐数量
                            $flowData['num']            = $value['goods_num'];
                            // 套餐描述
                            $flowData['describe']       = $value['describe'];
                            // 当前流量
                            $flowData['currentflow']    = $Flow['ReFlow'];
                            // 充值时间
                            $flowData['addtime']           = time();
                            //show($flowData);die;
                            // 创建充值流水
                            $flowObjRes = $flowObj->add($flowData);


                            // 判断流水是否创建成果
                            if($flowObjRes){
                                // 定时器++
                                $flownum++;
                            }

                            // 判断修改结果
                            if($FlowRes){
                                // 计数器++
                                $num++;  
                            }
                            
                        }

                        // 全部套餐充值完成
                        if($countNun == $num && $countNun == $flownum){
                            // 充值和流水完成，状态设为1
                            $status = 1;
                        }

                    }else{
                        // 没有套餐默认值，状态设为1
                        $status = 1;
                    }
                    
                    //show($status);die;
                    file_put_contents('saaa',$isPayRes .'jfdslajfds'. $status);
                    if($isPayRes && $status){
                        
                        // 执行事务
                        $orders->commit();
                        file_put_contents('./wx_notifyYes.txt','订单号：'.$result['attach']."充值完成 \r\n", FILE_APPEND);
                    }else{
                        // 事务回滚
                        $orders->rollback();
                        file_put_contents('./wx_notifyEeor.txt','订单号：'.$result['attach']."充值失败 \r\n", FILE_APPEND);
                    }
                }else{
                    // 充值金额不匹配
                    // if($orderData['total_price'] != $result['total_fee']){
                    //    file_put_contents('./wx_notifymoney.txt','订单号：'.$result['attach']."充值失败,金额不匹配。订单金额：{$orderData['total_price']} ，充值金额：{$result['total_fee']} \r\n", FILE_APPEND); 
                    // }  
                }
            } 
        }

    }

    /**
     * 验证服务器返回支付成功订单
     * @return array 返回数组格式的notify数据
     */
    public function notifyData($xml)
    {
        // 获取微信服务器返回的xml文档
        // $xml=file_get_contents('php://input', 'r');
        // file_put_contents('./wx_notify.txt',$xml, FILE_APPEND);

        // 转成php数组
        $data=$this->toArray($xml);

        // file_put_contents('./wx_notify1.txt','data:'.$data, FILE_APPEND);    
        // file_put_contents('./wx_notify2.txt','123:'.$data['out_trade_no'], FILE_APPEND);
        // file_put_contents('./wx_notify3.txt','456:'.$data['sign'], FILE_APPEND); 

        // 保存原sign
        $dataSign=$data['sign'];

        // sign不参与签名
        unset($data['sign']);

        // 生成签名
        $sign=$this->makeSign($data);
        // file_put_contents('./wx_notify.txt','原签: '.$dataSign.'现签：'.$sign, FILE_APPEND);  
        // 判断签名是否正确  判断支付状态
        if ($sign==$dataSign && $data['return_code']=='SUCCESS' && $data['result_code']=='SUCCESS') {

            // 返回状态给微信服务器
            echo '<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg></xml>';

            // 返回数据给回调函数进行插入操作
            return $data;
        }else{
            // 签名错误 或 支付未成功 
            $result=false;
        }

        
    }

    /**
     * 将xml转为array
     * @param  string $xml xml字符串
     * @return array       转换得到的数组
     */
    public function toArray($xml){   
        //禁止引用外部xml实体
        libxml_disable_entity_loader(true);
        $result= json_decode(json_encode(simplexml_load_string($xml, 'SimpleXMLElement', LIBXML_NOCDATA)), true);        
        return $result;
    }

    /**
     * 生成签名
     * @return 签名，本函数不覆盖sign成员变量，如要设置签名需要调用SetSign方法赋值
     */
    public function makeSign($data){
        // 去空
        $data=array_filter($data);
        //签名步骤一：按字典序排序参数
        ksort($data);
        $string_a=http_build_query($data);
        $string_a=urldecode($string_a);
        //签名步骤二：在string后加入KEY
        $config=$this->config;
        $string_sign_temp=$string_a."&key=CAA5EAE2CE5AC44A3F8930E6F127B423";
        //签名步骤三：MD5加密
        $sign = md5($string_sign_temp);
        // 签名步骤四：所有字符转为大写
        $result=strtoupper($sign);
        return $result;
    }   

}