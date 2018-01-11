
// mine-name的收缩

$(function(){
	$('.shang').css('display','none');
	$('.mine-name').css('display','none');
	$('.xia').css('display','block');
	$('#mine-first-all').removeClass('mine-first-all')
		
	$('.shang').click(function(){
		$(this).css('display','none');
		$('.mine-name').css('display','none');
		$('.xia').css('display','block');
		$('#mine-first-all').removeClass('mine-first-all')
	});
});

$(function(){
	$('.xia').click(function(){
		$(this).css('display','none');
		$('.shang').css('display','block');
		$('.mine-name').css('display','block')

		// console.log($('#mine-first-all').attr('url'))
		$('#mine-first-all').addClass('mine-first-all');
		// .css('background-size',' contain');
		// background: url("./images/mine-first-01.png") 0% 0% / contain no-repeat;
		// __PUBLIC__/Home/css/mine-first.css
		// 
	});
});

// 我的订单下面的li
$(function(){
			$('#m-f-list li').bind({
				'mouseover' : function () { 

				$(this).css('color','#FF8600');
				},
				'mouseout' : function () {
				$(this).css('color','#000');
				}
			});
		});

// m-f-b-list-js样式
$(function(){
	$('#m-f-b-list ul li a i').bind({
		'mouseover':function(){
		$(this).css('background','#F1F1F1');
		},
		'mouseout':function(){
			$(this).css('background','#FFF');
		}
	})
});

	$(function(){
	$('#m-f-b-list ul li a p').bind({
		'mouseover':function(){
		$(this).css('background','#F1F1F1');
		},
		'mouseout':function(){
			$(this).css('background','#FFF');
		}
	})
});