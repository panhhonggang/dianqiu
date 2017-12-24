<?php

header("Content-type:text/html;charset=utf-8");

/**
 * 生成二维码 吴智彬
 * @param  string  $url  url连接
 * @param  integer $size 尺寸 纯数字
 */
function qrcode($url,$size=4)
{
    Vendor('Phpqrcode.phpqrcode');
    QRcode::png($url,false,QR_ECLEVEL_L,$size,2,false,0xFFFFFF,0x000000);
}

/**
 * [截取中文字符串数据长度 吴智彬]
 * @param  [type]  $str     [要截取的字符串]
 * @param  integer $start   [开始位置，默认从0开始]
 * @param  [type]  $length  [截取长度]
 * @param  string  $charset [字符编码，默认UTF－8]
 * @param  boolean $suffix  [是否在截取后的字符后面显示省略号，true显示，默认false截取显示，不截取不显示]
 * @return [type]           [截取后的字符串]
 *
 * 模版使用：{{$vo.title|msubstr=0,5,'utf-8',true}}
 */
function msubstr($str, $start=0, $length, $charset="utf-8", $suffix=false)  
{  
  if(function_exists("mb_substr")){  
    if($suffix)  
        return mb_substr($str, $start, $length, $charset)."...";  
      elseif(strlen($str) > $length)
        return mb_substr($str, $start, $length, $charset)."...";  
      else
        return mb_substr($str, $start, $length, $charset);  
  }elseif(function_exists('iconv_substr')) {  
    if($suffix)  
      return iconv_substr($str,$start,$length,$charset)."...";  
    elseif(strlen($str) > $length)
      return iconv_substr($str,$start,$length,$charset)."...";  
    else
      return iconv_substr($str,$start,$length,$charset);  
  }  
  $re['utf-8'] = "/[x01-x7f]|[xc2-xdf][x80-xbf]|[xe0-xef][x80-xbf]{2}|[xf0-xff][x80-xbf]{3}/";  
  $re['gb2312'] = "/[x01-x7f]|[xb0-xf7][xa0-xfe]/";  
  $re['gbk']    = "/[x01-x7f]|[x81-xfe][x40-xfe]/";  
  $re['big5']   = "/[x01-x7f]|[x81-xfe]([x40-x7e]|xa1-xfe])/";  
  preg_match_all($re[$charset], $str, $match);  
  $slice = join("",array_slice($match[0], $start, $length));  
  if($suffix) return $slice."…";
  if(strlen($str) > $length) return $slice."…";
  return $slice;
}

/**
 * [show 打印数据的函数]
 * @param  [type] $data [所有类型数据]
 * @return [type]       [木有]
 */
function show($data)
{
  if(is_null($data)){
    echo 'is null';
  }elseif(is_scalar($data)){
    echo $data;
  }elseif(is_array($data) || is_object($data)){
    echo '<pre>';
      print_r($data);
    echo '</pre>';
  }else{
    dump($data);
  }
}

/**
 * 生产唯一的订单ID
 */
function gerOrderId()
{
  do {
    // 生成唯一订单号
    $orderId = onlyOrderId();
    //查询订单号是否存在
    $oid = M('Orders')->where("`order_id`='{$orderId}'")->field('id')->find();
    // 如果订单号已存在再重新获取一次
  } while ($oid);

  // 绝对唯一的32位订单ID号
  return $orderId;
}

function onlyOrderId(){                     
  // $str = date('Ymd').time().mt_rand(1111111111, 9999999999).mt_rand(1111111111, 9999999999);
  $str = mt_rand(1111111111, 9999999999).mt_rand(1111111111, 9999999999).time();
  $yCode = mb_substr($str, 0, 18);
  return $yCode;
}