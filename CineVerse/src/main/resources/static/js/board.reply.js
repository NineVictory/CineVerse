$(function(){
	let rowCount = 10;
	let currentPage;
	let count;
	
	/* ========================================================================
	 * 댓글 목록
	 * ======================================================================== */
	//댓글목록
	function selectList(pageNum){
		currentPage = pageNum;
		
		//서버와 통신
		$.ajax({
			url:'listComment',
			type:'get',
			data:{cb_num:$('#cb_num').val(),pageNum:pageNum,rowCount:rowCount},
			dataType:'json',
			beforeSend:function(){
				$('#loading').show();//로딩 이미지 표시
			},
			complete:function(){
				//success와 error 콜백이 호출된 후에 호출
				$('#loading').hide();//로딩 이미지 숨김
			},
			success:function(param){
				count = param.count;
				
				if(pageNum == 1){
					//처음 호출시는 해당 ID의 div의 내부 내용물을 제거
					$('#output').empty();
				}
				
				//댓글수 읽어 오기
				displayReplyCount(param.count);
				
				//댓글 목록 작업
				$(param.list).each(function(index,item){
					//처음에는 보여지지 않고 다음 댓글부터 수평선에 보이게 처리
					if(index>0) $('#output').append('<hr size="1" width="100%" class="comment-hr">'); 
					
					let output = '<div class="flexbox-p comment-container">';
					output += '     <div>';

					output += '        <div class="flexbox-h side writer-btns">';
					output += '        		<div class="flexbox-h cc-writer-info">';
						output += '				<img src="../member/viewProfile?mem_num=' +item.mem_num+ '" width="30" height="30" class="my-photo">';
											if(item.nick_name){
												output += item.nick_name;
											}else{
												output += item.mem_id;
											}
					output += '				</div>';
					if(param.user_num===item.mem_num){
						//로그인 한 회원번호와 댓글 작성자 회원번호가 같으면/
						output += ' 		<div class="cc-btn">';
						output += '				<span class="cc-cbtn"><img class="menu-img" src="../images/kbm/menu.png" height="18"></span>'
					output += '					<ul class="btn-hide">';
		            output += '						<li><a href="" class="cc-modify-btn">수정</a></li>';
		            output += '						<li><a href="#" id="cc-delete_btn" class="cc-delete-btn">삭제</a></li>';
		        	output += '					</ul>';
			        													
						/*output += '				<input type="button" data-num="'+item.cc_num+'" value="수정" class="modify-btn">';
						output += '  			<input type="button" data-num="'+item.cc_num+'" value="삭제" class="delete-btn">';*/
						output += '			</div>';

					}
										
					output += '			</div>';

					output +='     </div>';
					output +='     <div class="sub-item">';
						output += '    <div class="cc-content">' + item.cc_content.replace(/\r\n/g,'<br>') + '</div>';

							if(item.cc_modify_date){
								output += '<span class="cc-modify-date">최근 수정일 : ' + item.cc_modify_date + '</span>';
							}else{
								output += '<span class="cc-modify-date">' + item.cc_reg_date + '</span>';
							}
					output +='     </div>';
					output +='     <div>';
					//[답글 전용 시작]//
					if(param.user_num){
						output += '  <input type="button" data-num="'+item.cc_num+'" data-parent="0" data-depth="0" value="답글" class="response-btn">';
					}
					/*if(item.resp_cnt > 0){
						//data-status의 값이 0이면 답글 미표시 상태 1이면 답급 표시 상태
						output += '  <div><input type="button" data-status="0" data-num="'+item.cc_num+'" value="▲ 답글 '+ item.resp_cnt+'" class="rescontent-btn"></div>';
					}else{
						output += '  <div><input type="button" data-status="0" data-num="'+item.cc_num+'" value="▲ 답글 0" class="rescontent-btn" style="display:none;"></div>';
					}*/
					//[답글 전용 끝]//
					
					//좋아요 시작//
					/*if(item.click_num==0 || param.user_num!==item.click_num){
						output += ' <img class="output_rfav" src="../images/heart01.png" data-num="'+item.cc_num+'"> <span class="output_rfcount">'+item.refav_cnt+'</span>';
					}else{
						output += ' <img class="output_rfav" src="../images/heart02.png" data-num="'+item.cc_num+'"> <span class="output_rfcount">'+item.refav_cnt+'</span>';
					}*/
					//좋아요 끝//
					
					
					
					
					
					
					output +='     </div>';
					output += '  </div>';
					output += '</div>';
											
					//문서 객체에 추가
					$('#output').append(output);
				});
				document.addEventListener("DOMContentLoaded", function() {
    // 모든 메뉴 이미지(.menu-img) 요소를 가져와서 클릭 이벤트를 추가합니다.
    const menuImages = document.querySelectorAll('.menu-img');
    menuImages.forEach(function(menuImg) {
        menuImg.addEventListener('click', function() {
            const btnContainer = this.closest('.cc-btn');
            if (btnContainer) {
                const menu = btnContainer.querySelector('.btn-hide');
                if (menu) {
                    menu.classList.toggle('show'); // 'show' 클래스를 토글하여 표시 여부 변경
                }
            }
        });
    });
});
				
				
				
				
				
				
				console.log("currentPage:"+currentPage);
				console.log("count:"+count);
				console.log("rowCount:"+rowCount);
				//paging button 처리
				if(currentPage>=Math.ceil(count/rowCount)){
					//다음 페이지가 없음
					$('.paging-button').hide();
				}else{
					//다음 페이지가 존재
					$('.paging-button').show();
				}
			},
			error:function(){
				alert('네트워크 오류');
			}
		});
	}
	
	//다음 댓글 보기 버튼 클릭시 데이터 추가
	$('.paging-button input').click(function(){
		selectList(currentPage + 1);
	});
	
	/* ========================================================================
	 * 댓글 등록
	 * ======================================================================== */
	//댓글 등록
	$('#comment_form').submit(function(event){
		if($('#cc_content').val().trim()==''){
			alert('내용을 입력하세요');
			$('#cc_content').val('').focus();
			return false;
		}
		
		let form_data = $(this).serialize();
		console.log(form_data);
		//서버와 통신
		$.ajax({
			url:'writeComment',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result=='logout'){
					alert('로그인해야 작성할 수 있습니다.');
				}else if(param.result=='success'){
					//폼 초기화
					initForm();
					//댓글 작성이 성공하면 새로 삽입한 글을 포함해서 첫번째 페이지의 게시글들을 다시 호출함
					selectList(1);
				}else{
					alert('댓글 등록 오류 발생!');
				}
			},
			error:function(){
				alert('네트워크 오류!');
			}
		});
		//기본 이벤트 제거
		event.preventDefault();
	});
	//댓글 작성 폼 초기화
	function initForm(){
		$('textarea').val('');
		$('#re_first .letter-count').text('300/300');
	}
	
	/* ========================================================================
	 * 댓글 수정
	 * ======================================================================== */
	//댓글 수정 버튼 클릭시 수정폼 노출
	$(document).on('click','.cc-modify-btn',function(){
		
		//댓글 번호
		let re_num = $(this).attr('data-num');
		//댓글 내용
		let re_content = $(this).parent().find('p').html().replace(/<br>/gi,'\r\n');
		                                             //g:지정문자열 모두, i:대소문자 무시                                             
		//댓글 수정폼 UI
		let modifyUI = '<form id="mre_form">';
			modifyUI += '   <input type="hidden" name="re_num" id="mre_num" value="'+re_num+'">';
			modifyUI += '   <textarea rows="3" cols="50" name="re_content" id="mre_content" class="rep-content">'+re_content+'</textarea>';
			
			modifyUI += '   <div id="mre_first"><span class="letter-count">300/300</span></div>';      
			modifyUI += '   <div id="mre_second" class="align-right">';
			modifyUI += '      <input type="submit" value="수정">';
			modifyUI += '      <input type="button" value="취소" class="re-reset">';
			modifyUI += '   </div>';
			modifyUI += '   <hr size="1" noshade width="96%">';
			modifyUI += '</form>';
	
		//이전에 이미 수정하는 댓글이 있을 경우 수정버튼을 클릭하면
		//숨김 sub-item를 환원시키고 수정폼을 초기화함
		initModifyForm();
		//지금 클릭해서 수정하고자 하는 데이터는 감추기
		//(수정버튼을 감싸고 있는 div)
		$(this).parent().hide();
		
		//수정폼을 수정하고자하는 데이터가 있는 div에 노출
		$(this).parents('.item').append(modifyUI);
				
		//입력한 글자수 셋팅
		let inputLength = $('#mre_content').val().length;
		let remain = 300 - inputLength;
		remain += '/300';
		
		//문서 객체에 반영
		$('#mre_first .letter-count').text(remain);
	});
	
	//수정폼에서 취소 버튼 클릭시 수정폼 초기화
	$(document).on('click','.re-reset',function(){
		initModifyForm();
	});
	
	//댓글 수정 폼 초기화
	function initModifyForm(){
		$('.sub-item').show();
		$('#mre_form').remove();
	}
	
	//댓글 수정
	$(document).on('submit','#mre_form',function(event){
		if($('#mre_content').val().trim()==''){
			alert('내용을 입력하세요!');
			$('#mre_content').val('').focus();
			return false;
		}
		
		//폼에 입력한 데이터 반환
		let form_data = $(this).serialize();
		
		//서버와 통신
		$.ajax({
			url:'updateReply',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result=='logout'){
					alert('로그인해야 수정할 수 있습니다.');
				}else if(param.result=='success'){
					//수정 데이터 표시
					$('#mre_form').parent().find('p').html($('#mre_content').val().replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/\r\n/g,'<br>').replace(/\r/g,'<br>').replace(/\n/g,'<br>'));
					//최근 수정일 처리
					$('#mre_form').parent().find('.modify-date').text('최근 수정일 : 5초미만');
									
					//수정폼 초기화
					initModifyForm();
				}else if(param.result=='wrongAccess'){
					alert('타인의 글은 수정할 수 없습니다.');
				}else{
					alert('댓글 수정 오류 발생');
				}
			},
			error:function(){
				alert('네크워크 오류 발생');
			}
		});
		//기본 이벤트 제거
		event.preventDefault();
	});
	
	/* ========================================================================
	 * 댓글수 표시
	 * ========================================================================*/
	function displayReplyCount(count){
		let output;
		if(count>0){
			output = count;
		}else{
			output = '0';
		}			
		//문서 객체에 추가
		$('#output_rcount').text(output);
	}	
	
	/* ========================================================================
	 * 초기 데이터(목록) 호출
	 * ======================================================================== */		
	selectList(1);
});