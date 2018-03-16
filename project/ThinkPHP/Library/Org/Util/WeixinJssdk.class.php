<?php
namespace Org\Util;

class WeixinJssdk
{
  //=======【基本信息设置】=====================================
  //
  /**
   * TODO: 修改这里配置为您自己申请的商户信息
   * 微信公众号信息配置
   * 
   * APPID：绑定支付的APPID（必须配置，开户邮件中可查看）
   * 
   * MCHID：商户号（必须配置，开户邮件中可查看）
   * 
   * KEY：商户支付密钥，参考开户邮件设置（必须配置，登录商户平台自行设置）
   * 设置地址：https://pay.weixin.qq.com/index.php/account/api_cert
   * 
   * APPSECRET：公众帐号secert（仅JSAPI支付的时候需要配置， 登录公众平台，进入开发者中心可设置），
   * 获取地址：https://mp.weixin.qq.com/advanced/advanced?action=dev&t=advanced/dev&token=2005451881&lang=zh_CN
   * @var string
   */
  public $APPID     = 'wxae48f3bbcda86ab1';
  public $APPSECRET = '1c39100b331713ae9e96a4e5eb470424';
  public $MCHID     = '1394894802';
  public $KEY       = 'CAA5EAE2CE5AC44A3F8930E6F127B423';

  //=======【证书路径设置】=====================================
  /**
   * TODO：设置商户证书路径
   * 证书路径,注意应该填写绝对路径（仅退款、撤销订单时需要，可登录商户平台下载，
   * API证书下载地址：https://pay.weixin.qq.com/index.php/account/api_cert，下载之前需要安装商户操作证书）
   * @var path
   */
  public $SSLCERT_PATH = '../cert/apiclient_cert.pem';
  public $SSLKEY_PATH = '../cert/apiclient_key.pem';
  
  //=======【curl代理设置】===================================
  /**
   * TODO：这里设置代理机器，只有需要代理的时候才设置，不需要代理，请设置为0.0.0.0和0
   * 本例程通过curl使用HTTP POST方法，此处可修改代理服务器，
   * 默认CURL_PROXY_HOST=0.0.0.0和CURL_PROXY_PORT=0，此时不开启代理（如有需要才设置）
   * @var unknown_type
   */
  public $CURL_PROXY_HOST = "0.0.0.0";//"10.152.18.220";
  public $CURL_PROXY_PORT = 0;//8080;
  
  //=======【上报信息配置】===================================
  /**
   * TODO：接口调用上报等级，默认紧错误上报（注意：上报超时间为【1s】，上报无论成败【永不抛出异常】，
   * 不会影响接口调用流程），开启上报之后，方便微信监控请求调用的质量，建议至少
   * 开启错误上报。
   * 上报等级，0.关闭上报; 1.仅错误出错上报; 2.全量上报
   * @var int
   */
  public $REPORT_LEVENL = 1;

  // JS-SDK权限验证的签名
  public function getSignPackage() 
  {
    $jsapiTicket = $this->getJsApiTicket();
  
    // 注意 URL 一定要动态获取，不能 hardcode.
    $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off' || $_SERVER['SERVER_PORT'] == 443)? "https://" : "http://";
    $url = "$protocol$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
  
    $timestamp = time();
    $nonceStr = $this->createNonceStr();
  
    // 这里参数的顺序要按照 key 值 ASCII 码升序排序
    $string = "jsapi_ticket=$jsapiTicket&noncestr=$nonceStr&timestamp=$timestamp&url=$url";
  
    $signature = sha1($string);
  
    // JS-SDK config 配置需要的参数
    $signPackage = array(
      "appId"     => $this->APPID,
      "nonceStr"  => $nonceStr,
      "timestamp" => $timestamp,
      "signature" => $signature,
      "rawString" => $string,
      "url"       => $url
    );
    return $signPackage; 
  }

  // 辅助方法-----------------------------------------------------------------------------------------------------------------
  // access_token 是公众号的全局唯一接口调用凭据，公众号调用各接口时都需使用 
  public function getAccessToken() 
  {
    //return dirname(__FILE__).'/weixin/'."access_token.php";
    // access_token 全局存储7000与更新[文件形式缓存]
    $data = json_decode($this->get_php_file("access_token.php"));

   
    // 判断access_token是否过期
    if ($data->expire_time < time()) {
    
      $url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=$this->APPID&secret=$this->APPSECRET";
      $res = json_decode($this->httpGet($url));
      //show($res);die;
      $access_token = $res->access_token;
      if ($access_token) {
        $data->expire_time = time() + 7000;
        $data->access_token = $access_token;
        $this->set_php_file("access_token.php", json_encode($data));
      }
    } else {
      $access_token = $data->access_token;
    }
    //show($access_token);die;
    return $access_token;
  }

  // jsapi_ticket公众号用于调用微信JS接口的临时票据，对于JS-SDK权限开发验证
  public function getJsApiTicket() 
  {
      // jsapi_ticket 全局存储7000与更新[文件形式缓存]
      $data = json_decode($this->get_php_file("jsapi_ticket.php"));
      if ($data->expire_time < time()) {
          $accessToken = $this->getAccessToken();
          $url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?type=jsapi&access_token=$accessToken";
          $res = json_decode($this->httpGet($url));
          $ticket = $res->ticket;
          if ($ticket) {
            $data->expire_time = time() + 7000;
            $data->jsapi_ticket = $ticket;
            $this->set_php_file("jsapi_ticket.php", json_encode($data));
          }
      } else {
        $ticket = $data->jsapi_ticket;
      }
      
      return $ticket;
  }

