$(function(){
	let isLiked = false;


	/*--------------------------------------
	 *	찜 읽기 (좋아요 선택 여부와 선택한 총개수 표시)
	 *--------------------------------------*/
	function selectFav(ab_num){
		//서버와 통신
		$.ajax({
			url:'getFav',
			type:'get',
			data:{ab_num:ab_num},
			dataType:'json',
			success:function(param){
				displayFav(param);
			},
			error:function(){
				alert('네트워크 오류 발생');
			}	
		});
	}
	
	/*------------------
	 *	찜 등록/삭제
	 *------------------*/
    
	$('.likeBtn').click(function(){
		/*const btn = document.querySelector('.likeBtn');

		isLiked = !isLiked;

		if(isLiked) {
			btn.classList.add('liked');
		}else {
			btn.classList.remove('liked');
		}*/
		
		//서버와 통신
		$.ajax({
			url:'writeFav',
			type:'post',
			data:{ab_num:$('.likeBtn').attr('data-num')},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 이용해주세요');
				}else if(param.result == 'success'){
					displayFav(param);
				}else{
					alert('찜하기 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
		
	});
	
	
	/*------------------
	 *	찜하기 공통 함수
	 *------------------*/
	function displayFav(param){
		const btn = document.querySelector('.likeBtn');
		if(param.status == 'yesFav'){
			btn.classList.add('liked');
		}else if(param.status == 'noFav'){
			btn.classList.remove('liked');
		}else{
			alert('좋아요 표시 오류 발생');
		}
		//문서 객체에 추가
		
		$('.output-fcount').text(param.count);
	}
	
	/*공통호출*/
	
	//초기 데이터 표시
	selectFav($('.likeBtn').attr('data-num'));
	
});