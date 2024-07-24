$(function(){

	console.log('Document is ready');

	$('#ab_status').change(function() {
	    let status = $(this).val();
	    let num = $(this).data('num');

	    $.ajax({
            url:'updateStatus',
            type:'post',
            data:{ab_num:num,ab_status: status},
            success:function(param) {
                if(param.result == 'logout'){
                	alert('로그인 후 상태변경 가능합니다.');
                	
                }else if(param.result == 'success'){
                	alert('상태변경 완료');
                	
                }else if(param.result == 'wrongAccess'){
					alert('타인의 글은 수정할 수 없습니다.');
                }else{
                	alert('상태 변경 오류 발생');
                }
            },
            error:function() {
                alert('네트워크 오류 발생');
            }
        });
	});


});