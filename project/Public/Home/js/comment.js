;( function() {
	var doc = document.documentElement;
	$("#contain").css({"height":doc.clientHeight, "width":doc.clientWidth});//获取窗口宽高
	// 窗口改变#contain大小改变
	window.onresize = function() {
		window.location.reload();
		$("#contain").css({"height":doc.clientHeight, "width":doc.clientWidth});
	}
	//layuiHint弹框提示封装
	layuiHint = function(text){
	        layui.use('layer', function(){
	            var layer = layui.layer;
	            layer.msg(text);
	        });  
	};
	return layuiHint;
}());
