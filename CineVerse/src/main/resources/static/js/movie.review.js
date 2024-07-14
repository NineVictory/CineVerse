$(function() {
    function selectMovieList(pageNum) {
        $.ajax({
            url: '/movie/movieDetail/getReviews',
            type: 'post',
            data: { page: pageNum, m_code: $('#m_code').val() },
            dataType: 'json',
            success: function(data) {
                if (data.result === 'success') {
                    displayReviews(data.reviews);
                } else {
                    alert('리뷰 목록을 불러오는 데 실패했습니다.');
                }
            },
            error: function() {
                alert('네트워크 오류 발생');
            }
        });
    }

    function displayReviews(reviews) {
        let html = '';
        reviews.forEach(function(review) {
            let content = review.mr_content;
            if (review.mr_spoiler === 2) {
                content = `<span class="spoiler">스포일러가 포함된 리뷰입니다. <button onclick="showSpoiler(this)">보기</button></span>`;
            }
            html += `<div class="review">${content}</div>`;
        });
        $('#review_list').html(html);
    }

    $('#mr_form').submit(function(event) {
        if ($('#mr_content').val().trim() === '') {
            alert('내용을 입력하세요');
            $('#mr_content').val('').focus();
            return false;
        }

        let form_data = $(this).serialize();
        console.log(form_data);

        $.ajax({
            url: '/movie/movieDetail/addReview',
            type: 'post',
            data: form_data,
            dataType: 'json',
            success: function(param) {
                if (param.result === 'logout') {
                    alert('로그인해야 작성할 수 있습니다.');
                } else if (param.result === 'notBooked') {
                    alert('영화를 예매한 경우에만 댓글을 작성할 수 있습니다.');
                } else if (param.result === 'success') {
                    initForm();
                    selectMovieList(1);
                } else {
                    alert('리뷰 등록 오류 발생');
                }
            },
            error: function() {
                alert('네트워크 오류 발생');
            }
        });

        event.preventDefault();
    });

    function initForm() {
        $('textarea').val('');
        $('#review_first .letter-count').text('300/300');
    }

    window.showSpoiler = function(button) {
        const spoilerContent = $(button).closest('.spoiler').text().replace('스포일러가 포함된 리뷰입니다. 보기', '');
        $(button).closest('.spoiler').replaceWith(spoilerContent);
    }

    selectMovieList(1);
});



/*$(function(){
	let rowCount = 10;
	let currentPage;
	let count;
	
	===================
		리뷰 목록
	===================
	//리뷰 목록
	function selectMovieList(pageNum){
		
	}
	===================
		리뷰 등록
	===================
	//리뷰 등록
	$('#mr_form').submit(function(event){
		if($('#mr_content').val().trim()==''){
			alert('내용을 입력하세요');
			$('#mr_content').val('').focus();
			return false;
		}
		
		let form_data = $(this).serialize();
		console.log(form_data); //alert 창이 아닌 콘솔(console)창으로 띄우고자함.
		
		//서버와 통신
		$.ajax({
			url:'movieDetail',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 작성할 수 있습니다.');
				} else if(param.result == 'notBooked'){
					alert('영화를 예매한 경우에만 댓글을 작성할 수 있습니다.');
				} else if(param.result == 'success'){
					//폼 초기화
					initForm();
					//리뷰 작성시 성공하면 새로 삽입한 글을 포함해서 
					//첫번째 페이지의 게시글들을 다시 호출함
					selectMovieList(1);
				} else {
				    alert('리뷰 등록 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
		
		//폼 기본 이벤트 제거 (submit하지 않게 하려고)
		event.preventDefault();
	});
	
	//리뷰 작성 폼 초기화
	function initForm(){
		$('textarea').val('');
		$('#review_first .letter-count').text('300/300');
	}
	
	===================
		리뷰 수정
	===================
	
	===================
		리뷰(답글) 등록, 수정 공통
	===================
	
	===================
		리뷰 삭제
	===================
	
	===================
		리뷰수 표시
	===================
	
	===================
		리뷰수 좋아요 등록
	===================
	
	===================
		리뷰수 좋아요 표시
	===================
	
	===================
		초기 데이터 호출
	===================
	selectMovieList(1);
});
*/