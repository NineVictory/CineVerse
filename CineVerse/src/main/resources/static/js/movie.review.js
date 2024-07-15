$(document).ready(function() {
    // 별점 클릭 이벤트
    $(".star-rating .star").click(function() {
        var rating = $(this).data("value");
        $("#mr_grade").val(rating);
        $(".review-choice").text("별점: " + rating + "점");
                $(".star-rating .star").each(function() {
            if ($(this).data("value") <= rating) {
                $(this).addClass("selected");
            } else {
                $(this).removeClass("selected");
            }
        });

 });

    // 리뷰 작성 폼 제출 이벤트
    $("#mr_form").submit(function(event) {
        event.preventDefault();
        var formData = $(this).serialize();
        $.ajax({
            type: "POST",
            url: "/movie/writeReview",
            data: formData,
            success: function(response) {
                if (response === "success") {
                    alert("리뷰가 성공적으로 등록되었습니다.");
                    location.reload();
                } else {
                    alert("리뷰 등록에 실패했습니다.");
                }
            }
        });
    });

    // 추천순, 최신순 클릭 이벤트
    $("#recommendation").click(function() {
        loadReviews("recommendation");
    });

    $("#latest").click(function() {
        loadReviews("latest");
    });

    function loadReviews(order) {
        var m_code = $("#m_code").val();
        $.ajax({
            type: "GET",
            url: "/movie/reviews",
            data: { m_code: m_code, order: order },
            success: function(data) {
                $("#review_list").html(data);
            }
        });
    }
    
   /*===================
		댓글(답글) 등록, 수정 공통
	===================*/
	//textarea에 내용 입력시 글자수 체크
	$(document).on('keyup','textarea',function(){
		//입력한 글자수 구하기
		let inputLength = $(this).val().length;
		
		if(inputLength>300){//300자를 넘어선 경우
			$(this).val($(this).val().substring(0,300));
		}else{//300자 이하인경우
			//남은 글자수 구하기
			let remain = 300 - inputLength;
			remain +='/300';
			if($(this).attr('id')=='mr_content'){
				//댓글 등록 폼 글자수
				$('#re_first .letter-count').text(remain);
			}else if($(this).attr('id')=='m_mre_content'){
				//댓글 수정 폼 글자수
				$('#m_mre_first .letter-count').text(remain);
			}else if($(this).attr('id')=='m_resp_content'){
				//답글 등록 폼 글자수
				$('#m_resp_first .m_letter-count').text(remain);
			}else{
				//답글 수정 폼 글자수
				$('#m_mresp_first .m_letter-count').text(remain);
			}
		}
	});
});
