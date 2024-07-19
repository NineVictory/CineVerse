$(function(){
	
	// exchange 라디오 버튼이 선택됐을 때 처리
    $('input[name="consult_type"]').change(function() {
        if ($(this).val() === 'exchange') {
            $('#od_number').show(); // 보이도록 설정
        } else {
            $('#od_number').hide(); // 숨기도록 설정
            $('#od_number').val('select');
        }
    });

    // 페이지 로드 시 초기 상태 설정
    if ($('input[name="consult_type"]:checked').val() === 'exchange') {
        $('#od_number').show(); // exchange가 선택되어 있으면 보이도록 설정
    } else {
        $('#od_number').hide(); // 다른 항목이 선택되어 있으면 숨기도록 설정
        $('#od_number').val('select');
    }

	$('#qna_register').submit(function(){
		if ($('input[name="consult_type"]:checked').val() === 'exchange') {
			$('#od_number').val()
    }
	});
});