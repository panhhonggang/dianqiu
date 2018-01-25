/* 
	微信分享接口设置
*/
//微信接口
(function(){
	// console.log('ok,wxjssdk')
	wx.config({
	    debug: false,
	    appId: '{{$info["appId"]}}',
	    timestamp: '{{$info["timestamp"]}}',
	    nonceStr: '{{$info["nonceStr"]}}',
	    signature: '{{$info["signature"]}}',
	    jsApiList: [
			// 所有要调用的 API 都要加到这个列表中
			'onMenuShareTimeline',
			'onMenuShareAppMessage',
			'onMenuShareQQ',
			'onMenuShareWeibo',
			'onMenuShareQZone'
	    ]
	});

	// 当微信内置浏览器完成内部初始化后会触发WeixinJSBridgeReady事件。
	document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	    // 发送给好友
	    WeixinJSBridge.on('menu:share:appmessage', function(argv){
	        shareFriend();
	    });
	    // 分享到朋友圈
	    WeixinJSBridge.on('menu:share:timeline', function(argv){
	        shareTimeline();
	    });
	    // 分享到QQ
	    WeixinJSBridge.on('menu:share:weibo', function(argv){
	        shareQQ();
	    });
	    // 分享到QQ空间
	    WeixinJSBridge.on('menu:share:weibo', function(argv){
	        shareQQZone();
	    });
	    // 分享到微博
	    WeixinJSBridge.on('menu:share:weibo', function(argv){
	        shareWeibo();
	    });
	}, false);

	//分享到朋友圈
	function shareTimeline(){
		wx.onMenuShareTimeline({
		    title: '欢迎使用点球净水物联网', // 分享标题
		    link: 'pub.dianqiukj.com/', // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
		    imgUrl: '__PUBLIC__/Home/dianqiu.jpg', // 分享图标
		    success: function () {
		    // 用户确认分享后执行的回调函数
			}
		})
	}
	//分享给朋友
	function shareFriend(){
		wx.onMenuShareAppMessage({
			title: '欢迎使用点球净水物联网', // 分享标题
			desc: '欢迎使用点球净水物联网', // 分享描述
			link: 'pub.dianqiukj.com/', // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
			imgUrl: '__PUBLIC__/Home/dianqiu.jpg', // 分享图标
			type: '', // 分享类型,music、video或link，不填默认为link
			dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
			success: function () {
			// 用户确认分享后执行的回调函数
			},
			cancel: function () {
			// 用户取消分享后执行的回调函数
			}
		});
	}
	// 获取“分享到QQ”按钮点击状态及自定义分享内容接口
	function shareQQ(){
		wx.onMenuShareQQ({
			title: '欢迎使用点球净水物联网', // 分享标题
			desc: '欢迎使用点球净水物联网', // 分享描述
			link: 'pub.dianqiukj.com/', // 分享链接
			imgUrl: '__PUBLIC__/Home/dianqiu.jpg', // 分享图标
			success: function () {
			// 用户确认分享后执行的回调函数
			},
			cancel: function () {
			// 用户取消分享后执行的回调函数
			}
		});
	}
	// 获取“分享到腾讯微博”按钮点击状态及自定义分享内容接口
	function shareWeibo(){
		wx.onMenuShareWeibo({
			title: '欢迎使用点球净水物联网', // 分享标题
			desc: '欢迎使用点球净水物联网', // 分享描述
			link: 'pub.dianqiukj.com/', // 分享链接
			imgUrl: '__PUBLIC__/Home/dianqiu.jpg', // 分享图标
			success: function () {
			// 用户确认分享后执行的回调函数
			},
			cancel: function () {
			// 用户取消分享后执行的回调函数
			}
		});
	}
	// 获取“分享到QQ空间”按钮点击状态及自定义分享内容接口
	function shareQQZone(){
		wx.onMenuShareQZone({
			title: '欢迎使用点球净水物联网', // 分享标题
			desc: '欢迎使用点球净水物联网', // 分享描述
			link: 'pub.dianqiukj.com/', // 分享链接
			imgUrl: '__PUBLIC__/Home/dianqiu.jpg', // 分享图标
			success: function () {
			// 用户确认分享后执行的回调函数
			},
			cancel: function () {
			// 用户取消分享后执行的回调函数
			}
		});
	}
})()