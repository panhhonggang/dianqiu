//$('.page').height($(window).height());
//设置字体自适应大小
(function (doc, win) {
	var docEl = doc.documentElement,
	resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
	recalc = function () {
	  var clientWidth = docEl.clientWidth;
	  if (!clientWidth) return;
	  docEl.style.fontSize = 20 * (clientWidth / 320) + 'px';
	};
  	if (!doc.addEventListener) return;
  	win.addEventListener(resizeEvt, recalc, false);
  	doc.addEventListener('DOMContentLoaded', recalc, false);
})(document, window);
//服务器提示信息
function hint(hint){
	if(hint)
	{
		$('.hint_bg').css("display","block");
		$('.hint_bg').height($(window).height());
		$('.hint_text').html(hint);
		$('.hint_btn').click(function(){
			$('.hint_bg').css("display","none");
		});
	}
}

//拖拽显示js：
function id(obj) {
    return document.getElementById(obj);
}
	//绑定方法
function bind(obj, ev, fn) { 
    if (obj.addEventListener) {
        obj.addEventListener(ev, fn, false);
    } else {
        obj.attachEvent('on' + ev, function() {
            fn.call(obj);
        });
    }
}
	// 添加class
function addClass(obj, sClass) { 
    var aClass = obj.className.split(' ');
    if (!obj.className) {
        obj.className = sClass;
        return;
    }
    for (var i = 0; i < aClass.length; i++) {
        if (aClass[i] === sClass) return;
    }
    obj.className += ' ' + sClass;
}
	// 删除class
function removeClass(obj, sClass) { 
    var aClass = obj.className.split(' ');
    if (!obj.className) return;
    for (var i = 0; i < aClass.length; i++) {
        if (aClass[i] === sClass) {
            aClass.splice(i, 1);
            obj.className = aClass.join(' ');
            break;
        }
    }
}
	//默认事件
bind(document,"touchmove",function(ev){
    ev.preventDefault();
});
	//text触屏滑动
function fnTab_txt(oTab,oList,aNav,iW,classActive)
{
    // var oTab=id("text");
    // var oList=id("textList");
    // var aNav=id("textNav").children;
    var iNow=0;//任意自然数
    var iX=0;
    // var iW=$(window).width();
    var oTimer=0;
    var iStartTouchX=0;
    var iStartX=0;
    bind(oTab,"touchstart",fnStart);
    bind(oTab,"touchmove",fnMove);
    bind(oTab,"touchend",fnEnd);
    //拖拽
    function fnStart(ev)
    {
        oList.style.transition="none";
        ev=ev.changedTouches[0];//触发当前手指列表第一个
        iStartTouchX=ev.pageX;//获取当前手指的目标
        iStartX=iX;
        clearInterval(oTimer);
    }
    function fnMove(ev)
    {
        ev=ev.changedTouches[0];
        var iDis=ev.pageX-iStartTouchX;
        iX=iStartX+iDis;
        oList.style.WebkitTransform=oList.style.transform="translateX("+iX+"px)";
    }
    function fnEnd()
    {
        iNow=iX/iW;
        iNow=-Math.round(iNow);
        if(iNow<0)//最小
        {
            iNow=0;
        }
        if(iNow>aNav.length-1)//最大
        {
            iNow=aNav.length-1;
        }
        tab();
    }
    function tab()
    {
        iX=-iNow*iW;
        oList.style.transition="0.01s";
        oList.style.WebkitTransform=oList.style.transform="translateX("+iX+"px)";
        for(var i=0;i<aNav.length;i++)
        {
            removeClass(aNav[i],classActive);
        }
        addClass(aNav[iNow],classActive);
    }
}

// 微信支付方法
function weixinPay(res){
    WeixinJSBridge.invoke(
        'getBrandWCPayRequest',
        JSON.parse(res),
        function(res){
            if (res.err_msg.substr(-2) == 'ok') {
                // 付款成功，跳转前台主页
                location.href = "{{:U('Home/PaymentSystem/paySuccess')}}";
            } else if (res.err_msg.substr(-6) == 'cancel') {
                    // 取消付款
                    // 跳转到待付款订单页面
                    location.href = "{{:U('Home/PaymentSystem/failureToPay')}}";
            }else{
                    // 付款失败
                    // 跳转到待付款订单页面
                    location.href = "{{:U('Home/PaymentSystem/failureToPay')}}";
            }
        }
    );
};