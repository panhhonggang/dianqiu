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
                
                //回复图文消息，回复用户登录图文消息
                $this->reactUser($data['FromUserName'],$data['ToUserName']);
                
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

    public function reactUser($toUser, $fromUser)
    {
        $title = '欢迎您的关注';
        $description = '点球电子，电控板的专家品牌，行业领先地位！在在线检测控制，物联网整体解决方案有着技术领先水平。
我们专注于家、商用净水机电控板的研发、生产、销售。已经服务于国内、外近1000个的厂商，我们更懂得在各种使用环境下的产品需求，我们的专家团队能为厂商提供专业的整体解决方案，提升产品品质和使用体验，进而提升客户的品牌度。
秉持精益求精的工匠精神，专注使得我们更专业，使得我们的客户工作更简单！';
        $src = '';
        $url = '';
        $template = "<xml>
                        <ToUserName><![CDATA[%s]]></ToUserName>
                        <FromUserName><![CDATA[%s]]></FromUserName>
                        <CreateTime>%s</CreateTime>
                        <MsgType><![CDATA[%s]]></MsgType>
                        <ArticleCount>1</ArticleCount>
                        <Articles>
                            <item>
                                <Title><![CDATA[%s]]></Title> 
                                <Description><![CDATA[%s]]></Description>
                                <PicUrl><![CDATA[%s]]></PicUrl>
                                <Url><![CDATA[%s]]></Url>
                            </item>
                        </Articles>
                    </xml> ";

        echo sprintf($template, $toUser, $fromUser, time(), 'news', $title, $description, $src, $url);
        
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