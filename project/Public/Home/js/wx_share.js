/* 
	微信分享接口设置
*/
//微信接口
var wxShare = function(appId,nonceStr,signature,timestamp){
	// if(appId && nonceStr && signature && timestamp){

	// 	console.log(appId,nonceStr,signature,timestamp)
	// }
	wx.config({
	    debug: false,
	    appId: appId,
	    timestamp: timestamp,
	    nonceStr: nonceStr,
	    signature: signature,
	    jsApiList: [
			// 所有要调用的 API 都要加到这个列表中
			'onMenuShareTimeline',
			'onMenuShareAppMessage',
			'onMenuShareQQ',
			'onMenuShareWeibo',
			'onMenuShareQZone'
	    ]
	});
	// console.log(encodeURI(location.href.split('#')[0]))
	var title = '净水物联网',
		link = encodeURI(location.href.split('#')[0]),
		desc = '欢迎使用点球净水物联网',
		img = 'http://pub.dianqiukj.com/Public/Home/images/logo.png';  //图标需要绝对路径

	wx.ready(function(){
		//分享到朋友圈
		wx.onMenuShareTimeline({
		    title: title, // 分享标题
		    link: link, // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
		    imgUrl: img, // 分享图标
		    success: function () {
		    // 用户确认分享后执行的回调函数
			}
		})
		
		//分享给朋友
		wx.onMenuShareAppMessage({
			title: title, // 分享标题
			desc: desc, // 分享描述
			link: link, // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
			imgUrl: img, // 分享图标
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
			title: title, // 分享标题
			desc: desc, // 分享描述
			link: link, // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
			imgUrl: img, // 分享图标
			success: function () {
			// 用户确认分享后执行的回调函数
			},
			cancel: function () {
			// 用户取消分享后执行的回调函数
			}
		});
		
		// 获取“分享到腾讯微博”按钮点击状态及自定义分享内容接口
		wx.onMenuShareWeibo({
			title: title, // 分享标题
			desc: desc, // 分享描述
			link: link, // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
			imgUrl: img, // 分享图标
			success: function () {
			// 用户确认分享后执行的回调函数
			},
			cancel: function () {
			// 用户取消分享后执行的回调函数
			}
		});
		
		// 获取“分享到QQ空间”按钮点击状态及自定义分享内容接口
		wx.onMenuShareQZone({
			title: title, // 分享标题
			desc: desc, // 分享描述
			link: link, // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
			imgUrl: img, // 分享图标
			success: function () {
			// 用户确认分享后执行的回调函数
			},
			cancel: function () {
			// 用户取消分享后执行的回调函数
			}
		});
	})
	
}