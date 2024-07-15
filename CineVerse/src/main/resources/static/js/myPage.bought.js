$(function(){
	$('.my_order_confirm').on('click', function(){
		let orderConfirm = confirm('주문 확정하시겠습니까?');
		if(orderConfirm){
			const order_number = $(this).attr('data-num');
			const mem_num = $(this).attr('data-mnum');
			$.ajax({
				url: 'orderConfirm',
				type: 'post',
				data: {order_number:order_number, mem_num:mem_num},
				dataType: 'json',
				success: function(param){
					if(param.result=='logout'){
						alert('로그인 후 이용해주세요.');
					} else if (param.result=='wrongAccess'){
						alert('본인만 확정할 수 있습니다.');
					} else if(param.result =='success'){
						alert('주문 확정했습니다.');
						window.location.href = '../myPage/bought';	
					} else {
						alert('주문 확정 오류');
					}
				},
				error : function(){
					alert('네트워크 오류');
				}
			});
		}
	});
});