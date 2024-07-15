$(function(){
	
	function numberWithCommas(x) {
	       return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	   
	   
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
	        // jsp에서 구현하자니 귀찮아서...
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
	$('.product-select').change(function(event) {
	    const p_num = $(this).attr('data-pnum');
	    const p_price = parseInt($(this).attr('data-pprice'));
	    const pb_quantity = parseInt($(this).attr('data-pbquantity'));
	    const mem_num = $(this).attr('data-mnum');
	    const pb_quantity_text = $('.total_count .cc').text();
	    const total_text = $('.total_price .tt').text();

	    let now_pb_quantity = parseInt(pb_quantity_text.replace('개', ''));
	    let now_total = parseInt(total_text.replace(/[^0-9]/g, ''));

	    if ($(this).is(':checked')) { // 체크 
	        $.ajax({
	            url: 'updateBasketNav',
	            type: 'post',
	            data: {
	                p_price: p_price,
	                pb_quantity: pb_quantity,
	                now_pb_quantity: now_pb_quantity,
	                now_total: now_total,
	                mem_num: mem_num
	            },
	            dataType: 'json',
	            success: function(param) {
	                if (param.result === 'success') {
	                    now_pb_quantity += pb_quantity;
	                    now_total += (p_price * pb_quantity);
	                }
	                updateTotalDisplay(now_pb_quantity, now_total);
	            },
	            error: function() {
	                alert('네트워크 오류 발생');
	            }
	        });
	    } else { // 체크 해제
	        $.ajax({
	            url: 'updateBasketNav',
	            type: 'post',
	            data: {
	                p_price: p_price,
	                pb_quantity: pb_quantity,
	                now_pb_quantity: now_pb_quantity,
	                now_total: now_total,
	                mem_num: mem_num
	            },
	            dataType: 'json',
	            success: function(param) {
	                if (param.result === 'success') {
	                    now_pb_quantity -= pb_quantity;
	                    now_total -= (p_price * pb_quantity);
	                }
	                updateTotalDisplay(now_pb_quantity, now_total);
	            },
	            error: function() {
	                alert('네트워크 오류 발생');
	            }
	        });
	    }

	    function updateTotalDisplay(quantity, total) {
	        let deli = total < 50000 ? 3000 : 0;
	        $('.ttt').text(`${numberWithCommas(total + deli)}원`);
	        $('.tt').text(`${numberWithCommas(total)}원`);
	        $('.cc').text(quantity + '개');
	        $('.dd').text(deli + '원');
			
			$('.ptt').text(`상품 금액 ${numberWithCommas(total)}원`);
			$('.pdd').text(`배송비 ${numberWithCommas(deli)}원`);
			
	    }
	});

		
	// 체크된 항목의 pb_num과 그런 것들을 보내면서 
	$('.buy-basket').on('submit', function(event) {
	    event.preventDefault(); 

	    let count = 1;
	    const checkedProducts = $('.product-select:checked');
	    
	    checkedProducts.each(function() {
	        const pb_num = $(this).data("pbnum");
	        const input = $('<input>', {
	            type: 'hidden',
	            name: 'pb_num' + count,
	            value: pb_num
	        });
	        $(".buy-basket").append(input);
	        count++;
	    });

	    const total_count = document.querySelector('.total_count .cc').textContent.replace('개', '');
	    const total = document.querySelector('.total_price .tt').textContent.replace('원', '');

	    document.getElementById('hiddenTotalCount').value = total_count;
	    document.getElementById('hiddenTotal').value = total;
		document.getElementById('hiddenCount').value = count-1;

	    // 폼 제출
	    $('.buy-basket').off('submit').submit(); // 이전 이벤트 리스너 제거 후 제출
	});

		
});