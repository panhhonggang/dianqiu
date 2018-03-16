;( function() {
	var doc = document.documentElement;
	$("#contain").css({"height":doc.clientHeight});//获取窗口宽高

	//layuiHint弹框提示封装
	layuiHint = function(text){
	        layui.use('layer', function(){
	            var layer = layui.layer;
	            layer.msg(text);
	        });  
	};
	return layuiHint;
}());
