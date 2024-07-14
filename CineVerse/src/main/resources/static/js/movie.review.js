$(function() {
    let rowCount = 10;
    let currentPage = 1;

    // 리뷰 목록
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

    // 리뷰 목록 표시
    function displayReviews(reviews) {
        let html = '';
        reviews.forEach(function(review) {
            if (review.mr_spoiler === 2) {
                html += `<div class="review">
                            <button class="show-spoiler">스포일러 보기</button>
                            <span class="spoiler-content" style="display:none;">${review.mr_content}</span>
                         </div>`;
            } else {
                html += `<div class="review">${review.mr_content}</div>`;
            }
        });
        $('#review_list').html(html);

        $('.show-spoiler').click(function() {
            $(this).next('.spoiler-content').toggle();
        });
    }

    // 리뷰 등록
    $('#mr_form').submit(function(event) {
        if ($('#mr_content').val().trim() === '') {
            alert('내용을 입력하세요');
            $('#mr_content').val('').focus();
            return false;
        }

        let form_data = $(this).serialize();

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

    // 리뷰 작성 폼 초기화
    function initForm() {
        $('textarea').val('');
        $('#review_first .letter-count').text('300/300');
    }

    selectMovieList(1);
});
