//计算左边导航栏高度
	window.onload=function(){
		if($(".nav").height()<$("body").height()-140){
			$(".nav").height($("body").height()-136);
		}else{
			$(".nav").height($(".contentRight").height());
		}
	}
