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



//设置软件盘弹出后优化页面布局
function solveCompatible(obj){
    var oHeight = $(document).height(); //浏览器当前的高度
    $(window).resize(function(){
        if($(document).height() < oHeight){
            obj.css("position","static");
        }else{
            obj.css("position","absolute");
        } 
    });
}
//layuiHint弹框提示封装
function layuiHint(text){
    layui.use('layer', function(){
        var layer = layui.layer;
        layer.msg(text);
    });  
}
//密码验证封装
function passwordVaild(obj){
    var reg = /^[0-9a-zA-Z]{6,12}$/;
    if(!reg.test(obj)){
        layuiHint("密码只能由6-12位数字或字母组成");
        return 0;
    }else{
        return 1;
    }
}
//验证特殊字符
function specail(val){
    return /[`~!@#$^&*()=|{}':;',\[\].<>/?~！@#￥……&*（）——|{}【】\s‘；：”“'。，、？]/.test(val.trim())?1:0
}
//验证手机号码
function phone(val){
    return /1[3,4,5,6,7,8]\d{9}/.test(val.trim())?1:0
}
//验证email
function email(val){
    return /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/.test(val.trim())?1:0
}
//验证中文
function chinese(val){
    return /[\u4E00-\u9FA5\uF900-\uFA2D]/.test(val.trim())?1:0
}
//提示
function tip(tip,title,fn){
    layui.use('layer', function(){
        var layer = layui.layer;
        layer.confirm(tip, {icon: 3, title:title}, function(index){
            fn&&fn()                
        });
    });
}

