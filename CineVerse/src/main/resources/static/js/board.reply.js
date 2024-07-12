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
					if(index>0) $('#output').append('<hr size="1" width="100%">'); 
					
					let output = '<div class="item">';
					output += '     <ul class="detail-info">';
					output += '        <li>';
					output += '        <div class="flexbox-h side">';
					output += '        		<div><img src="../member/viewProfile?mem_num=' +item.mem_num+ '" width="40" height="40" class="my-photo">';
					 
											if(item.nick_name){
												output += item.nick_name + '<br>';
											}else{
												output += item.mem_id + '<br>';
											}
					output += '				</div>';
					if(param.user_num===item.mem_num){
						//로그인 한 회원번호와 댓글 작성자 회원번호가 같으면/
						output += ' 		<div>';
						output += '				<input type="button" data-num="'+item.cc_num+'" value="수정" class="modify-btn">';
						output += '  			<input type="button" data-num="'+item.cc_num+'" value="삭제" class="delete-btn">';
						output += '			</div>';
					}
					output += '			<div>';
					output +='        </li>';
					output +='     </ul>';
					output +='     <div class="sub-item">';
					output += '    <p>' + item.cc_content.replace(/\r\n/g,'<br>') + '</p>';
					
					//좋아요 시작//
					/*if(item.click_num==0 || param.user_num!==item.click_num){
						output += ' <img class="output_rfav" src="../images/heart01.png" data-num="'+item.cc_num+'"> <span class="output_rfcount">'+item.refav_cnt+'</span>';
					}else{
						output += ' <img class="output_rfav" src="../images/heart02.png" data-num="'+item.cc_num+'"> <span class="output_rfcount">'+item.refav_cnt+'</span>';
					}*/
					//좋아요 끝//
					
					
					
					if(item.cc_modify_date){
						output += '<span class="cc-modify-date">최근 수정일 : ' + item.cc_modify_date + '</span>';
					}else{
						output += '<span class="cc-modify-date">' + item.cc_reg_date + '</span>';
					}
					
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
					
					/*output += '  </div>';
					output += '</div>';*/
											
					//문서 객체에 추가
					$('#output').append(output);
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