$(function(){
	$('.add_del_btn').click(function(){
		const check = confirm('삭제하시겠습니까?');
	if(check){
		let ab_num = $(this).attr('data-num');
		let mem_num = $(this).attr('data-mnum');
		$.ajax({
			url:'deleteABoardBookMark',
			type:'post',
			data:{ab_num:ab_num,mem_num:mem_num},
			dataType:'json',
			success : function(param){
				if(param.result == 'logout'){
	                alert('로그인해야 삭제할 수 있습니다.');
	            } else if(param.result == 'success'){
	                alert('삭제 완료!');
	                location.reload();
	            } else if(param.result == 'wrongAccess'){
	                alert('타인의 북마크를 삭제할 수 없습니다.');
	            } else {
	                alert('삭제 오류 발생');
	            }
			},
			error:function(){
				alert('네트워크 오류 발생!');
			}
			
		});
	}
	});
	
});