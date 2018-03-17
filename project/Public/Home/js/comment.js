( function() {
	//layuiHint弹框提示封装
	layuiHint = function(text){
	        layui.use('layer', function(){
	            var layer = layui.layer;
	            layer.msg(text);
	        });
	};
	return layuiHint;
}());
