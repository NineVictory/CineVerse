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
				console.log(param.status);
				displayP(param);
			},
			error:function(){
				alert('네트워크 오류 발생');
			}	
		});
	}
	
	/*------------------
	 *	이벤트 참여
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
						alert('참여 완료');
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
/*
	function displayP(param){
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

	}*/
		
	
	
	/*--------------------------------------
	 * 크라우드 펀딩이이이익
	 *--------------------------------------*/
	var modal = $('#eventModal');
    var btn = $('#event_participate_btn2');
    var span = $('.modal-close');

    // 버튼을 클릭했을 때 모달을 열기
    btn.click(function() {
		var event_num = $(this).data('num');
		$.ajax({
			url:'getParticipation',
			type:'get',
			data:{event_num:event_num},
			dataType:'json',
			success:function(param){
				if(param.status == 'yesP'){
					alert('참여완료한 이벤트입니다.');
				}else if(param.status == 'noP'){
					modal.show();
				}else{
					alert('투표창 오류');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}	
		});
        
    });

    // 닫기 버튼을 클릭했을 때 모달을 닫기
    span.click(function() {
        modal.hide();
    });
    $('#modal_cancel').click(function(){
		modal.hide();
	});

    // 모달 외부를 클릭했을 때 모달을 닫기
    $(window).click(function(event) {
        if ($(event.target).is(modal)) {
            modal.hide();
        }
    });
    
    $('#event_vote').off('submit').on('submit', function(event) {
		event.preventDefault();
	    if (!$('input[name="ep_content"]:checked').val()) {
	        alert('영화를 선택하세요.');
	        event.preventDefault();
	        return false;
	    }else{
			let form_data = $(this).serialize();
			console.log(form_data);
			$.ajax({
				url:'insertCrowd',
				type:'post',
				data:form_data,
				dataType:'json',
				success:function(param){
					if(param.result == 'logout'){
						alert('로그인 후 참여가능합니다.');
						
					}else if(param.result == 'success'){
						alert('투표 완료');
						location.reload();
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});
		}
	});
	
	
	function displayP(param){
		if(param.status == 'yesP'){
			//버튼 비활성화
            $('#event_participate_btn').addClass('participated');
            $('#event_participate_btn').val('이벤트 참여완료');
			$('#event_participate_btn').prop('disabled', true);
			
			$('#event_participate_btn2').addClass('participated');
			$('#event_participate_btn2').val('참여완료');
			$('#event_participate_btn2').prop('disabled', true);
		}else if(param.status == 'noP'){
			//버튼 활성화
			$('#event_participate_btn').removeClass('participated');
			$('#event_participate_btn').prop('disabled', false);
			
			$('#event_participate_btn2').removeClass('participated');
			$('#event_participate_btn2').prop('disabled', false);
		}else{
			alert('참여여부 표시 오류 발생');
		}

	}
	
	//상세 진입시 버튼 상태
	if($('#event_participate_btn').attr('data-num')){
		selectParticipation($('#event_participate_btn').attr('data-num'));
	}else if($('#event_participate_btn2').attr('data-num')){
		selectParticipation($('#event_participate_btn2').attr('data-num'));
	}
	
	
});