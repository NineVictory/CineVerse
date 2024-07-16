$(document).ready(function() {
    let rowCount = 10;
    let currentPage;
    let count;

    // 별점 클릭 이벤트
    $(".star-rating .star").click(function() {
        var rating = $(this).data("value");
        $("#mr_grade").val(rating);
        $(".review-choice").text("별점: " + rating + "점");

        // 별점 이미지 변경
        $(".star-rating .star img").each(function() {
            if ($(this).parent().data("value") <= rating) {
                $(this).attr("src", "../images/ksh/star_yellow.png"); // 노란 별 이미지 경로로 변경
            } else {
                $(this).attr("src", "../images/ksh/star.png"); // 흰색 별 이미지 경로로 변경
            }
        });
    });

    // 마우스 오버 이벤트
    $(".star-rating .star").mouseover(function() {
        var rating = $(this).data("value");

        // 별점 이미지 임시 변경
        $(".star-rating .star img").each(function() {
            if ($(this).parent().data("value") <= rating) {
                $(this).attr("src", "../images/ksh/star_yellow.png"); // 노란 별 이미지 경로로 변경
            } else {
                $(this).attr("src", "../images/ksh/star.png"); // 흰색 별 이미지 경로로 변경
            }
        });
    });

    // 마우스 아웃 이벤트
    $(".star-rating .star").mouseout(function() {
        var rating = $("#mr_grade").val();

        // 별점 이미지 원래 상태로 복원
        $(".star-rating .star img").each(function() {
            if ($(this).parent().data("value") <= rating) {
                $(this).attr("src", "../images/ksh/star_yellow.png"); // 노란 별 이미지 경로로 변경
            } else {
                $(this).attr("src", "../images/ksh/star.png"); // 흰색 별 이미지 경로로 변경
            }
        });
    });

    // 리뷰 작성 폼 제출 이벤트
    $("#mr_form").submit(function(event) {
        event.preventDefault();
        
        var rating = $("#mr_grade").val();
        if (rating === "" || rating === null) {
            alert("별점을 선택해 주세요");
            return false;
        }
        
        if ($('#mr_content').val().trim() == '') {
            alert('내용을 입력하세요');
            $('#mr_content').val('').focus();
            return false;
        }
        
        var formData = $(this).serialize();
        $.ajax({
            type: "post",
            url: "writeReview", // 절대 경로 대신 상대 경로 사용
            data: formData,
            dataType: 'json',
            success: function(param) {
				if(param.result=='logout'){
					alert('로그인해야 답글을 작성할 수 있습니다.');
				}else if (param.result === "success") {
                    // 폼 초기화
                    initForm();
                    // 댓글 작성 시 성공하면 새로 삽입한 글을 포함해서 첫 번째 페이지의 게시글들을 다시 호출함
                    selectList(1);
                } else {
                    alert("리뷰 등록에 실패했습니다.");
                }
            },
            error: function(xhr, status, error) {
				console.error("Error occurred: ", status, error); // 오류 메시지 출력
				alert('네트워크 오류 (댓글등록)');
			}
        });
    });

    // 리뷰 작성 폼 초기화
    function initForm() {
        $('textarea').val('');
        $('#review_first .letter-count').text('300/300');
    }

    // 댓글 수 표시 함수
    function displayReviewCount(count) {
        $('#output_mrcount').text('댓글수: ' + count);
    }

    // 추천순, 최신순 클릭 이벤트
    $("#recommendation").click(function() {
        $(".sort-option").removeClass("active");
        $(this).addClass("active");
        loadReviews("recommendation");
    });

    $("#latest").click(function() {
        $(".sort-option").removeClass("active");
        $(this).addClass("active");
        loadReviews("latest");
    });

    function loadReviews(order) {
        var m_code = $("#m_code").val();
        $.ajax({
            type: "GET",
            url: "reviews", // 절대 경로 대신 상대 경로 사용
            data: { m_code: m_code, order: order },
            dataType: 'json',
            success: function(data) {
                $("#review_list").html(data);
            }
        });
    }

    // textarea에 내용 입력 시 글자수 체크
    $(document).on('keyup', 'textarea', function() {
        // 입력한 글자수 구하기
        let inputLength = $(this).val().length;

        if (inputLength > 300) { // 300자를 넘어선 경우
            $(this).val($(this).val().substring(0, 300));
        } else { // 300자 이하인 경우
            // 남은 글자수 구하기
            let remain = 300 - inputLength;
            remain += '/300';
            
            if ($(this).attr('id') == 'mr_content') {
                // 댓글 등록 폼 글자수
                $('#review_first .letter-count').text(remain);
            } else if ($(this).attr('id') == 'm_mre_content') {
                // 댓글 수정 폼 글자수
                $('#m_mre_first .letter-count').text(remain);
            } else if ($(this).attr('id') == 'm_resp_content') {
                // 답글 등록 폼 글자수
                $('#m_resp_first .m_letter-count').text(remain);
            } else {
                // 답글 수정 폼 글자수
                $('#m_mresp_first .m_letter-count').text(remain);
            }
        }
    });
    
    // 댓글 목록
    function selectList(pageNum){
        currentPage = pageNum;

        // 서버와 통신
        $.ajax({
            url: 'listReview',
            type: 'get',
            data: { m_code: $('#m_code').val(), pageNum: pageNum, rowCount: rowCount },
            dataType: 'json',
            beforeSend: function() {
                $('#loading').show(); // 로딩 이미지 표시
            },
            complete: function() {
                $('#loading').hide(); // 로딩 이미지 숨김
            },
            success: function(param) {
                console.log(param); // 서버 응답 확인

                count = param.count;

                if (pageNum == 1) {
                    $('#output').empty(); // 처음 호출시는 해당 ID의 div의 내부 내용물을 제거
                }

                // 댓글 수 읽어오기
                displayReviewCount(param.count);

                // 댓글 목록 작업
                $(param.list).each(function(index, item) {
                    if (index > 0) $('#output').append('<hr size="1" width="100%">');

                    let output = '<div class="item">';
                    output += '     <ul class="detail-info">';
                    output += '        <li>';
                    output += '         <img src="../member/viewProfile?mem_num='+ item.mem_num +'" width="40" height="40" class="my-photo">';
                    output += '        </li>';
                    output += '        <li>';

                    if (item.mem_nickname) {
                        output += item.mem_nickname + '<br>';
                    } else {
                        output += item.mem_id + '<br>';
                    }
                    if (item.re_mdate) {
                        output += '<span class="mr-modify-date">최근 수정일 : ' + item.mr_regdate + '</span>';
                    } else {
                        output += '<span class="mr-modify-date">등록일 : ' + item.mr_regdate + '</span>';
                    }
                    output += '        </li>';
                    output += '     </ul>';
                    output += '     <div class="sub-item">';

                    if (item.mr_spoiler) {
                        output += '<div class="spoiler">';
                        output += '    <p class="spoiler-content">' + item.mr_content.replace(/\r\n/g, '<br>') + '</p>';
                        output += '    <button class="show-spoiler"></button>';
                        output += '</div>';
                    } else {
                        output += '    <p>' + item.mr_content.replace(/\r\n/g, '<br>') + '</p>';
                    }

                    // 좋아요 시작
                    if (item.mr_click_num == 0 || param.user_num !== item.mr_click_num) {
                        output += ' <img class="output_reiv" src="../images/like01.png" data-num="'+item.mr_num+'"> <span class="output_rvcount">'+item.review_cnt+'</span>';
                    } else {
                        output += ' <img class="output_reiv" src="../images/like02.png" data-num="'+item.mr_num+'"> <span class="output_rvcount">'+item.review_cnt+'</span>';
                    }
                    // 좋아요 끝

                    /* if (param.user_num === item.mem_num) {
                        output += '  <input type="button" data-num="'+item.mr_num+'" value="수정" class="modify-btn">';
                        output += '  <input type="button" data-num="'+item.mr_num+'" value="삭제" class="delete-btn">';
                    } */

                    $('#output').append(output);
                });

                // 페이징 버튼 처리
                if (currentPage >= Math.ceil(count / rowCount)) {
                    $('.paging-button').hide();
                } else {
                    $('.paging-button').show();
                }
            },
            error: function() {
                alert('네트워크 오류');
            }
        });
    }

    // 댓글 목록 불러오기 버튼 클릭 이벤트
    $('#loadComments').click(function() {
        selectList(1);
    });
    
    // 스포일러 보기 버튼 클릭 이벤트
    $(document).on('click', '.show-spoiler', function() {
        $(this).siblings('.spoiler-content').css('filter', 'none'); // 블러 제거
        $(this).remove(); // 버튼 제거
    });
    
    // 댓글수 표시
    function displayReviewCount(count){
        let output;
        if(count > 0){
            output = '댓글수('+count+')';
        } else {
            output = '댓글수(0)';
        }           
        // 문서 객체에 추가
        $('#output_mrcount').text(output);
    }
    /* ========================================================================
	 * 초기 데이터(목록) 호출
	 * ======================================================================== */		
	selectList(1);
});
