<?php
namespace Home\Controller;
use Home\Controller\WechatController;
class WeixinEventController
{
	// 接受微信服务器下发的事件
    public function getEventData()
    {
    	// 实例化微信验证对象服务器第一次接入使用
    	//$wechatObj = new \Org\Util\WechatCallbackapiTest;
    	// 执行验证方法
    	//$wechatObj->valid();

    	// 接受微信推送的事件
    	$xml=file_get_contents('php://input', 'r');
        // file_put_contents('./tmp.txt', $xml);
//     	$xml = "<xml>
//     <ToUserName><![CDATA[gh_85ebcdb60fa2]]></ToUserName>
//     <FromUserName><![CDATA[oXwY4t2gearWoyg8z19ygjD34vDk]]></FromUserName>
//     <CreateTime>1512626554</CreateTime>
//     <MsgType><![CDATA[event]]></MsgType>
//     <Event><![CDATA[subscribe]]></Event>
//     <EventKey><![CDATA[]]></EventKey>
//     <Encrypt><![CDATA[OxO9gI2fl03qCfsH41IvARULK4zwJNEl6i8W+W2shPwpUFl18+Rg6SmY80WtRj8oUr5o1VYW9lHVYU1vGHfPn++Wc1Q1p7rge4YhpRJqZUURNe0xHghSz+tZ/uUMA+173lVq3GUQtqbMjaFZk1a7zD9JTjhOtQ1mlcBlLZezaDUbFFGBCvscspR51Y+bQogvNvyhzitbFH0D4zx0s6JWkdsxhs0Ctwqi/SDhgnMDt8z/0HkhJi1h+7cAHtAkk87IfNv2GBYHmBhkAwMSkGqNn6tSBOsCtRvfNhYjARVX9npb4FeRZi+d9g/kFxcsuBMRD/4SSkHumhqpGHIE+8aF4mBXUH9FKV3xtrO6viFwrTUBECCQPIbrNm1qKskY07P+zMYbkhcx8VQf8xd2uM8NhqU8OW21qlRxoBTQOnNiRBM=]]></Encrypt>
// </xml>";

		if($xml){
            // 输出空字符串，回复微信服务器
			echo '';

			// 转成php数组
			$data = $this->toArray($xml);

            // 判断如果是关注事件
            if($data['Event'] == 'subscribe'){
               
                // 实例化微信信息类型
                $Wechat = new WechatController;
                // 调用填写微信信息的方法
                $Wechat->add($data['FromUserName']);
                //file_put_contents('./add.txt', $xml);
                exit;
            }

            // 判断如果是取消关注事件
            if($data['Event'] == 'unsubscribe'){
                //file_put_contents('./del.txt', $xml);
                // 实例化微信信息类型
                $Wechat = new WechatController;
                // 调用删除微信信息的方法
                $Wechat->delete($data['FromUserName']);
                exit;
            }
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
}