  // 随机字符串
  public function createNonceStr($length = 16) 
  {
    $chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    $str = "";
    for ($i = 0; $i < $length; $i++) {
      $str .= substr($chars, mt_rand(0, strlen($chars) - 1), 1);
    }
    return $str;
  }

  // 专用于发HTTP GET请求 
  public function httpGet($url) 
  {
    $curl = curl_init();
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($curl, CURLOPT_TIMEOUT, 500);
    // https请求 不验证证书和hosts
    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
    curl_setopt($curl, CURLOPT_URL, $url);
  
    $res = curl_exec($curl);
    curl_close($curl);
  
    return $res;
  }
  
  // 读取文的方法
  public function get_php_file($filename) 
  {
    //show(trim(substr(file_get_contents(dirname(__FILE__).'/weixin/'.$filename), 15)));die;
    return trim(substr(file_get_contents(dirname(__FILE__).'/weixin/'.$filename), 15));
  }
  
  // 写入文的方法
  public function set_php_file($filename, $content) 
  {
    $fp = fopen(dirname(__FILE__).'/weixin/'.$filename, "w");
    fwrite($fp, "<?php exit();?>" . $content);
    fclose($fp);
  }

  // 微信支付部分
  // 1: 获取用户openID: 在关注者与公众号产生消息交互后,公众号可获得关注者的OpenID,对于不同公众号,同一用户的openid不同id
  /**
   * 
   * 通过跳转获取用户的openid，跳转流程如下：
   * 1、设置自己需要调回的url及其其他参数，跳转到微信服务器https://open.weixin.qq.com/connect/oauth2/authorize
   * 2、微信服务处理完成之后会跳转回用户redirect_uri地址，此时会带上一些参数，如：code
   * 
   * @return 用户的openid
   */
  public function GetOpenid()
  {
    //通过code获得openid
    if (!isset($_GET['code'])){
      //触发微信返回code码
      $baseUrl = urlencode('http://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'].$_SERVER['QUERY_STRING']);
      $url = $this->__CreateOauthUrlForCode($baseUrl);
      Header("Location: $url");
      exit();
    } else {
      //获取code码，以获取openid
      $code = $_GET['code'];
      $openid = $this->getOpenidFromMp($code);
      return $openid;
    }
  }

  // 辅助功能

  /**
   * 
   * 构造获取code的url连接
   * @param string $redirectUrl 微信服务器回跳的url，需要url编码
   * 
   * @return 返回构造好的url
   */
  public function __CreateOauthUrlForCode($redirectUrl)
  {
    $urlObj["appid"] = $this->APPID;
    $urlObj["redirect_uri"] = "$redirectUrl";
    $urlObj["response_type"] = "code";
    $urlObj["scope"] = "snsapi_base";
    $urlObj["state"] = "STATE"."#wechat_redirect";
    $bizString = $this->ToUrlParams($urlObj);
    return "https://open.weixin.qq.com/connect/oauth2/authorize?".$bizString;
  }

  /**
   * 
   * 拼接签名字符串
   * @param array $urlObj
   * 
   * @return 返回已经拼接好的字符串
   */
  public function ToUrlParams($urlObj)
  {
    $buff = "";
    foreach ($urlObj as $k => $v)
    {
      if($k != "sign"){
        $buff .= $k . "=" . $v . "&";
      }
    }
    
    $buff = trim($buff, "&");
    return $buff;
  }

  /**
   * 
   * 通过code从工作平台获取openid机器access_token
   * @param string $code 微信跳转回来带上的code
   * 
   * @return openid
   */
  public function GetOpenidFromMp($code)
  {
    $url = $this->__CreateOauthUrlForOpenid($code);
    // 初始化curl
    $ch = curl_init();
    // 设置超时
    curl_setopt($ch, CURLOPT_TIMEOUT, $this->curl_timeout);
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER,FALSE);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST,FALSE);
    curl_setopt($ch, CURLOPT_HEADER, FALSE);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
    if($CURL_PROXY_HOST != "0.0.0.0" && $CURL_PROXY_PORT != 0){
      curl_setopt($ch,CURLOPT_PROXY, $CURL_PROXY_HOST);
      curl_setopt($ch,CURLOPT_PROXYPORT, $CURL_PROXY_PORT);
    }
    // 运行curl，结果以jason形式返回
    $res = curl_exec($ch);
    curl_close($ch);
    //取出openid
    $data = json_decode($res,true);
    $this->data = $data;
    $openid = $data['openid'];
    return $openid;
  }

  /**
   * 
   * 构造获取open和access_toke的url地址
   * @param string $code，微信跳转带回的code
   * 
   * @return 请求的url
   */
  public function __CreateOauthUrlForOpenid($code)
  {
    $urlObj["appid"] = $this->APPID;
    $urlObj["secret"] = $this->APPSECRET;
    $urlObj["code"] = $code;
    $urlObj["grant_type"] = "authorization_code";
    $bizString = $this->ToUrlParams($urlObj);
    return "https://api.weixin.qq.com/sns/oauth2/access_token?".$bizString;
  }
}

