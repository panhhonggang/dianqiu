<?php
    if(C('LAYOUT_ON')) {
        echo '{__NOLAYOUT__}';
    }
?>
<!DOCTYPE html>
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- layui.js -->
    <script type="text/javascript" src="__PUBLIC__/Admin/layui/layui.js"></script>
    <!-- layui.css -->
    <link rel="stylesheet" href="__PUBLIC__/Admin/layui/css/layui.css" />
<title>跳转提示</title>
<style type="text/css">
*{ padding: 0; margin: 0; text-align: center;}
body{ background: #fff; font-family: '微软雅黑'; color: #333; font-size: 16px; }
.system-message{ padding: 24px 48px; margin-top: 150px; }
.system-message h1{ font-size: 100px; font-weight: normal; line-height: 120px; margin-bottom: 12px; }
.system-message .jump{ padding-top: 10px}
.system-message .jump a{ color: #333;}
.system-message .success,.system-message .error{ line-height: 1.8em; font-size: 36px; }
.system-message .detail{ font-size: 12px; line-height: 20px; margin-top: 12px; display:none}
</style>
</head>
<body>
<div class="system-message">
<?php if(isset($message)) {?>
<i class="layui-icon" style="font-size: 100px; color: #1E9FFF;">&#xe60c;</i>  
<p class="success"><?php echo($message); ?></p>
<?php }else{?>
<i class="layui-icon" style="font-size: 100px; color: #1E9FFF;">&#xe651;</i>  
<p class="error"><?php echo($error); ?></p>
<?php }?>
<p class="detail"></p>
<p class="jump">
页面自动 <a id="href" href="<?php echo($jumpUrl); ?>">跳转</a> 等待时间： <b id="wait"><?php echo($waitSecond); ?></b>
</p>
</div>
<script type="text/javascript">
(function(){
var wait = document.getElementById('wait'),href = document.getElementById('href').href;
var interval = setInterval(function(){
	var time = --wait.innerHTML;
	if(time <= 0) {
		location.href = href;
		clearInterval(interval);
	};
}, 1000);
})();
</script>
</body>
</html>
