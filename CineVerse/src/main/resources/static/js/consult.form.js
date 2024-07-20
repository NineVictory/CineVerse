$(function(){
	// exchange 라디오 버튼이 선택됐을 때 처리
    $('input[name="consult_type"]').change(function() {
        if ($(this).val() === 'exchange') {
            $('#order_num').show(); // 보이도록 설정
        } else {
            $('#order_num').hide(); // 숨기도록 설정
            $('#order_num').val('select');
        }
    });

    // 페이지 로드 시 초기 상태 설정
    if ($('input[name="consult_type"]:checked').val() === 'exchange') {
        $('#order_num').show(); // exchange가 선택되어 있으면 보이도록 설정
    } else {
        $('#order_num').hide(); // 다른 항목이 선택되어 있으면 숨기도록 설정
        $('#order_num').val('select');
    }

	$('#qna_register').submit(function(event){
		
		var consultType = $('input[name="consult_type"]:checked').val();
		var orderNumber = $('#order_num').val();

        if (consultType === 'exchange' && (orderNumber === 'select' || orderNumber === null || orderNumber.trim() === '')) {
		    alert('주문번호를 선택해 주세요');
		    $('#order_num').focus();
		    event.preventDefault();
		    return false;
		}
		
		/*if ($('input[name="consult_type"]:checked').val() == 'exchange' && $('#od_number').val() == 'select') {
			alert('주문번호를 선택해 주세요');
			$('#od_number').focus();
			event.preventDefault();
			return false;
    	}*/
	});
	
	titleLength = $('.custom-title').val().length;
	$('.title-cnt').text('(' + titleLength + '/54)');
	
	$(document).on('keyup','.custom-title',function(){
		let inputL = $(this).val().length;
		if(inputL > 54){
			$(this).val($(this).val().substring(0,54));
		}else{
			let remain = '(' + inputL + '/54)';
			$('.title-cnt').text(remain);
		}
	});
	
});