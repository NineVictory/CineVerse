$(function(){
	$('#user_modify_btn').submit(function(){
		
		if($('#a_name').val().trim()==''){
			alert('배송지 이름을 입력해주세요');
			$('#a_name').val('').focus();
			return false;
		}
		if($('#a_zipcode').val().trim()==''){
			alert('우편번호를 입력하세요');
			$('#a_zipcode').val('').focus();
			return false;
		}
		if($('#a_address1').val().trim()==''){
			alert('주소를 입력하세요');
			$('#a_address1').val('').focus();
			return false;
		}
		if($('#a_address2').val().trim()==''){
			alert('상세주소를 입력하세요');
			$('#a_address2').val('').focus();
			return false;
		}
		if($('#a_phone').val().trim()==''){
			alert('전화번호를 입력하세요');
			$('#a_phone').val('').focus();
			return false;
		}
	})
});