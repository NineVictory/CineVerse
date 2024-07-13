$(function(){

	// 장바구니 삭제
	$('.delete-btn').click(function(){
		const deleteCart = confirm('장바구니에서 삭제하겠습니까?');
		if(deleteCart){
			const pb_num = $(this).attr('data-num');
			const mem_num = $(this).attr('data-memnum');
			$.ajax({
				url:'basketDelete',
				type: 'post',
				data:{pb_num:pb_num, mem_num: mem_num},
				dataType: 'json',
				success: function(param){
					alert('장바구니에서 삭제했습니다.')
					window.location.href = '../shop/shopBasket';
				}, 
				error : function(){
					alert('네트워크 오류 발생');
				}
			});
		} else {
			console.log('장바구니 삭제 취소');
		}
	})
	
	
	// 장바구니 수량 조절
	
	// 결제할 상품 선택	
});