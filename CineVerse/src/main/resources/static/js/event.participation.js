$(function(){
	/*--------------------------------------
	 *	이벤트 참여 여부
	 *--------------------------------------*/
	function selectParticipation(event_num){
		//서버와 통신
		$.ajax({
			url:'getParticipation',
			type:'get',
			data:{event_num:event_num},
			dataType:'json',
			success:function(param){
				displayFav(param);
			},
			error:function(){
				alert('네트워크 오류 발생');
			}	
		});
	}
	
	/*------------------
	 *	이벤트 등록
	 *------------------*/
	$('#event_participate_btn').click(function(){
		let check = confirm('이벤트에 참여하시겠습니까? (참여 후 취소 불가능합니다.)');
		if(check){
			//서버와 통신
			$.ajax({
				url:'writeParticipation',
				type:'post',
				data:{event_num:$('#event_participate_btn').attr('data-num')},
				dataType:'json',
				success:function(param){
					if(param.result == 'logout'){
						alert('로그인 후 참여가능합니다.');
					}else if(param.result == 'success'){
						alert('이벤트 응모 완료');
						$('#event_participate_btn').addClass('participated');
						$('#event_participate_btn').prop('disabled', true);
						/*displayFav(param);*/
					}else{
						alert('이벤트 참여 오류 발생');
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});
		}
	});

	function displayFav(param){
		if(param.status == 'yesP'){
			//버튼 비활성화
			$('#event_participate_btn').addClass('participated');
			$('#event_participate_btn').val('이벤트 참여완료');
			$('#event_participate_btn').prop('disabled', true);
		}else if(param.status == 'noP'){
			//버튼 활성화
			$('#event_participate_btn').removeClass('participated');
			$('#event_participate_btn').prop('disabled', false);
		}else{
			alert('좋아요 표시 오류 발생');
		}

	}
	
	selectParticipation($('#event_participate_btn').attr('data-num'));
	
});