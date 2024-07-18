$(function(){
	/*비밀 번호 찾기*/
	$('#member_findPasswd').submit(function(event){
		if($('#mem_id').val().trim() == ''){
			alert('아이디를 입력하세요.');
			$('#mem_id').val('').focus();
			return false;
		}
		if($('#mem_email').val().trim() == ''){
			alert('이메일을 입력하세요.');
			$('#mem_email').val('').focus();
			return false;
		}
		if($('#mem_phone').val().trim() == ''){
			alert('전화번호를 입력하세요.');
			$('#mem_phone').val('').focus();
			return false;
		}
		
		let form_data = $(this).serialize();
		
		// 서버와 통신하기
		$.ajax({
			url:'getPasswordInfo',
			type:'post',
			data:form_data,
			dataType:'json',
			beforeSend:function(){
				$('.loading-background').show();
				$('.loading').show();	//로딩바 표시하기
			},
			complete:function(){
				$('.loading-background').hide();
				$('.loading').hide();		// 로딩바 숨기기
			},
			success:function(param){
				if(param.result == 'invalidInfo'){
					alert('아이디,전화번호, 이메일을 정확히 입력하였는지 확인 바랍니다.')
				} else if(param.result == 'noAuthority'){
					alert('정지 회원입니다.')
				} else if(param.result == 'failure'){
					alert('임시 비밀번호 생성에 실패하였습니다.')
				} else if(param.result == 'success'){
					alert('이메일로 임시 비밀번호가 발송되었습니다.');
					location.href='login';	
				} else {
					alert('임시 비밀번호 생성 중 오류가 발생하였습니다.')
				}
			},
			error : function() {
				alert('네트워크 오류가 발생하였습니다.')
			}
			
		});
		
		
		// 기본 이벤트 제거하기
		event.preventDefault();
	})
})