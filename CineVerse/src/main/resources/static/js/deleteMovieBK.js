$(function(){
	$('.mov_bk').click(function(){
		let check = confirm('찜목록에서 삭제하시겠습니까?');
		if(check){
			let m_code = $(this).attr('data-num');
			let mem_num = $(this).attr('data-mnum');
			$.ajax({
				url:'deleteMovieBookMark',
				type:'post',
				data:{m_code:m_code,mem_num:mem_num},
				dataType:'json',
				success:function(param){
					if(param.result=='logout'){
						alert('로그인후 사용가능')
					}else if(param.result=='wrongAccess'){
						alert('타인의 찜목록을 삭제할 수 없습니다');
					}else if(param.result=='success'){
						alert('제거 완료');
						location.reload();
					}else{
						alert('찜삭제 오류 발생');
					}
				},
				error:function(){
					alert('네트워크 오류');
				}
			});
		}
	});
});