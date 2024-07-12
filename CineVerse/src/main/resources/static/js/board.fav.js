$(function(){
	/*--------------------------------------
	 *	좋아요 읽기 (좋아요 선택 여부와 선택한 총개수 표시)
	 *--------------------------------------*/
	function selectFav(cb_num){
		//서버와 통신
		$.ajax({
			url:'getFav',
			type:'get',
			data:{cb_num:cb_num},
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
	 *	좋아요 등록/삭제
	 *------------------*/
	$('#output_fav').click(function(){
		//서버와 통신
		$.ajax({
			url:'writeFav',
			type:'post',
			data:{cb_num:$('#output_fav').attr('data-num')},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 좋아요를 눌러주세요');
				}else if(param.result == 'success'){
					displayFav(param);
				}else{
					alert('좋아여 등록/삭제 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});
	/*------------------
	 *	좋아요 표시 공통 함수
	 *------------------*/
	function displayFav(param){
		let output;
		if(param.status == 'yesFav'){
			output = '../images/kbm/heart02.png';
		}else if(param.status == 'noFav'){
			output = '../images/kbm/heart01.png';
		}else{
			alert('좋아요 표시 오류 발생');
		}
		//문서 객체에 추가
		$('#output_fav').attr('src',output);
		$('#output_fcount').text(param.count);
	}/*공통호출*/
	
	//초기 데이터 표시
	selectFav($('#output_fav').attr('data-num'));
});