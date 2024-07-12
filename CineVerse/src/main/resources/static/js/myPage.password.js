$(function(){
	/*---------------------------------------
	비밀번호 변경 체크
	----------------------------------------*/
	$('#mem_passwd').keyup(function(){
		if($('#confirm_passwd').val()!=''&&$('#confirm_passwd').val()!=$(this).val()){
			$('#message_password').text('비밀번호 불일치').css('color', 'red');
		} else if($('#confirm_passwd').val()!=''&&$('#confirm_passwd').val()==$(this).val()){
			$('#message_password').text('비밀번호 일치').css('color', 'black');
		}
	});
	
	$('#confirm_passwd').keyup(function(){
		if($('#mem_passwd').val()!=''&&$('#mem_passwd').val()!=$(this).val()){
			$('#message_password').text('비밀번호 불일치').css('color', 'red');
		} else if($('#mem_passwd').val()!=''&&$('#mem_passwd').val()==$(this).val()){
			$('#message_password').text('비밀번호 일치').css('color', 'black');
		}
	});
	
	
	$('#member_change').submit(function(){
		if($('#now_passwd').val().trim()==''){
			alert('현재 비밀번호를 입력하세요');
			$('#now_passwd').val('').focus();
			return false;
		}
		if($('#mem_passwd').val().trim()==''){
			alert('변경할 비밀번호를 입력하세요');
			$('#mem_passwd').val('').focus();
			return false;
		}
		if($('#confirm_passwd').val().trim()==''){
			alert('비밀번호 확인을 입력하세요');
			$('#confirm_passwd').val('').focus();
			return false;
		}
		
		if($('#mem_passwd').val().trim()!=$('#confirm_passwd').val()){
			$('#message_password').text('비밀번호 불일치').css('color', 'red');
			return false;
		}
		
	});
});