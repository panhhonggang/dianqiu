<?php
/* 温馨提示：
 * 在flash的参数名upload_url中可自行定义一些参数（请求方式：GET），定义后在服务器端获取即可，比如可以应用到用户验证，文件的保存名等。
 * 本示例未作极致的用户体验与严谨的安全设计（如用户直接访问此页时该如何，万一客户端数据不可信时验证文件的大小、类型等），只保证正常情况下无误，请阁下注意。
 */

		$result = array();
		$result['success'] = true;

		//上传目录
		//$dir_filename = "upload/".date("YmdHis").time().".jpg";
		$dir_filename = "http://www.zhuce.com/static/Admin/H+smarty/plugins/fullavatareditor/php/upload/".date("YmdHis").time().".jpg";

		foreach($_FILES as $key => $v){
			if(isset($_FILES[$key]['tmp_name'])){
				move_uploaded_file($_FILES[$key]["tmp_name"],$dir_filename);
			}
		}

		//返回图片的保存结果（返回内容为json字符串）
		echo json_encode($result);

/**************************************************************
*  生成指定长度的随机码。
*  @param int $length 随机码的长度。
*  @access public
**************************************************************/
function createRandomCode($length)
{
	$randomCode = "";
	$randomChars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	for ($i = 0; $i < $length; $i++)
	{
		$randomCode .= $randomChars { mt_rand(0, 35) };
	}
	return $randomCode;
}
?>
