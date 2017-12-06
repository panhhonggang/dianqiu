<?php
namespace Home\Controller;
use Think\Controller;

class WeixinpayController extends Controller 
{
    /**
     * 处理订单写入数据
     * @return array 返回数组格式的notify数据
     */
    public function notify()
    {
    	// 获取微信服务器返回的xml文档
        $xml=file_get_contents('php://input', 'r');

        if($xml){
        	//解析微信返回数据数组格式
        	$result = $this->notifyData($xml);

	    	// 如果订单号不为空
        	if(!empty($result['out_trade_no'])){
        		// file_put_contents('./wx_notifyNOnull.txt','不为空', FILE_APPEND);
		    	// 查询数据库
		    	$model = M('Flow');
	    		// $map['ordernumber'] = array('eq', $result['out_trade_no']);
		    	$map['ordernumber'] = array('eq', $result['out_trade_no']);
	    		//查询IC号是否存在
	    		$res = $model->where($map)->find();

	    		if(!$res){
	    			// 用户ID号
	    			$data['uid'] = $result['attach'];
	    			// 商户订单
	    			$data['ordernumber'] = $result['out_trade_no'];
	    			// 金额
	    			$data['money'] = $result['total_fee'];
	    			// 充值类型
	    			$data['mode'] = 1;
	    			// 充值时间
	    			$data['time'] = time();
	    			// 写入数据库
	    			$msg = $model->add($data);

	    			if($msg){
	    				// 写充值日志
	    				file_put_contents('./log/wx_logY.txt','充值成功'.$xml.'\r\n', FILE_APPEND);
	    			}else{
	    				// 写充值日志
	    				file_put_contents('./log/wx_logN.txt','充值失败'.$xml.'\r\n', FILE_APPEND);
	    			}

	    			// 更新用户余额
	    			// 读取用户余额
    				$user = M('users')->where('id='.$data['uid'])->find();

                    // 用户余额
                    $money = (int) $user['balance'];

    				// 更新用户余额
    				$data['balance'] = $money + $data['money'];

    				$data['addtime'] = time();

    				$mes = M('users')->where('id='.$data['uid'])->save($data);

    				if($mes){
	    				// 写更新日志
	    				//file_put_contents('./log/wxgxY_log.txt','余额更新成功', FILE_APPEND);

                        // 用户名
                        $username = $user['name'];
                        $content = $username . '：您于'.date('Y年m月d日 h时i分s秒',$data['addtime']).'成功冲值'.$data['money']/100.'元';
                        $phone = $user['phone'];
                        //file_put_contents('./log/wxgxY_log.txt',$content.' '.$phone, FILE_APPEND);
                        // 开始接口代码
                        $sms = new \Org\Util\SmsDemo;
                        $response = $sms::sendSms(
                            "阿里云短信测试专用", // 短信签名
                            "SMS_112475574", // 短信模板编号
                            $phone, // 短信接收者
                            Array(  // 短信模板中字段的值
                                "content"=>$content,
                                "product"=>"dsd"
                            ),
                            "123"   // 流水号,选填
                        );

                        // 信息推送状态判断
                        if($response->Code=='OK'){
                            $this->error('消息推送成功！');
                        }else{
                            $this->error('消息推送失败，错误码：' . $response->Code);
                        }


	    			}else{
	    				// 写更新日志
	    				file_put_contents('./log/wxgxN_log.txt','更新失败', FILE_APPEND);
	    			}

	    		}else{
	    		 	file_put_contents('./wx_notifyres.txt','订单已经存在', FILE_APPEND);
	    		 	//echo '订单已经存在';
	    		}
        	}


    		//file_put_contents('./wx_notifyOK.txt','交易成功: '.$result['out_trade_no'], FILE_APPEND);

		    // 获取订单编号
		    // $data['ordernumber'] = $result['out_trade_no'];
		    // 获取用户ID
		    // $data['uid'] = $_SESSION['homeuser']['id'];
		    // 获取订单金额
   	
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
