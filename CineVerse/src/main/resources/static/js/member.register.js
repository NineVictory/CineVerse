$(function(){
	/**
 	*  회원 가입
 	*/
	// 아이디 중복 여부 저장 변수
	let checkId = 0;
	// 0: 아이디 중복 또는 체크 미실행
	// 1: 아이디 미중복
	
	// 아이디 중복 체크
	 $('#mem_id').blur(function(){
		if($('#mem_id').val().trim() == ''){
			$('#message_id').css('color','red').text('아이디를 입력하세요');
			$('#id').val('').focus();
			return;
		}
		
		$('#message_id').text('');	// 알림 메세지 초기화
		
		// 서버와 통신하기
		// url: 같은 경로 url 명시
		$.ajax({
			url:'confirmId',
			type:'get',
			data:{mem_id:$('#mem_id').val()},
			dataType: 'json',
			success:function(param){
				if(param.result == `idDuplicated`){
					checkId = 0;
					$('#message_id').css('color','red').text('중복된 아이디');
					$('#mem_id').val('').focus();
				}
				else if(param.result == `notMatchPattern`){
					checkId = 0;
					$('#message_id').css('color','red').text('잘못된 형식');
					$('#mem_id').val('').focus();
				}
				else if(param.result == 'idNotFound'){
					checkId = 1;
					$('#message_id').css('color','#000').text('등록 가능한 ID');
				} else{
					checkId = 0;
					alert('ID 중복 체크 오류가 발생하였습니다.')
				}
			},
			error:function(){
				checkId = 0;
				alert('네트워크 오류가 발생하였습니다.');
			}
			
		}); // end of ajax
	 }); // end of click
	
	// 아이디 중복 안내 메세지 초기화 및 아이디 중복 값 초가화
	$('#member_register #mem_id').keydown(function(){
		checkId = 0;
		$('#message_id').text('');
	}); // end of keydown
	
	$('#member_register').submit(function(){
		if(checkId == 0){
			$('#message_id').css('color','red').text('ID 중복 체크는 필수');
			
			if($('#mem_id').val().trim()==''){
				$('#mem_id').val('').focus();
			}
			return false;
		}
	});	// end of submit
	
	
	let checkPhone = 0;
	
	 $('#mem_phone').blur(function(){
		if($('#mem_phone').val().trim() == ''){
			$('#message_phone').css('color','red').text('전화번호를 입력하세요');
			$('#mem_phone').val('').focus();
			return;
		}
		
		$('#message_phone').text('');	// 알림 메세지 초기화

		$.ajax({
			url:'confirmPhone',
			type:'get',
			data:{mem_phone:$('#mem_phone').val()},
			dataType: 'json',
			success:function(param){
				if(param.result == `phoneDuplicated`){
					checkPhone = 0;
					$('#message_phone').css('color','red').text('중복된 번호');
					$('#mem_phone').val('').focus();
				}
				else if(param.result == 'phoneNotFound'){
					checkPhone = 1;
					$('#message_phone').css('color','#000').text('등록 가능한 번호');
				} else{
					checkPhone = 0;
					alert('ID 중복 체크 오류가 발생하였습니다.')
				}
			},
			error:function(){
				checkPhone = 0;
				alert('네트워크 오류가 발생하였습니다.');
			}
			
		}); // end of ajax
	 }); // end of click
	
	$('#member_register #mem_phone').keydown(function(){
		checkId = 0;
		$('#message_phone').text('');
	}); // end of keydown
	
	$('#member_register').submit(function(){
		if(checkId == 0){
			$('#message_phone').css('color','red').text('번호 중복 체크는 필수');
			
			if($('#mem_phone').val().trim()==''){
				$('#mem_phone').val('').focus();
			}
			return false;
		}
	});	// end of submit
	
	let checkEmail = 0;
	
	 $('#mem_email').blur(function(){
		if($('#mem_email').val().trim() == ''){
			$('#message_email').css('color','red').text('이메일을 입력하세요');
			$('#mem_email').val('').focus();
			return;
		}
		
		$('#message_email').text('');	// 알림 메세지 초기화

		$.ajax({
			url:'confirmEmail',
			type:'get',
			data:{mem_email:$('#mem_email').val()},
			dataType: 'json',
			success:function(param){
				if(param.result == `emailDuplicated`){
					checkEmail = 0;
					$('#message_email').css('color','red').text('중복된 이메일');
					$('#mem_email').val('').focus();
				}
				else if(param.result == 'emailNotFound'){
					checkEmail = 1;
					$('#message_email').css('color','#000').text('등록 가능한 이메일');
				} else{
					checkEmail = 0;
					alert('ID 중복 체크 오류가 발생하였습니다.')
				}
			},
			error:function(){
				checkPhone = 0;
				alert('네트워크 오류가 발생하였습니다.');
			}
			
		}); // end of ajax
	 }); // end of click
	
	$('#member_register #mem_email').keydown(function(){
		checkId = 0;
		$('#message_email').text('');
	}); // end of keydown
	
	$('#member_register').submit(function(){
		if(checkId == 0){
			$('#message_email').css('color','red').text('이메일 중복 체크는 필수');
			
			if($('#mem_email').val().trim()==''){
				$('#mem_email').val('').focus();
			}
			return false;
		}
	});	// end of submit
	
	
}); // end of function

