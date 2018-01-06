//计算左边导航栏高度
window.onload=function(){
	if($(".nav").height()<$("body").height()-140){
		$(".nav").height($("body").height()-136);
	}else{
		$(".nav").height($(".contentRight").height());
	}
}
//layuiHint弹框提示封装
function layuiHint(text){
    layui.use('layer', function(){
        var layer = layui.layer;
        layer.msg(text);
    });  
}
