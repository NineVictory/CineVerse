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
					if(param.result=='logout'){
						alert('로그인 후 이용해주세요.');
					} else if (param.result=='wrongAccess'){
						alert('본인만 삭제할 수 있습니다.');
					} else if(param.result =='success'){
						alert('장바구니에서 삭제했습니다.');
						window.location.href = '../shop/shopBasket';	
					} else {
						alert('장바구니 삭제 오류');
					}
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
	$('.update-btn').click(function(){
	    let updateNum;
	    let validInput = false;
	    
	    while (!validInput) {
	        updateNum = prompt("몇 개로 변경하시겠습니까?");
	        
	        // 취소 버튼을 누르면 null이 반환됨
	        if (updateNum === null) {
	            console.log('장바구니 수량 변경 취소');
	            return;
	        }
	        
	        updateNum = parseInt(updateNum, 10); // 숫자로 변환
	        
	        if (!isNaN(updateNum) && updateNum > 0 && updateNum <= 10000) {
	            validInput = true;
	        } else {
	            alert('유효한 수량을 입력해주세요.');
	        }
	    }

	    const pb_num = $(this).attr('data-num');
	    const mem_num = $(this).attr('data-memnum');
	    $.ajax({
	        url: 'basketUpdate',
	        type: 'post',
	        data: {
	            pb_num: pb_num,
	            mem_num: mem_num,
	            updateNum: updateNum 
	        },
	        dataType: 'json',
	        success: function(param) {
				if(param.result=='logout'){
					alert('로그인 후 이용해주세요.');
				} else if (param.result=='wrongAccess'){
					alert('본인만 변경할 수 있습니다.');
				}else if(param.result =='noProduct'){
					alert('재고가 부족합니다.');
				} else if(param.result =='success'){
					alert('장바구니 수량을 변경했습니다.');
					window.location.href = '../shop/shopBasket';	
				} else {
					alert('장바구니 변경 오류');
				}
	        },
	        error: function() {
	            alert('네트워크 오류 발생');
	        }
	    }); 
	});

	// 결제할 상품 선택	
});