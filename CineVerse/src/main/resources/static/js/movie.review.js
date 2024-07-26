$(document).ready(function() {
	let rowCount = 10;
	let currentPage = 1;
	let sortOption = "latest"; // 기본 정렬 옵션

	// 초기 리뷰 목록 로드
	loadReviews(currentPage, sortOption);

	// 더보기 버튼 클릭 이벤트
	$(".paging-button input").click(function() {
		loadReviews(++currentPage, sortOption);
	});

	// 별점 클릭 이벤트
	$(".star-rating .star").click(function() {
		var rating = $(this).data("value");
		$("#mr_grade").val(rating);
		$(".review-choice").text("별점: " + rating + "점");

		// 별점 이미지 변경
		$(".star-rating .star img").each(function() {
			if ($(this).parent().data("value") <= rating) {
				$(this).attr("src", "../images/cje/star_yes.png"); // 노란 별 이미지 경로로 변경
			} else {
				$(this).attr("src", "../images/cje/star_no.png"); // 흰색 별 이미지 경로로 변경
			}
		});
	});

	// 마우스 오버 이벤트
	$(".star-rating .star").mouseover(function() {
		var rating = $(this).data("value");

		// 별점 이미지 임시 변경
		$(".star-rating .star img").each(function() {
			if ($(this).parent().data("value") <= rating) {
				$(this).attr("src", "../images/cje/star_yes.png"); // 노란 별 이미지 경로로 변경
			} else {
				$(this).attr("src", "../images/cje/star_no.png"); // 흰색 별 이미지 경로로 변경
			}
		});
	});

	// 마우스 아웃 이벤트
	$(".star-rating .star").mouseout(function() {
		var rating = $("#mr_grade").val();

		// 별점 이미지 원래 상태로 복원
		$(".star-rating .star img").each(function() {
			if ($(this).parent().data("value") <= rating) {
				$(this).attr("src", "../images/cje/star_yes.png"); // 노란 별 이미지 경로로 변경
			} else {
				$(this).attr("src", "../images/cje/star_no.png"); // 흰색 별 이미지 경로로 변경
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
				if (param.result == 'logout') {
					alert('로그인해야 리뷰를 작성할 수 있습니다.');
				} else if (param.result === "success") {
					// 폼 초기화
					initForm();
					// 리뷰 작성 시 성공하면 새로 삽입한 글을 포함해서 첫 번째 페이지의 게시글들을 다시 호출함
					currentPage = 1;
					loadReviews(currentPage, sortOption);
				} else {
					alert("리뷰 등록에 실패했습니다.");
				}
			},
			error: function(xhr, status, error) {
				console.error("Error occurred: ", status, error); // 오류 메시지 출력
				alert('네트워크 오류 (리뷰등록)');
			}
		});
	});

	// 리뷰 작성 폼 초기화
	function initForm() {
		$('textarea').val('');
		$('#review_first .letter-count').text('300/300');
	}

	// 리뷰 수 표시 함수
	function displayReviewCount(count) {
		$('#output_mrcount').text(count);
	}

	// 추천순, 최신순 클릭 이벤트
	$("#recommendation").click(function() {
		$(".sort-option").removeClass("active");
		$(this).addClass("active");
		sortOption = "recommendation";
		currentPage = 1;
		loadReviews(currentPage, sortOption);
	});

	$("#latest").click(function() {
		$(".sort-option").removeClass("active");
		$(this).addClass("active");
		sortOption = "latest";
		currentPage = 1;
		loadReviews(currentPage, sortOption);
	});

	// 리뷰 목록 로드 함수
	function loadReviews(pageNum, order) {
		var m_code = $("#m_code").val();
		$.ajax({
			type: "GET",
			url: "listReview",
			data: {
				m_code: m_code,
				pageNum: pageNum,
				rowCount: rowCount,
				order: order // 정렬 옵션 추가
			},
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

				// 리뷰 수 읽어오기
				displayReviewCount(param.count);

				// 리뷰 목록 작업
				$(param.list).each(function(index, item) {
					if (index > 0) $('#output').append('');

					let output = '<div class="item">';
					output += '     <div class="detail-info">';
					output += '        <div class="user_profile_image">';
					output += '			<img src="../myPage/viewProfile?mem_num=' + item.mem_num + '" width="30" height="30" class="my-photo">';
					output += '        </div>';
					output += '        <div class="user_idOrname">';

					if (item.mem_nickname) {
						output += item.mem_nickname;
					} else {
						output += item.mem_id;
					}
					output += '        </div>';
					output += '     <div class="delete-review">';
					if (param.user_num === item.mem_num) {
						output += '  <input type="button" data-num="' + item.mr_num + '" value="X" class="delete-btn">';
					}
					// 드롭다운 메뉴 추가
					output += '     <div class="dropdown">';
					output += '        <button class="dropdown-toggle"></button>';
					output += '        <div class="dropdown-menu">';
					output += '          <div href="#" class="report-spoiler" data-num="' + item.mr_num + '"><img src="https://img.cgv.co.kr/R2014/images/point/ico_spoiler.png" width="13">스포일러 신고</div>';
					output += '          <div href="#" class="report-abuse" data-num="' + item.mr_num + '"><img src="https://img.cgv.co.kr/R2014/images/point/ico_swearword.png" width="13">욕설/비방 신고</div>';
					output += '        </div>';
					output += '     </div>';
					output += '     </div>';

					output += '     </div>';
					output += '     <div class="sub-item">';

					// 별점 표시
					output += '<div class="rating">';
					for (let i = 1; i <= 5; i++) {
						if (i <= item.mr_grade) {
							output += '<img src="../images/cje/star_yes.png" width="16" height="16">';
						} else {
							output += '<img src="../images/cje/star_no.png" width="16" height="16">';
						}
					}
					output += '</div>';

					if (item.mr_spoiler) {
						output += '<div class="spoiler">';
						output += '    <p class="spoiler-content">' + item.mr_content.replace(/\r\n/g, '<br>') + '</p>';
						output += '    <button class="show-spoiler"></button>';
						output += '</div>';
					} else {
						output += '    <p class="mr-review-content">' + item.mr_content.replace(/\r\n/g, '<br>') + '</p></div>';
					}

					// 좋아요 시작
					if (item.mr_click_num == 0 || param.user_num !== item.mr_click_num) {
						output += '<div class="review_last">';
						output += '<div class="review_fav">';
						output += '<img class="output_reiv" src="../images/like01.png" data-num="' + item.mr_num + '">';
						output += '<span class="output_rvcount">' + item.review_cnt + '</span>';
						output += '</div>';
						output += '<div class="user_re_day">';
						output += item.mr_regdate;
						output += '</div>';
						output += '</div>';
					} else {
						output += '<div class="review_last">';
						output += '<div class="review_fav">';
						output += '<img class="output_reiv" src="../images/like02.png" data-num="' + item.mr_num + '">';
						output += '<span class="output_rvcount">' + item.review_cnt + '</span>';
						output += '</div>';
						output += '<div class="user_re_day">';
						output += item.mr_regdate;
						output += '</div>';
						output += '</div>';
					}
					// 좋아요 끝


					$('#output').append(output);
				});

				// 더보기 버튼 표시 여부 결정
				if (currentPage * rowCount >= count) {
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
    // 리뷰 신고 접수
    function reportReview(mr_num, rr_type) {
        $.ajax({
            type: "POST",
            url: "reportReview",
            data: {
                mr_num: mr_num,
                rr_type: rr_type
            },
            dataType: 'json',
            success: function(param) {
                if (param.result === 'logout') {
                    alert('로그인 후 이용해주세요.');
                } else if (param.result === 'success') {
                    alert(rr_type + ' 신고가 접수되었습니다.');
                } else {
                    alert('신고 처리 중 오류가 발생했습니다.');
                }
            },
            error: function(xhr, status, error) {
                console.error("Error occurred: ", status, error);
                alert('네트워크 오류로 신고를 처리할 수 없습니다.');
            }
        });
    }
	// 스포일러 신고 접수 버튼(예시로 버튼 작동하는지 넣어둠})
	$(document).on('click', '.report-spoiler', function(e) {
		e.preventDefault();
		var mr_num = $(this).data('num');
		if (confirm('정말로 스포일러 신고를 하시겠습니까?')) {
			reportReview(mr_num, '스포일러');
		}
	});
	// 욕설 비방 신고 접수 버튼 (예시로 버튼 작동하는지 넣어둠)
	$(document).on('click', '.report-abuse', function(e) {
		e.preventDefault();
		var mr_num = $(this).data('num');
		if (confirm('정말로 욕설/비방 신고를 하시겠습니까?')) {
			reportReview(mr_num, '욕설/비방');
		}
	});
	// 드롭다운 메뉴
	$(document).on('click', '.dropdown-toggle', function(e) {
		e.stopPropagation();
		var menu = $(this).next('.dropdown-menu');
		$('.dropdown-menu').not(menu).hide();
		menu.toggle();
	});

	// 드롭다운 메뉴 닫기
	$(document).on('click', function() {
		$('.dropdown-menu').hide();
	});

	// 드롭다운 메뉴 닫기
	$(document).on('click', '.dropdown-menu', function(e) {
		e.stopPropagation();
	});


	// 리뷰 목록 불러오기 버튼 클릭 이벤트
	$('#loadComments').click(function() {
		selectList(1);
	});

	// 스포일러 보기 버튼 클릭 이벤트
	$(document).on('click', '.show-spoiler', function() {
		$(this).siblings('.spoiler-content').css('filter', 'none'); // 블러 제거
		$(this).remove(); // 버튼 제거
	});

	// 리뷰수 표시
	function displayReviewCount(count) {
		let output;
		if (count > 0) {
			output = count;
		} else {
			output = '0';
		}
		// 문서 객체에 추가
		$('#output_mrcount').text(output);
	};
	/*===================
		리뷰 삭제
	===================*/
	//위에서 만들었던 class=delete-btn을 클릭했을 시
	$(document).on('click', '.delete-btn', function() {
		//리뷰 번호
		let mr_num = $(this).attr('data-num');
		//서버와 통신
		$.ajax({
			url: 'deleteReview',
			type: 'post',
			data: { mr_num: mr_num },
			dataType: 'json',
			success: function(param) {
				if (param.result == 'logout') {
					alert('로그인해야 삭제할 수 있습니다.');
				} else if (param.result == 'success') {
					alert('삭제완료');
					loadReviews(currentPage, sortOption);
				} else if (param.result == 'wrongAccess') {
					alert('타인의 글을 삭제할 수 없습니다');
				} else {
					alert('리뷰 삭제 오류 발생');
				}
			},
			error: function() {
				alert('네트워크 오류 발생');
			}
		});
	});
	/* ========================================================================
 * 리뷰 좋아요 등록
 * ======================================================================== */
	$(document).on('click', '.output_reiv', function() {
		let heart = $(this);
		$.ajax({
			url: 'writeReFav',
			type: 'post',
			data: { mr_num: heart.attr('data-num') },
			dataType: 'json',
			success: function(param) {
				if (param.result == 'logout') {
					alert('로그인 후 좋아요를 눌러주세요!');
				} else if (param.result == 'success') {
					let output;
					if (param.status == 'noFav') {
						output = '../images/like01.png';
					} else {
						output = '../images/like02.png';
					}
					//문서 객체에 추가
					heart.attr('src', output);
					heart.parent().find('.output_rvcount').text(param.count);
				} else {
					alert('리뷰 좋아요 등록/삭제 오류');
				}
			},
			error: function() {
				alert('네트워크 오류!');
			}
		});
	});
	/* ========================================================================
	 * 초기 데이터(목록) 호출
	 * ======================================================================== */
	loadReviews(currentPage, sortOption);
});
