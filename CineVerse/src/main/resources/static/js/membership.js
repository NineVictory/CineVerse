$(function(){
	$('.sub_btn').click(function(event){
		event.preventDefault();
		let check = confirm('구독하시겠습니까?');
		if(check){
			let mem_num = $(this).attr('data-mnum');
			$.ajax({
				url:'subMembership',
				type:'post',
				data:{mem_num:mem_num},
				dataType:'json',
				success:function(param){
					if(param.result=='logout'){
						alert('로그인후 이용 가능');
					}else if(param.result=='noPoint'){
						alert('포인트 충전 이용');
					}else if(param.result=='success'){
						alert('구독 완료');
						location.reload();
					}else{
						alert('멤버십 구독 오류');
					}
				},
				error:function(){
					alert('네트워크 오류');
				}
			});
		}
	});
});