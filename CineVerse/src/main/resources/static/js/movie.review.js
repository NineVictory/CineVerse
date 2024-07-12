$(function(){
	let rowCount = 10;
	let currentPage;
	let count;
	
	/*===================
		리뷰 목록
	===================*/
	//리뷰 목록
	function selectList(pageNum){
		
	}
	/*===================
		리뷰 등록
	===================*/
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
				}else if(param.result == 'success'){
					//폼 초기화
					initForm();
					//리뷰 작성시 성공하면 새로 삽입한 글을 포함해서 
					//첫번째 페이지의 게시글들을 다시 호출함
					selectList(1);
				}else{
				    alert('리뷰 등록 오류 발생')	
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
		$('#re_first .letter-count').text('300/300');
	}
	/*===================
		리뷰 수정
	===================*/
	
	/*===================
		리뷰(답글) 등록, 수정 공통
	===================*/
	
	/*===================
		리뷰 삭제
	===================*/
	
	/*===================
		리뷰수 표시
	===================*/
	/*===================
		리뷰수 좋아요 등록
	===================*/
	/*===================
		리뷰수 좋아요 표시
	===================*/
	
	/*===================
		초기 데이터 호출
	===================*/
	selectList(1);
});