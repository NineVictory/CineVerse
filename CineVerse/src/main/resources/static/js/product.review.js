$(function() {
    $('#mr_form').submit(function(event) {
        // 내용이 비어있는지 확인
        if ($('#mr_content').val().trim() == '') {
            alert('내용을 입력해주세요@@@@@@');
            $('#mr_content').val('').focus();
            return false;
        }

        // form 데이터 serialize
        let form_data = $(this).serialize();
        
        // 서버와 통신
        $.ajax({
            url: 'writeMateReview.do',
            type: 'post',
            data: form_data, 
            dataType: 'json',
            success: function(param) {
                if (param.result === 'logout') {
                    alert('로그인 후 사용하세요!');
                } else if (param.result === 'success') {
                    $.ajax({
                        url: 'howManyReview.do',
                        type: 'post',
                        data: form_data,
                        dataType: 'json',
                        success: function(param) {
                            if(param.result=='logout'){
								alert('로그인 후 사용하세요!')
							} else if(param.result=='finish'){
								alert('모든 팀원의 리뷰를 작성하였으므로 프로젝트가 완료되었습니다.');
								location.reload();
							} else if(param.result=='ing'){
								alert('리뷰 작성이 완료되었습니다.')
								location.reload();
							}
                        },
                        error: function() {
                            alert('리뷰 데이터 가져오기 실패');
                        }
                    });
                } else {
                    alert('리뷰 작성 실패했습니다.');
                }
            },
            error: function() {
                alert('네트워크 오류 발생');
            }
        });

        // 이벤트 전파 차단
        event.preventDefault();
    });
	

	/*mate_review 리뷰 작성하는 모달*/
	const mate_review = $("#mate_review");

	/* 모달 on 함수 */
	function modalOn() {
	    mate_review.css("display", "flex");
	}

	/* 모달 off 함수 */
	function modalOff() {
	    mate_review.hide();
	}

	/* 리뷰 쓰기 메뉴 */
	$(".my_order_review").click(function(e) {
	    e.preventDefault();
	    
	    // 개인의 닉네임 가져와서 innerText 시키기
	    const nickname = $(this).closest('.mem_personal').find('.team_mem_nickname').data('nickname');
	    $('.mate_review_profile .user_nickname').text(nickname);
	    // 개인의 아이디 가져와서 innerText 시키기
	    const id = $(this).closest('.mem_personal').find('.team_mem_nickname').data('id');
	    $('.mate_review_profile .user_id').text(id);
	    // 개인의 레벨 가져와서 innerText 시키기
	    const level = $(this).closest('.mem_personal').find('.team_mem_nickname').data('level');
	    let imgSrc = '';
	    
	    if(level == 1){
			imgSrc = `../images/level1.png`;
		} else if(level == 2){
			imgSrc = `../images/level2.png`;
		} else if(level == 3){
			imgSrc = `../images/level3.png`;
		} else if(level == 4){
			imgSrc = `../images/level4.png`;
		} else if(level == 5){
			imgSrc = `../images/level5.png`;
		}
	    const imgTag = `<img id="level_pic" src="${imgSrc}" height="20" width="20">`;
	     $('.mate_review_profile .user_level').html(imgTag);
	    
	    // 개인의 사진 가져와서 setAttribute 시키기
	    const profileImage = $(this).closest('.mem_personal').find('.team_mem_profile_img');
	    const imageUrl = profileImage.attr('src');
	    $('.mate_review_profile .profile_image').attr('src', imageUrl);
	    
	    const mr_receiver = $(this).data('mem-num');
	    $('#mr_receiver').val(mr_receiver);
	    const team_num = $(this).data('team-num');
	    $('#team_num').val(team_num);
	    modalOn();
	});

	/* close-btn을 클릭하면 modal off 함수가 호출된다*/
	$('#close-btn, .mate_review_close').click(function() {
		 modalOff(); // 모달창 닫기 함수 호출
		 $('#mr_content').val('');
	});

	mate_review.click(function(e) {
	    if ($(e.target).is(mate_review)) {
	        modalOff();
	    }
	});
	
	
	for (let i = 1; i <= 5; i++) {
	    $(`#star${i}`).click(function() {
	        for (let j = 1; j <= i; j++) {
	            const star = $(`#star${j}`);
	            star.attr('src', `../images/cje/star_yes.png`);
	        }
	        for (let j = i + 1; j <= 5; j++) {
	            const star = $(`#star${j}`);
	            star.attr('src', `../images/cje/star_no.png`);
	        }
	    });
	}

});
