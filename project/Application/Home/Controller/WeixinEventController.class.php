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
        //file_put_contents('./tmp.txt', $xml);
//      	$xml = "<xml>
//     <ToUserName><![CDATA[gh_85ebcdb60fa2]]></ToUserName>
//     <FromUserName><![CDATA[oXwY4t-9clttAFWXjCcNRJrvch3w]]></FromUserName>
//     <CreateTime>1515130791</CreateTime>
//     <MsgType><![CDATA[event]]></MsgType>
//     <Event><![CDATA[subscribe]]></Event>
//     <EventKey><![CDATA[]]></EventKey>
//     <Encrypt><![CDATA[2TNSc1A+6tKUvjgqbMEAoxkrcauhxXSzAcXgVnnPuL7cENVb+6CLK7hif7sUecs8UxOSPDckEun1gCMCt5LEAlY9tGyfLKbGj8ag9Go21GUwI6VrEd7fZCoLchOiPyQNu/fp3cIV0HIut3gnEf1tvZ7EzbBA+nfrXrW161qJonG5rkxc44Knc+KE0DwlHKyR7pDpAdQAwUhrTHNK38OBQwQoHOAouEJD1AFoajI03YHWJ5CD3AX930dwwaDLeEFp1reG73gVhd6GCWwT3tQPCL6jYvbOjmGTdoOwk18opHyh1Vie9+cnL87O7fMU/yopgJWoZE/AKEovdkRYtf8I8RlXShiE2+Id2vg69/4LLLG/FvNeiG6ouLErchJ0WVArEGUbECZKBMQrFaH4tmDkEUU4yDUfBiUOXyB2/AIkz9A=]]></Encrypt>
// </xml>";

		if($xml){
            // 输出空字符串，回复微信服务器
			//echo '1';

			// 转成php数组
			$data = $this->toArray($xml);

            // 判断如果是关注事件
            if($data['Event'] == 'subscribe'){
            //echo 2;   
                // 实例化微信信息类型
                $Wechat = new WechatController;
                // 调用填写微信信息的方法
                $Wechat->add($data['FromUserName']);
                
                // file_put_contents('./add.txt', $xml);
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

            // 判断如果是上报地理位置事件
            if($data['Event'] == 'LOCATION'){
                //file_put_contents('./del.txt', $xml);
                // 实例化微信信息类型
                $Wechat = new WechatController;
                // 调用上报用户地理位置的方法
                $Wechat->location($data);
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