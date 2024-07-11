$(function(){
	/*------------------------------------
	 * 찜 불러오기
	 *-----------------------------------*/
	function getProductFav(p_num){
		$.ajax({
			url:'getProductFav',
			type:'get',
			data:{p_num:p_num},
			dataType:'json',
			success:function(param){
				displayFav(param);
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	}
	
	/*----------------------
	 * 찜하기, 찜취소하기
	 *---------------------*/
	$('#output_fav').click(function(event){
		event.preventDefault();
		$.ajax({
			url:'productFav',
			type:'post',
			data:{p_num:$('#output_fav').attr('data-num')},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 좋아요를 눌러주세요');
				}else if(param.result == 'success'){
					displayFav(param);
				}else{
					alert('좋아요 등록/삭제 오류 발생');
				}				
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});	
	
	/*----------------------
	 * 좋아요 표시 공통 함수
	 *---------------------*/
	function displayFav(param){
		let output;
		if(param.status=='yesFav'){
			output = '♥';
		}else if(param.status=='noFav'){
			output = '♡';
		}else{
			alert('좋아요 표시 오류 발생');
		}
		//문서 객체에 추가
		$('.fav').text(output);
		$('.output_fcount').text(param.count);
	}
	
	//초기 데이터 표시
	getProductFav($('#output_fav').attr('data-num'));
	
});








