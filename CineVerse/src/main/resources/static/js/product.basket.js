$(function(){
	/*----------------------
	 * 찜하기, 찜취소하기
	 *---------------------*/
	$('#basket').click(function(event){
		event.preventDefault();
		$.ajax({
			url:'productBasket',
			type:'post',
			data:{p_num:$('#basket').attr('data-num')},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 장바구니를 이용해주세요');
				}else if(param.result == 'success'){
					displayBasket(param);
				}else{
					alert('장바구니 등록/삭제 오류 발생');
				}				
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});	
	
	
});








