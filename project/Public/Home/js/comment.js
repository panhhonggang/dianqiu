( function() {
	var doc = document.documentElement;
	$("#contain").css({"height":doc.clientHeight, "width":doc.clientWidth});//获取窗口宽高
	// 窗口改变#contain大小改变
	window.onresize = function() {
		$("#contain").css({"height":doc.clientHeight, "width":doc.clientWidth});
	}
	//layuiHint弹框提示封装
	function layuiHint(text){
	        layui.use('layer', function(){
	            var layer = layui.layer;
	            layer.msg(text);
	        });  
	}
}());
