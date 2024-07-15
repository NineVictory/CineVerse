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
				displayCommentCount(param.count);
				
				//댓글 목록 작업
				$(param.list).each(function(index,item){
					//처음에는 보여지지 않고 다음 댓글부터 수평선에 보이게 처리
					if(index>0) $('#output').append('<hr size="1" width="100%" class="comment-hr">'); 
					let name = '';
					
					let output = '     <div class="cc-all-container">';
					output += '<div class="flexbox-p comment-container">';
					output += '     <div>';

					output += '        <div class="flexbox-h side writer-btns">';
					output += '        		<div class="flexbox-h cc-writer-info">';
						output += '				<img src="../myPage/viewProfile?mem_num=' +item.mem_num+ '" width="30" height="30" class="my-photo">';
											if(item.nick_name){
												output += item.mem_nickname;
												name += item.mem_nickname;
					
											}else{
												output += item.mem_id;
												name += item.mem_id;
											}
					output += '				</div>';
					if(param.user_num===item.mem_num){
						//로그인 한 회원번호와 댓글 작성자 회원번호가 같으면/
						output += ' 		<div class="cc-btn">';
						output += '				<span class="cc-cbtn"><img class="menu-img" src="../images/kbm/menu.png" height="18"></span>'
					output += '					<ul class="cc-btn-hide">';
		            output += '						<li><a href="" class="cc-modify-btn" data-num="'+item.cc_num+'" data-memnum="'+item.mem_num+'" name="' +name+ '">수정</a></li>';
		            output += '						<li><a href="" id="cc-delete_btn" class="cc-delete-btn" data-num="'+item.cc_num+'" >삭제</a></li>';
		        	output += '					</ul>';
			        													
						output += '			</div>';

					}
										
					output += '			</div>';

					output +='     </div>';
					output +='     <div class="sub-item">';
						output += '    <div class="cc-content">' + item.cc_content.replace(/\r\n/g,'<br>') + '</div>';

							if(item.cc_modify_date){
								output += '<span class="cc-modify-date">수정일 : ' + item.cc_modify_date + '</span>';
							}else{
								output += '<span class="cc-modify-date">' + item.cc_reg_date + '</span>';
							}
					output +='     </div>';
					
					
							output += '<div class="flexbox-h side">'
							
							//data-status의 값이 0이면 답글 미표시 상태 1이면 답급 표시 상태 data-status="0" 
							output += '  <div><input type="button" data-num="'+item.cc_num+'" data-parent="0" data-depth="1"  value="답글" class="response-btn"></div>';
						if(item.click_num==0 || param.user_num!==item.click_num){
							output += '  <div class="cc-like-btn" data-num="'+item.cc_num+'"><img class="cc-like" src="../images/kbm/heart01.png" height="11">&nbsp;<span class="output-rfcount">'+item.refav_cnt+'</span></div>';
						}else{
							output += '  <div class="cc-like-btn" data-num="'+item.cc_num+'"><img class="cc-like" src="../images/kbm/heart02.png" height="11">&nbsp;<span class="output-rfcount">'+item.refav_cnt+'</span></div>';
	
						}
							output += '</div>';

					//답글출력
					output +='     <div class="response-container">';
					output +='     </div>';
					
					
					output += '  </div>';
					output += '</div>';
											
					//문서 객체에 추가
					$('#output').append(output);
					
					var responseContainer = $('.response-container');
					getListResponse(item.cc_num, responseContainer);
					
					if (responseContainer.children().length == 0) {
	           			 responseContainer.hide();
	        		}
					
	  		  });
					
				
			$(document).ready(function() {
			    // 메뉴 이미지 클릭 이벤트 처리
			    $('#output').on('click', '.menu-img', function (event) {
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
	}
	
	/* ========================================================================
	 * 댓글 수정
	 * ======================================================================== */
	//댓글 수정 버튼 클릭시 수정폼 노출
	$(document).on('click','.cc-modify-btn',function(event){
		event.preventDefault();
		//댓글 번호
		let cc_num = $(this).attr('data-num');
		//댓글 내용
		let cc_content = $(this).closest('.comment-container').find('.cc-content').html().replace(/<br>/gi,'\r\n');
		let mem_num = $(this).attr('data-memnum');    
		let name = $(this).attr('name');                                    
		let modifyUI = '<div class="flexbox-p mcc-container">';
					modifyUI += '		<div>';

					modifyUI += '        <div class="flexbox-h side writer-btns">';
					modifyUI += '        		<div class="flexbox-h cc-writer-info">';
					modifyUI += '					<img src="../myPage/viewProfile?mem_num=' +mem_num+ '" width="30" height="30" class="my-photo">';
					modifyUI += '					<span>' + name + '</span>';
					modifyUI += '				</div>';
					modifyUI += '		</div>';
					modifyUI += '		<div>';
					modifyUI += '			<form id="mcc_form">';
					modifyUI += '  				<input type="hidden" name="cc_num" id="mcc_num" value="'+cc_num+'">';
					modifyUI += '   			<div class="text-con"><textarea name="cc_content" id="mcc_content" class="mcc-content">'+cc_content+'</textarea></div>';
					modifyUI += '  			 	<div id="mcc-btn" class="mcc-btn">';
					modifyUI += '     				<input type="submit" class="mcc-submit" value="수정">';
					modifyUI += '					<input type="button" class="cc-reset" value="취소">';
					modifyUI += '				</div>';
					modifyUI += '			</form>';
					modifyUI += '		</div>';
					modifyUI +='     </div>';
					modifyUI += '<hr size="1" width="100%" class="comment-hr">';
					modifyUI += '  </div>';
	
	
		//이전에 이미 수정하는 댓글이 있을 경우 수정버튼을 클릭하면
		//숨김 sub-item를 환원시키고 수정폼을 초기화함
		initModifyForm();
		//지금 클릭해서 수정하고자 하는 데이터는 감추기
		//(수정버튼을 감싸고 있는 div)
		$(this).closest('.comment-container').hide();
		$(this).closest('.cc-all-container').find('.response-btn').hide();
		
		//수정폼을 수정하고자하는 데이터가 있는 div에 노출
		$(this).closest('.cc-all-container').append(modifyUI);
				
	});
	
	//수정폼에서 취소 버튼 클릭시 수정폼 초기화
	$(document).on('click','.cc-reset',function(){
		initModifyForm();
		
	});
	
	//댓글 수정 폼 초기화
	function initModifyForm(){
		$('.comment-container').show();
		$('.mcc-container').remove();
		$('.response-btn').show();
	}
	
	//댓글 수정
	$(document).on('submit','#mcc_form',function(event){
		let form = $(this);
		
		if($('#mcc_content').val().trim()==''){
			alert('내용을 입력하세요');
			$('#mcc_content').val('').focus();
			return false;
		}
		
		//폼에 입력한 데이터 반환
		let form_data = form.serialize();
		
		//서버와 통신
		$.ajax({
			url:'updateComment',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result=='logout'){
					alert('로그인해야 수정할 수 있습니다.');
				}else if(param.result=='success'){
					let updatedContent = form.find('#mcc_content').val();
					form.closest('.cc-all-container').find('.cc-content').html(updatedContent.replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/\r\n/g, '<br>').replace(/\r/g, '<br>').replace(/\n/g, '<br>'));
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
	 * 댓글 삭제
	 * ======================================================================== */
	$(document).on('click','.cc-delete-btn',function(){
		//댓글 번호
		let cc_num = $(this).attr('data-num');
		
		let check =  confirm('댓글을 삭제하시겠습니까?');
		
		if(check){
			//서버와 통신
			$.ajax({
				url:'deleteComment',
				type:'post',
				data:{cc_num:cc_num},
				dataType:'json',
				success:function(param){
					if(param.result == 'logout'){
						alert('로그인해야 삭제할 수 있습니다.');
					}else if(param.result == 'success'){
						alert('댓글 삭제 완료');
						selectList(1);
					}else if(param.result == 'wrongAccess'){
						alert('타인의 글을 삭제할 수 없습니다.');
					}else{
						alert('댓글 삭제 오류 발생');
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});
		}
	});
	
	/* ========================================================================
	 * 댓글 좋아요 등록
	 * ======================================================================== */
	$(document).on('click','.cc-like-btn',function(){
		let heart = $(this);
		$.ajax({
			url:'writeReFav',
			type:'post',
			data:{cc_num:heart.attr('data-num')},
			dataType:'json',
			success:function(param){
				if(param.result=='logout'){
					alert('로그인 후 좋아요를 눌러주세요');
				}else if(param.result=='success'){
					let output;
					if(param.status=='noFav'){
						output = '../images/heart01.png';
					}else{
						output = '../images/heart02.png';
					}			
					//문서 객체에 추가
					heart.find('img.cc-like').attr('src', output);
					heart.find('.output-rfcount').text(param.count);
				}else{
					alert('댓글 좋아요 등록/삭제 오류');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});
	
	
	/* ========================================================================
	 * 답글 등록
	 * ======================================================================== */	
	//답글 작성 버튼 클릭시 답글 작성 폼 노출
	$(document).on('click','.response-btn,.response2-btn',function(){
		var that = $(this);
		
		$.ajax({
			url:'responseLoginCheck',
			type:'get',
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 답글 작성 가능합니다.');
				}else if(param.result = 'success'){
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
					console.log(cc_num +', '+ te_parent_num);
				
					//답글 작성 폼 UI
					let responseUI = '<form id="resp_form">';
						responseUI += '   <input type="hidden" name="cc_num" id="resp_num" value="'+cc_num+'">';
					    responseUI += '   <input type="hidden" name="te_parent_num" value="'+te_parent_num+'">';
					    responseUI += '   <input type="hidden" name="te_depth" value="'+te_depth+'">';
					    responseUI += '		<div class="flexbox-h cc-writer-info">';
						responseUI += '			<img src="../myPage/viewProfile?mem_num=' +user_num+ '" width="30" height="30" class="my-photo">';
						responseUI += '			<span>' +name+ '</span>';
						responseUI += '		</div>';
					    
						responseUI += '   <textarea name="te_content" id="resp_content" class="rep-content"></textarea>';			     
						responseUI += '   <div id="resp_second" class="align-right">';
						responseUI += '      <input type="submit" value="등록">';
						responseUI += '   </div>';
						responseUI += '</form>';
					
						//답글 작성폼을 답글을 작성하고자는 데이터가 있는 div에 노출
						that.closest('.side').next('.response-container').prepend(responseUI);
						that.closest('.side').next('.response-container').show();
									
									
					}
	
				}else{
					alert('답글 등록 로그인체크 오류');
				}
			},
			error:function(){
				alert('네트워크 발생 오류');
			}
		});
			
	});
	
	//답글 등록
	$(document).on('submit','#resp_form',function(event){
		let resp_form = $(this);
		
		if($('#resp_content').val().trim()==''){
			alert('내용을 입력하세요');
			$('#resp_content').val('').focus();
			return false;
		}

		//폼에 입력한 데이터 반환
		let form_data = resp_form.serialize();
		
		let cc_num = resp_form.find('#resp_num').val();
		
		//서버와 통신
		$.ajax({
			url:'writeResponse',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result=='logout'){
					alert('로그인해야 답글을 작성할 수 있습니다.');
				}else if(param.result=='success'){
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
					
					let responseContainer = resp_form.parent('.response-container');
					getListResponse(cc_num,responseContainer);
					
				}else{
					alert('답글 작성 오류 발생');
				}
			},
			error:function(){
				alert('네크워크 오류 발생');
			}
		});
		//기본 이벤트 제거
		event.preventDefault();
	
	});

	//답글 작성 폼 초기화
	function initResponseForm(){
		$('.response-btn,.response2-btn').removeClass('clicked-resp-btn')	
		$('#resp_form').remove();
		
		// 답글 폼을 숨기기 전에 .response-container가 비어 있는지 확인하여 숨김 처리
	    var responseContainers = $('.response-container');
	    responseContainers.each(function() {
	        if ($(this).children().length == 0) {
	            $(this).hide();
	        }
	    });
	}
	
	/* ========================================================================
	 * 답글 목록
	 * ======================================================================== */	
	function getListResponse(cc_num,responseContainer){
		//서버와 통신
		$.ajax({
			url:'getListResp',
			type:'get',
			data:{cc_num:cc_num},
			dataType:'json',
			success:function(param){
				//respitem 아이디가 존재하면 답글을 모두 지운 후 다시 처리함
				//responseContainer.find('.respitem').remove();
				responseContainer.empty();
				
				let output = '';
				$(param.list).each(function(index,item){
				    output += '<div class="respitem">';
					output += ' 	<div class="resp-detail-info">';
					output +='  	 	 <div class="답글 작성자 정보">';
					
					output += '  	  		 <img src="../myPage/viewProfile?mem_num='+ item.mem_num +'" width="30" height="30" class="my-photo">';
					if(item.mem_nickname){
											output += item.mem_nickname;
					}else{
											output += item.mem_id;
					}
					output +='   		 </div>';
					if(param.user_num===item.mem_num){
					
					output += ' 		<div class="cc-btn">';
					output += '				<span class="cc-cbtn"><img class="menu-img" src="../images/kbm/menu.png" height="18"></span>'
					output += '					<ul class="cc-btn-hide">';
		            output += '						<li><a href="" class="resp-modify-btn" data-num="'+item.cc_num+'" data-memnum="'+item.mem_num+'" name="' +name+ '">수정</a></li>';
		            output += '						<li><a href="" id="resp-delete_btn" class="cc-delete-btn" data-num="'+item.cc_num+'" >삭제</a></li>';
		        	output += '					</ul>';
			        													
					output += '			</div>';

					}
					
					output +='  	</div>';//resp-detail-info 작성자+수정삭제버튼
					
					output += '  <div class="resp-sub-item">';
					output +='   	 <div>';
					if(item.te_parent_num>0){
						if(item.pnick_name){
							output += '<b>@' +item.pnick_name+ '</b>';
						}else{
							output += '<b>@' +item.parent_id+ '</b>';
						}
					}
					
					output += 		 item.te_content.replace(/</g,'&lt;').replace(/>/g,'&gt;');
					output +='   	 </div>';
					output +='   	 <div>';
					if(item.te_mdate){
						output += '		<span class="resp-modify-date">수정일 ' + item.te_mdate + '</span>';
					}else{
						output += '		<span class="resp-modify-date">' + item.te_date + '</span>';
					}
					output +='    	</div>';
					output += '  </div>'; //답글내용,작성일
					
						output += '<div class="flexbox-h side">'
						output += '  <div><input type="button" data-num="'+item.cc_num+'" data-parent="' +item.cb_num+ '" data-depth="0"  value="답글" class="response-btn"></div>';
						if(item.click_num==0 || param.user_num!==item.click_num){
							output += '  <div class="resp-like-btn" data-num="'+item.cc_num+'"><img class="cc-like" src="../images/kbm/heart01.png" height="11">&nbsp;<span class="output-rfcount">'+item.refav_cnt+'</span></div>';
						}else{
							output += '  <div class="resp-like-btn" data-num="'+item.cc_num+'"><img class="cc-like" src="../images/kbm/heart02.png" height="11">&nbsp;<span class="output-rfcount">'+item.refav_cnt+'</span></div>';
	
						}
						output += '</div>';

					output += '</div>';
				
					//답글 노출
					responseContainer.append(output);
				
				});
				
				
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	}
	
	
	
	
	
	/* ========================================================================
	 * 댓글수 표시
	 * ========================================================================*/
	function displayCommentCount(count){
		let output;
		if(count>0){
			output = count;
		}else{
			output = '0';
		}			
		//문서 객체에 추가
		$('.output-rcount').text(output);
	}	
	
	/* ========================================================================
	 * 초기 데이터(목록) 호출
	 * ======================================================================== */		
	selectList(1);
});