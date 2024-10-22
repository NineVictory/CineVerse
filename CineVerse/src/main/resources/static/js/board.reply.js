$(function() {
	let rowCount = 10;
	let currentPage;
	let count;

	/* ========================================================================
	 * 댓글 목록
	 * ======================================================================== */
	// 댓글 목록을 불러오는 함수
	function selectList(pageNum) {
		currentPage = pageNum;

		// 서버와 통신
		$.ajax({
			url: 'listComment',
			type: 'get',
			data: { cb_num: $('#cb_num').val(), pageNum: pageNum, rowCount: rowCount },
			dataType: 'json',
			beforeSend: function() {
				$('#loading').show(); // 로딩 이미지 표시
			},
			complete: function() {
				$('#loading').hide(); // 로딩 이미지 숨김
			},
			success: function(param) {
				count = param.count;

				if (pageNum == 1) {
					$('#output').empty(); // 처음 호출 시 해당 ID의 div의 내부 내용물을 제거
				}

				// 댓글 수 표시
				displayCommentCount(param.count);

				// 각 댓글에 대한 처리
				$(param.list).each(function(index, item) {
					if (index > 0) {
						$('#output').append('<hr size="1" width="100%" class="comment-hr">'); // 다음 댓글부터는 수평선 추가
					}
				

					let output = '<div class="cc-all-container">';
					output += '<div class="flexbox-p comment-container">';
					
					
					// 작성자 정보 및 수정/삭제 버튼
					output += '<div class="flexbox-h side writer-btns">';
					output += '<div class="flexbox-h cc-writer-info">';
					output += '<img src="../myPage/viewProfile?mem_num=' + item.mem_num + '" width="30" height="30" class="my-photo">';
					let name = '';
					if (item.mem_nickname) {
						output += item.mem_nickname;
						name = item.mem_nickname;
					} else {
						output += item.mem_id;
						name = item.mem_id;
					}
					output += '</div>';
					
						
					if (param.user_num === item.mem_num) {
						// 로그인 한 회원번호와 댓글 작성자 회원번호가 같으면 수정/삭제 버튼 표시
						output += '<div class="cc-btn">';
						output += '<span class="cc-cbtn"><img class="menu-img" src="../images/kbm/menu_vertical.png" height="18"></span>';
						output += '<ul class="cc-btn-hide">';
						if(item.cc_report < 5){
						output += '<li><a href="" class="cc-modify-btn" data-num="' + item.cc_num + '" data-memnum="' + item.mem_num + '" data-name="' +name+ '">수정</a></li>';
						}
						output += '<li><a href="" class="cc-delete-btn" data-num="' + item.cc_num + '">삭제</a></li>';
						output += '</ul>';
						output += '</div>';
					}else{//댓글신고버튼
						if(param.user_num != null && item.cc_report < 5){
						output += '<span class="comment-report" data-num="' +item.cc_num+ '" data-memnum="' +param.user_num+ '" data-content="' +item.cc_content.replace(/\r\n/g, '<br>')+ '">신고</span>'
						}
					}
					
					
					output += '</div>';

					output += '</div>';
					output += '<div class="sub-item">';
					if(item.cc_report < 5){
					output += '<div class="cc-content">' + item.cc_content.replace(/\r\n/g, '<br>') + '</div>';

					// 수정일 표시
					if (item.cc_modify_date) {
						output += '<span class="cc-modify-date">수정일 : ' + item.cc_modify_date + '</span>';
					} else {
						output += '<span class="cc-modify-date">' + item.cc_reg_date + '</span>';
					}
					output += '</div>';
					
					}else{
						output += '<div style="font-size:14px; font-weight:500;">정지된 댓글입니다.</div>';
					}
					output += '<div class="flexbox-h side">';
					
					if(item.cc_report < 5){
					// 답글 버튼
					output += '<div><input type="button" data-num="' + item.cc_num + '" data-parent="0" data-depth="0"  value="답글" class="response-btn"></div>';

					// 댓글좋아요 버튼
					
					if (item.click_num == 0 || param.user_num != item.click_num) {
						output += '<div class="cc-like-btn" data-num="' + item.cc_num + '"><img class="cc-like" src="../images/kbm/heart01.png" height="11">&nbsp;<span class="output-rfcount">' + item.refav_cnt + '</span></div>';
					} else {
						output += '<div class="cc-like-btn" data-num="' + item.cc_num + '"><img class="cc-like" src="../images/kbm/heart02.png" height="11">&nbsp;<span class="output-rfcount">' + item.refav_cnt + '</span></div>';
					}
					
					
					output += '</div>';
					}
				
					// 답글 목록 컨테이너
					output += '<div class="response-container">';
					// 여기에 답글 목록을 불러와서 추가하도록 처리
					output += '</div>';

					output += '</div>';
					output += '</div>';

					$('#output').append(output); // 문서 객체에 추가

					// 답글 목록 불러오기 함수 호출
					var responseContainer = $('.response-container:last');
					getListResponse(item.cc_num, responseContainer);

					// 답글이 있는 경우 보이기/숨기기 처리
					if (item.resp_cnt > 0) {
						responseContainer.show();
					} else {
						responseContainer.hide();
					}
				});

				// 메뉴 이미지 클릭 이벤트 처리
				$('#output').on('click', '.menu-img', function(event) {
					event.stopPropagation(); // 이벤트 전파 방지

					// 모든 버튼 숨기기
					$('.cc-btn-hide').removeClass('show');

					const btnContainer = $(this).closest('.cc-btn');
					if (btnContainer.length) {
						const menu = btnContainer.find('.cc-btn-hide');
						if (menu.length) {
							menu.toggleClass('show'); // 'show' 클래스를 토글하여 표시 여부 변경
						}
					}
				});

				// 문서 클릭 이벤트 처리
				$(document).on('click', function(event) {
					// 클릭한 요소가 .menu-img 또는 .cc-btn 내부가 아닌 경우
					if (!$(event.target).closest('.menu-img, .cc-btn').length) {
						// 모든 버튼 숨기기
						$('.cc-btn-hide').removeClass('show');
					}
				});

				// 페이지 버튼 처리
				if (currentPage >= Math.ceil(count / rowCount)) {
					$('.paging-button').hide(); // 다음 페이지가 없을 경우 버튼 숨기기
				} else {
					$('.paging-button').show(); // 다음 페이지가 있을 경우 버튼 표시
				}
			},
			error: function() {
				alert('네트워크 오류');
			}
		});
	}

	// 페이지 로딩 시 첫 번째 페이지의 댓글 목록 호출
	$(document).ready(function() {
		selectList(1);
	});

	/* ========================================================================
	 * 댓글 등록
	 * ======================================================================== */
	//댓글 등록
	$('#comment_form').submit(function(event) {
		if ($('#cc_content').val().trim() == '') {
			alert('내용을 입력하세요');
			$('#cc_content').val('').focus();
			return false;
		}

		let form_data = $(this).serialize();
		console.log(form_data);
		//서버와 통신
		$.ajax({
			url: 'writeComment',
			type: 'post',
			data: form_data,
			dataType: 'json',
			success: function(param) {
				if (param.result == 'logout') {
					alert('로그인해야 작성할 수 있습니다.');
				} else if (param.result == 'success') {
					//폼 초기화
					initForm();
					//댓글 작성이 성공하면 새로 삽입한 글을 포함해서 첫번째 페이지의 게시글들을 다시 호출함
					selectList(1);
				} else {
					alert('댓글 등록 오류 발생!');
				}
			},
			error: function() {
				alert('네트워크 오류!');
			}
		});
		//기본 이벤트 제거
		event.preventDefault();
	});
	//댓글 작성 폼 초기화
	function initForm() {
		$('textarea').val('');
	}

	/* ========================================================================
	 * 댓글 수정
	 * ======================================================================== */
	//댓글 수정 버튼 클릭시 수정폼 노출
	$(document).on('click', '.cc-modify-btn', function(event) {
		event.preventDefault();
		//댓글 번호
		let cc_num = $(this).attr('data-num');
		//댓글 내용
		let cc_content = $(this).closest('.cc-all-container').find('.cc-content').html().replace(/<br>/gi, '\r\n');
		let mem_num = $(this).attr('data-memnum');
		let name = $(this).attr('data-name');
		console.log(cc_num + ',' + mem_num);
		let modifyUI = '';
	/*	modifyUI += '	<div class="flexbox-p mcc-container">';
		modifyUI += '		<div>';

		modifyUI += '        <div class="flexbox-h side writer-btns">';
		modifyUI += '        		<div class="flexbox-h cc-writer-info">';
		modifyUI += '					<img src="../myPage/viewProfile?mem_num=' + mem_num + '" width="30" height="30" class="my-photo">';
		modifyUI += '					<span>' + name + '</span>';
		modifyUI += '				</div>';
		modifyUI += '		</div>';*/
		modifyUI += '		<div class="mcc-form-container">';
		modifyUI += '			<form id="mcc_form">';
		modifyUI += '  				<input type="hidden" name="cc_num" id="mcc_num" value="' + cc_num + '">';
		modifyUI += '   			<div class="text-con"><textarea name="cc_content" id="mcc_content" class="mcc-content">' + cc_content + '</textarea></div>';
		modifyUI += '  			 	<div id="mcc-btn" class="mcc-btn">';
		modifyUI += '     				<input type="submit" class="mcc-submit" value="수정">';
		modifyUI += '					<input type="button" class="cc-reset" value="취소">';
		modifyUI += '				</div>';
		modifyUI += '			</form>';
/*		modifyUI += '		</div>';
		modifyUI += '     </div>';*/
		modifyUI += '<hr size="1" width="100%" class="comment-hr">';
		modifyUI += '  </div>';


		//이전에 이미 수정하는 댓글이 있을 경우 수정버튼을 클릭하면
		//숨김 sub-item를 환원시키고 수정폼을 초기화함
		initModifyForm();
		//지금 클릭해서 수정하고자 하는 데이터는 감추기
		//(수정버튼을 감싸고 있는 div)
/*		$(this).closest('.comment-container').hide();
		$(this).closest('.cc-all-container').find('.response-btn').hide();
		$(this).closest('.cc-all-container').find('.response-container').show();*/
		$(this).closest('.cc-all-container').find('.cc-content').hide();
		$(this).closest('.cc-all-container').find('.cc-modify-date').hide();
		$(this).closest('.cc-all-container').find('.cc-btn').hide();
		$(this).closest('.cc-all-container').find('.response-btn').hide();
		$(this).closest('.cc-all-container').find('.cc-like-btn').hide();

		//수정폼을 수정하고자하는 데이터가 있는 div에 노출
		$(this).closest('.cc-all-container').find('.sub-item').prepend(modifyUI);

	});

	//수정폼에서 취소 버튼 클릭시 수정폼 초기화
	$(document).on('click', '.cc-reset', function() {
		initModifyForm();

	});

	//댓글 수정 폼 초기화
	function initModifyForm() {
/*		$('.comment-container').show();
		$('.mcc-container').remove();
		$('.response-btn').show();*/
		
		$('.cc-content').show();
		$('.cc-modify-date').show();
		$('.cc-btn').show();
		$('.response-btn').show();
		$('.cc-like-btn').show();
		$('.mcc-form-container').remove();
	}

	//댓글 수정
	$(document).on('submit', '#mcc_form', function(event) {
		let form = $(this);

		if ($('#mcc_content').val().trim() == '') {
			alert('내용을 입력하세요');
			$('#mcc_content').val('').focus();
			return false;
		}

		//폼에 입력한 데이터 반환
		let form_data = form.serialize();

		//서버와 통신
		$.ajax({
			url: 'updateComment',
			type: 'post',
			data: form_data,
			dataType: 'json',
			success: function(param) {
				if (param.result == 'logout') {
					alert('로그인해야 수정할 수 있습니다.');
				} else if (param.result == 'success') {
					let updatedContent = form.find('#mcc_content').val();
					form.closest('.cc-all-container').find('.cc-content').html(updatedContent.replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/\r\n/g, '<br>').replace(/\r/g, '<br>').replace(/\n/g, '<br>'));
					//등록일->수정일
					form.closest('.cc-all-container').find('.cc-modify-date').html(param.cc_modify_date);
					
					//수정폼 초기화
					initModifyForm();
				} else if (param.result == 'wrongAccess') {
					alert('타인의 글은 수정할 수 없습니다.');
				} else {
					alert('댓글 수정 오류 발생');
				}
			},
			error: function() {
				alert('네크워크 오류 발생');
			}
		});
		//기본 이벤트 제거
		event.preventDefault();
	});

	/* ========================================================================
	 * 댓글 삭제
	 * ======================================================================== */
	$(document).on('click', '.cc-delete-btn', function() {
		//댓글 번호
		let cc_num = $(this).attr('data-num');

		let check = confirm('댓글을 삭제하시겠습니까?');

		if (check) {
			//서버와 통신
			$.ajax({
				url: '/board/deleteComment',
				type: 'post',
				data: { cc_num: cc_num },
				dataType: 'json',
				success: function(param) {
					if (param.result == 'logout') {
						alert('로그인해야 삭제할 수 있습니다.');
					} else if (param.result == 'success') {
						selectList(1);
					} else if (param.result == 'wrongAccess') {
						alert('타인의 글을 삭제할 수 없습니다.');
					} else {
						alert('댓글 삭제 오류 발생');
					}
				},
				error: function() {
					alert('네트워크 오류 발생');
				}
			});
		}
	});

	/* ========================================================================
	 * 댓글 좋아요 등록
	 * ======================================================================== */
	$(document).on('click', '.cc-like-btn', function() {
		let heart = $(this);
		$.ajax({
			url: 'writeReFav',
			type: 'post',
			data: { cc_num: heart.attr('data-num') },
			dataType: 'json',
			success: function(param) {
				if (param.result == 'logout') {
					alert('로그인 후 좋아요를 눌러주세요');
				} else if (param.result == 'success') {
					let output;
					if (param.status == 'noFav') {
						output = '../images/heart01.png';
					} else {
						output = '../images/heart02.png';
					}
					//문서 객체에 추가
					heart.find('img.cc-like').attr('src', output);
					heart.find('.output-rfcount').text(param.count);
				} else {
					alert('댓글 좋아요 등록/삭제 오류');
				}
			},
			error: function() {
				alert('네트워크 오류 발생');
			}
		});
	});
	

/*/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/
/*///////////////////////////////////////////  답글   ///////////////////////////////////////////////////////////////////////////*/
/*//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/



	/* ========================================================================
	 * 답글 등록
	 * ======================================================================== */
	//댓글의 답글 작성 버튼 클릭시 답글 작성 폼 노출
	$(document).on('click', '.response-btn', function() {
		var that = $(this);

		$.ajax({
			url: 'responseLoginCheck',
			type: 'get',
			dataType: 'json',
			success: function(param) {
				if (param.result == 'logout') {
					alert('로그인 후 답글 작성 가능합니다.');
				} else if (param.result = 'success') {
					var isOpen = that.hasClass('clicked-resp-btn');

					//모든 폼을 초기화
					initResponseForm();
					//클릭하면 답글 작성 버튼 배경색 추가, 답글 작성 폼 노출
					if (!isOpen) {
						// 클릭된 버튼이 아닌 경우
						that.addClass('clicked-resp-btn');

						//댓글 글번호
						let cc_num = that.attr('data-num');
						//부모 글번호
						let te_parent_num = that.attr('data-parent');
						let user_num = param.user_num;
						let name = param.name;
						//깊이
						let te_depth = that.attr('data-depth');
						console.log(cc_num + ', ' + te_parent_num);
						console.log(te_parent_num + ',' + te_depth);
						//답글 작성 폼 UI
						let responseUI = '<form id="resp_form">';
						responseUI += '<input type="hidden" name="cc_num" id="resp_num" value="' + cc_num + '">';
						responseUI += '<input type="hidden" name="te_parent_num" value="' + te_parent_num + '">';
						responseUI += '<input type="hidden" name="te_depth" value="' + te_depth + '">';
						responseUI += '<div class="flexbox-h cc-writer-info">';
						responseUI += '<img src="../myPage/viewProfile?mem_num=' + user_num + '" width="30" height="30" class="my-photo">';
						responseUI += '<span>' + name + '</span>';
						responseUI += '</div>';
						responseUI += '<div class="text-con"><textarea name="te_content" id="resp_content" class="mrep-content"></textarea></div>';
						responseUI += '<div id="resp_second" class="align-right">';
						responseUI += ' <input type="submit" value="등록" class="mcc-submit">';
						responseUI += ' <input type="button" value="취소" class="resp-reset">';
						responseUI += '</div>';
						responseUI += '</form>';

						//답글 작성폼을 답글을 작성하고자는 데이터가 있는 div에 노출
						that.closest('.side').next('.response-container').prepend(responseUI);
						that.closest('.side').next('.response-container').show();
					}

				} else {
					alert('답글 등록 로그인체크 오류');
				}
			},
			error: function() {
				alert('네트워크 발생 오류');
			}
		});
	});
	
	
	//답글의 답글 작성 버튼 클릭시 답글 작성 폼 노출
	$(document).on('click', '.response2-btn', function() {
		var that = $(this);

		$.ajax({
			url: 'responseLoginCheck',
			type: 'get',
			dataType: 'json',
			success: function(param) {
				if (param.result == 'logout') {
					alert('로그인 후 답글 작성 가능합니다.');
				} else if (param.result = 'success') {
					var isOpen = that.hasClass('clicked-resp-btn');

					//모든 폼을 초기화
					initResponseForm();
					
					
					//클릭하면 답글 작성 버튼 배경색 추가, 답글 작성 폼 노출
					if (!isOpen) {
						// 클릭된 버튼이 아닌 경우
						that.addClass('clicked-resp-btn');

						//댓글 글번호
						let cc_num = that.attr('data-num');
						//부모 글번호
						let te_parent_num = that.attr('data-parent');
						let user_num = param.user_num;
						let name = param.name;
						//깊이
						let te_depth = that.attr('data-depth');
						console.log(cc_num + ', ' + te_parent_num);
						console.log(te_parent_num + ',' + te_depth);
						//답글 작성 폼 UI
						let responseUI = '<form id="resp_form">';
						responseUI += '<input type="hidden" name="cc_num" id="resp_num" value="' + cc_num + '">';
						responseUI += '<input type="hidden" name="te_parent_num" value="' + te_parent_num + '">';
						responseUI += '<input type="hidden" name="te_depth" value="' + te_depth + '">';
						responseUI += '<div class="flexbox-h cc-writer-info">';
						responseUI += '<img src="../myPage/viewProfile?mem_num=' + user_num + '" width="30" height="30" class="my-photo">';
						responseUI += '<span>' + name + '</span>';
						responseUI += '</div>';
						responseUI += '<div class="text-con"><textarea name="te_content" id="resp_content" class="mrep-content"></textarea></div>';
						responseUI += '<div id="resp_second" class="align-right">';
						responseUI += ' <input type="submit" value="등록" class="mcc-submit">';
						responseUI += ' <input type="button" value="취소" class="resp-reset">';
						responseUI += '</div>';
						responseUI += '</form>';

						//답글 작성폼을 답글을 작성하고자는 데이터가 있는 div에 노출
						that.closest('.resp-container-all').after(responseUI);

					}

				} else {
					alert('답글 등록 로그인체크 오류');
				}
			},
			error: function() {
				alert('네트워크 발생 오류');
			}
		});
	});
	

	// 답글 취소 버튼 클릭시 답글 폼 초기화
	$(document).on('click', '.resp-reset', function() {
		initResponseForm();
	})

	/*// 답글 작성 폼 초기화 하기
	function initResponseForm() {
		$('.response-btn,.response2-btn').show();
		$('#resp_form').remove();
	}*/

	//답글 등록
	$(document).on('submit', '#resp_form', function(event) {
		let resp_form = $(this);

		if ($('#resp_content').val().trim() == '') {
			alert('내용을 입력하세요');
			$('#resp_content').val('').focus();
			return false;
		}

		//폼에 입력한 데이터 반환
		let form_data = resp_form.serialize();
		let cc_num = resp_form.find('#resp_num').val();

		//서버와 통신
		$.ajax({
			url: 'writeResponse',
			type: 'post',
			data: form_data,
			dataType: 'json',
			success: function(param) {
				if (param.result == 'logout') {
					alert('로그인해야 답글을 작성할 수 있습니다.');
				} else if (param.result == 'success') {
					initResponseForm();

					/*//답글 개수
					if(resp_form.parent().attr('class')=='sub-item'){//답글을 최초 작성시에 .sub-item에 자식으로 form이 생성됨
						//답글을 처음 등록할 때 숨겨져 있는 버튼을 노출함
						resp_form.parent().find('div .rescontent-btn').show();
						resp_form.parent().find('div .rescontent-btn').attr('data-status',1);
						resp_form.parent().find('div .rescontent-btn').val('▼ 답글 ' + (Number(resp_form.parent().find('div .rescontent-btn').val().substring(5)) + 1));
					}else{//답글에 답글을 작성할 때
						resp_form.parents('.sub-item').find('div .rescontent-btn').val('▼ 답글 ' + (Number(resp_form.parents('.sub-item').find('div .rescontent-btn').val().substring(5)) + 1));
					}*/

					getListResponse(cc_num, resp_form.closest('.cc-all-container').find('.response-container'));
					selectList(1);

				} else {
					alert('답글 작성 오류 발생');
				}
			},
			error: function() {
				alert('네크워크 오류 발생');
			}
		});
		//기본 이벤트 제거
		event.preventDefault();

	});

	//답글 작성 폼 초기화
	function initResponseForm() {
		$('.response-btn,.response2-btn').removeClass('clicked-resp-btn')
		$('#resp_form').remove();

		// 답글 폼을 숨기기 전에 .response-container가 비어 있는지 확인하여 숨김 처리
	/*	var responseContainers = $('.response-container');
		responseContainers.each(function() {
			if ($(this).children().length == 0) {
				$(this).hide();
			}
		});*/
	}

	/* ========================================================================
	 * 답글 목록
	 * ======================================================================== */
	// getListResponse 함수
	function getListResponse(cc_num, responseContainer) {
		// 서버와 통신
		$.ajax({
			url: 'getListResp',
			type: 'get',
			data: { cc_num: cc_num },
			dataType: 'json',
			cache: false,
			success: function(param) {
				// responseContainer.find('.respitem').remove();
				responseContainer.empty();

				// 각 답글 항목 생성 및 출력
				$(param.list).each(function(index, item) {
					let output = '';

					// respitem 시작
					
					output += '<div class="resp-container-all">';
					output += '<div class="resp-container">';
					output += '<div class="respitem">';
					output += '<div class="resp-detail-info side">';
					
					output += '<div class="작성자">';
					output += '<img src="../myPage/viewProfile?mem_num=' + item.mem_num + '" width="30" height="30" class="my-photo">';
					let name = '';
					if (item.mem_nickname) {
						output += item.mem_nickname;
						name = item.mem_nickname;
					} else {
						output += item.mem_id;
						name = item.mem_id;
					}
					output += '</div>';

					
						
					// 답글 수정/삭제 버튼
					if (param.user_num == item.mem_num) {
						output += '<div class="cc-btn mhide">';
						output += '<span class="cc-cbtn"><img class="menu-img" src="../images/kbm/menu_vertical.png" height="18"></span>';
						output += '<ul class="cc-btn-hide">';
						if(item.rr_report < 5){
						output += '<li><a href="" class="resp-modify-btn" data-num="' + item.te_num + '" data-memnum="' +item.mem_num+ '" data-name="' +name+ '">수정</a></li>'; // 수정 버튼 데이터 수정
						}
						output += '<li><a href="" class="resp-delete-btn" data-num="' + item.te_num + '" data-rnum="'+item.cc_num+'" data-mem="'+item.mem_num+'" >삭제</a></li>'; // 삭제 버튼 데이터 수정
						output += '</ul>';
						output += '</div>';
					}else{//답글신고버튼
						if(param.user_num && item.rr_report < 5){
						output += '<span class="response-report" data-num="' +item.te_num+ '" data-memnum="' +param.user_num+ '" data-content="' +item.te_content.replace(/</g, '&lt;').replace(/>/g, '&gt;')+ '">신고</span>'
						}
					}
				
					output += '</div>'; // resp-detail-info 닫기
					output += '</div>'; 
					
					if(item.rr_report < 5){
					// 답글 내용과 작성일 출력
					output += '<div class="resp-sub-item">';
					output += '<div class="resp-item-main mhide">';
					
					
						
					if(item.te_parent_num>0){
                  		if(item.pnick_name){
                     		output += '<b>@' +item.pnick_name + ' &nbsp;</b>';
                  		}else{
                     		output += '<b>@' +item.parent_id + ' &nbsp;</b>';
                  		}
               		}	
					output += '<span class="te-content mhide">'+item.te_content.replace(/</g, '&lt;').replace(/>/g, '&gt;').replace() + '</span>';
					output += '</div>';
					output += '<div>';
					if (item.te_mdate) {
						output += '<span class="resp-modify-date mhide">수정일 ' + item.te_mdate + '</span>'; // 수정일 데이터 수정
					} else {
						output += '<span class="resp-modify-date mhide">' + item.te_date + '</span>'; // 작성일 데이터 수정
					}
					
					
					output += '</div>';
					output += '</div>'; // resp-sub-item 닫기
					}else{
						output += '<div style="font-size:14px; font-weight:500;">정지된 댓글입니다.</div>';
					}
					
					if(item.rr_report < 5){
					// 답글 작성 버튼
					output += '<div class="flexbox-h side mhide">';
					/*if (param.user_num) {*/
						output += '<div><input type="button" data-num="' + item.cc_num + '" data-parent="' + item.te_num + '" data-depth="' + (item.te_depth + 1) + '" value="답글" class="response2-btn"></div>'; // 답글 작성 버튼 데이터 수정
					
					//답글좋아요
					output += '<div class="flexbox-h">';
					if (item.respclick_num == 0 || param.user_num != item.respclick_num) {
						output += '<div class="resp-like-btn" data-num="' + item.te_num + '"><img class="resp-like" src="../images/kbm/heart01.png" height="11">&nbsp;<span class="output-respfcount">' + item.respfav_cnt + '</span></div>'; // 좋아요 버튼 데이터 수정
					} else {
						output += '<div class="resp-like-btn" data-num="' + item.te_num + '"><img class="resp-like" src="../images/kbm/heart02.png" height="11">&nbsp;<span class="output-respfcount">' + item.respfav_cnt + '</span></div>'; // 좋아요 버튼 데이터 수정
					}
					output += '</div>';
					output += '</div>'; // side 닫기
					
					}

					output += '</div>'; // respitem 닫기
					output += '</div>';
					output += '</div>';

					responseContainer.append(output);
				});
			},
			error: function() {
				alert('네트워크 오류 발생');
			}
		});
	}
	
	/* ========================================================================
	 * 답글 좋아요 등록
	 * ======================================================================== */
	$(document).on('click', '.resp-like-btn', function() {
		let heart = $(this);
		$.ajax({
			url: 'writeRespFav',
			type: 'post',
			data: { te_num: heart.attr('data-num') },
			dataType: 'json',
			success: function(param) {
				if (param.result == 'logout') {
					alert('로그인 후 좋아요를 눌러주세요');
				} else if (param.result == 'success') {
					let output;
					if (param.status == 'noFav') {
						output = '../images/heart01.png';
					} else {
						output = '../images/heart02.png';
					}
					//문서 객체에 추가
					heart.find('img.resp-like').attr('src', output);
					heart.find('.output-respfcount').text(param.count);
				} else {
					alert('답글 좋아요 등록/삭제 오류');
				}
			},
			error: function() {
				alert('네트워크 오류 발생');
			}
		});
	});
	
	
	
	/* ========================================================================
	 * 답글 수정
	 * ======================================================================== */	
	//답글 수정 버튼 클릭시 수정폼 노출
	$(document).on('click','.resp-modify-btn',function(){
		event.preventDefault();
		//답글 번호
		let te_num = $(this).attr('data-num');
		//답글 내용
		let content = $(this).parents('.resp-container').find('.te-content').html().replace(/<br>/gi,'\r\n');
		//답글 작성자 번호
		let mem_num = $(this).attr('data-memnum');
		//작성자 아이디 또는 닉네임
		let name = $(this).attr('data-name');
		//답글 수정 폼 UI
		let responseUI = '';
/*			responseUI += '<div class="mresp-form-container">';
			responseUI += '	<div class="">';
			responseUI += '		<img src="../myPage/viewProfile?mem_num=' +mem_num+ '" width="30" height="30" class="my-photo">';
			responseUI += '		<span>' +name+ '</span>';
			responseUI += '	</div>';	*/
			responseUI += '	<div class="mresp-form-container">';
			responseUI += '		<form id="mresp_form">'
			responseUI += '  		 <input type="hidden" name="te_num" id="mresp_num" value="'+te_num+'">';
			responseUI += '  		 <div class="text-con"><textarea rows="3" cols="50" name="te_content" id="mresp_content" class="mrep-content">'+content+'</textarea></div>';			      
			responseUI += '   		<div id="mresp_second" class="align-right">';
			responseUI += '     		 <input type="submit" value="수정" class="mcc-submit">';
			responseUI += '    			  <input type="button" value="취소" class="mresp-reset">';
			responseUI += '  		 </div>';
			responseUI += '		</form>';
			responseUI += '	</div>';
			responseUI += '</div>';
		
		//이전에 이미 수정하는 답글이 있을 경우 수정버튼을 클릭하면
		//숨김 resp-sub-item를 환원시키고 수정폼을 초기화함
		initResponseModifyForm();
		//지금 클릭해서 수정하고 하는 데이터는 감추기
		$(this).closest('.resp-container').find('.mhide').hide();
		
		//수정폼을 수정하고자하는 데이터가 있는 div에 노출
		$(this).parents('.resp-container').find('.resp-sub-item').append(responseUI);
		

	});
	//답글 수정 폼 초기화
	function initResponseModifyForm(){
		$('.mhide').show();
		$('.mresp-form-container').remove();
	}
	//답글 수정 취소 버튼 클릭시 답글 폼 초기화
	$(document).on('click','.mresp-reset',function(){
		initResponseModifyForm();
	});
	
	//답글 수정
	$(document).on('submit','#mresp_form',function(event){
		if($('#mresp_content').val().trim()==''){
			alert('내용을 입력하세요');
			$('#mresp_content').val('').focus();
			return false;
		}
		//폼에 입력한 데이터 반환
		let form_data = $(this).serialize();
		
		//서버와 통신
		$.ajax({
			url:'updateResponse',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result=='logout'){
					alert('로그인해야 수정할 수 있습니다.');
				}else if(param.result=='success'){
                    $('#mresp_form').closest('.resp-container').find('.te-content')
				      .html($('#mresp_content').val()
				          .replace(/</g,'&lt;')
				          .replace(/>/g,'&gt;')
				          .replace(/\r\n/g,'<br>')
				          .replace(/\r/g,'<br>')
				          .replace(/\n/g,'<br>'));
					//수정일
					$('#mresp_form').closest('.resp-container').find('.resp-modify-date').html(param.resp_modify_date);

					//수정 폼 초기화
					initResponseModifyForm();                        
				}else if(param.result=='wrongAccess'){
					alert('타인의 글은 수정할 수 없습니다.');
				}else{
					alert('답글 수정 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
		//기본 이벤트 제거
		event.preventDefault();
	});
	
	
	/* ========================================================================
	 * 답글 삭제
	 * ======================================================================== */		
	$(document).on('click','.resp-delete-btn',function(){
		let resdelete_btn = $(this);
		//댓글 번호
		let cc_num = $(this).attr('data-rnum');
		//답글 번호
		let te_num = $(this).attr('data-num');
		//작성자 회원번호
		let mem_num = $(this).attr('data-mem');
		
		let check = confirm('댓글을 삭제하시겠습니까?');

		if(check){
			//서버와 통신
			$.ajax({
				url:'deleteResponse',
				type:'post',
				data:{te_num:te_num,mem_num:mem_num},
				dataType:'json',
				success:function(param){
					if(param.result=='logout'){
						alert('로그인해야 삭제할 수 있습니다.');
					}else if(param.result=='success'){
						if(param.cnt>0){
							getListResponse(cc_num,	resdelete_btn.closest('.cc-all-container').find('.response-container'));
						}else{
							resdelete_btn.closest('.cc-all-container').find('.response-container').hide();            
						}             
					}else if(param.result=='wrongAccess'){
						alert('타인의 글을 삭제할 수 없습니다.');
					}else{
						alert('답글 삭제 오류 발생');
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});
		}
	});
	
	


	/* ========================================================================
	 * 댓글수 표시
	 * ========================================================================*/
	function displayCommentCount(count) {
		let output;
		if (count > 0) {
			output = count;
		} else {
			output = '0';
		}
		//문서 객체에 추가
		$('.output-rcount').text(output);
	}

	/* ========================================================================
	 * 초기 데이터(목록) 호출
	 * ======================================================================== */
	selectList(1);
	
	
	
	
	
	/*댓글 신고*/
	$(document).on('click', '.comment-report', function() {
		var user_num = $(this).data('memnum');
		var cc_num = $(this).data('num');
		var cc_content = $(this).data('content');
		if (cc_content.length > 20) {
			cc_content = cc_content.substring(0, 20) + '...';
		}
		if (user_num == null || user_num == undefined || user_num.toString().trim() == '') {
	        alert('로그인 후 신고할 수 있습니다.');
	    }else {
			window.open('/board/commentReportForm?cc_num='+cc_num+'&cc_content='+cc_content+'&user_num='+user_num, '_blank', 'width=500,height=650');
				
	    }
	});
	
	
	/*답글 신고*/
	$(document).on('click', '.response-report', function() {
		var user_num = $(this).data('memnum');
		var te_num = $(this).data('num');
		var te_content = $(this).data('content');
		if (te_content.length > 20) {
			te_content = te_content.substring(0, 20) + '...';
		}
		if (user_num == null || user_num == undefined || user_num.toString().trim() == '') {
	        alert('로그인 후 신고할 수 있습니다.');
	    }else {
			window.open('/board/responseReportForm?te_num='+te_num+'&te_content='+te_content+'&user_num='+user_num, '_blank', 'width=500,height=650');
				
	    }
	});
});