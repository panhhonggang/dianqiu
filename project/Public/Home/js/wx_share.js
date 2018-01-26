/* 
	微信分享接口设置
*/
//微信接口
var wxShare = function(appId,nonceStr,appsignatureId,timestamp){
	// if(appId && nonceStr && appsignatureId && timestamp){

	// 	console.log(appId,nonceStr,appsignatureId,timestamp)
	// }
	wx.config({
	    debug: false,
	    appId: appId,
	    timestamp: timestamp,
	    nonceStr: nonceStr,
	    signature: appsignatureId,
	    jsApiList: [
			// 所有要调用的 API 都要加到这个列表中
			'onMenuShareTimeline',
			'onMenuShareAppMessage',
			'onMenuShareQQ',
			'onMenuShareWeibo',
			'onMenuShareQZone'
	    ]
	});

	//分享到朋友圈
	wx.onMenuShareTimeline({
	    title: '欢迎使用点球净水物联网', // 分享标题
	    link: 'pub.dianqiukj.com/', // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
	    imgUrl: '__PUBLIC__/Home/images/icon.jpg', // 分享图标
	    success: function () {
	    // 用户确认分享后执行的回调函数
		}
	})
	
	//分享给朋友
	wx.onMenuShareAppMessage({
		title: '欢迎使用点球净水物联网', // 分享标题
		desc: '欢迎使用点球净水物联网', // 分享描述
		link: 'pub.dianqiukj.com/', // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
		imgUrl: '__PUBLIC__/Home/images/icon.jpg', // 分享图标
		type: '', // 分享类型,music、video或link，不填默认为link
		dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
		success: function () {
		// 用户确认分享后执行的回调函数
		},
		cancel: function () {
		// 用户取消分享后执行的回调函数
		}
	});
	
	// 获取“分享到QQ”按钮点击状态及自定义分享内容接口
	wx.onMenuShareQQ({
		title: '欢迎使用点球净水物联网', // 分享标题
		desc: '欢迎使用点球净水物联网', // 分享描述
		link: 'pub.dianqiukj.com/', // 分享链接
		imgUrl: '__PUBLIC__/Home/images/icon.jpg', // 分享图标
		success: function () {
		// 用户确认分享后执行的回调函数
		},
		cancel: function () {
		// 用户取消分享后执行的回调函数
		}
	});
	
	// 获取“分享到腾讯微博”按钮点击状态及自定义分享内容接口
	wx.onMenuShareWeibo({
		title: '欢迎使用点球净水物联网', // 分享标题
		desc: '欢迎使用点球净水物联网', // 分享描述
		link: 'pub.dianqiukj.com/', // 分享链接
		imgUrl: '__PUBLIC__/Home/images/icon.jpg', // 分享图标
		success: function () {
		// 用户确认分享后执行的回调函数
		},
		cancel: function () {
		// 用户取消分享后执行的回调函数
		}
	});
	
	// 获取“分享到QQ空间”按钮点击状态及自定义分享内容接口
	wx.onMenuShareQZone({
		title: '欢迎使用点球净水物联网', // 分享标题
		desc: '欢迎使用点球净水物联网', // 分享描述
		link: 'pub.dianqiukj.com/', // 分享链接
		imgUrl: '__PUBLIC__/Home/images/icon.jpg', // 分享图标
		success: function () {
		// 用户确认分享后执行的回调函数
		},
		cancel: function () {
		// 用户取消分享后执行的回调函数
		}
	});
	
}