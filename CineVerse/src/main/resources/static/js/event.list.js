$(function(){
	let currentIndex = 0;
    const itemsPerPage = 8;
    const items = $('.event-list li');
    const loadMoreButton = $('#load-more');

    function showItems() {
        for (let i = currentIndex; i < currentIndex + itemsPerPage && i < items.length; i++) {
            $(items[i]).show();
        }
        currentIndex += itemsPerPage;

        if (currentIndex >= items.length) {
            loadMoreButton.hide();
        }
    }

    // 처음 8개 항목 표시
    for (let i = 0; i < itemsPerPage && i < items.length; i++) {
        $(items[i]).show();
    }
    currentIndex = itemsPerPage;

    // 더보기 버튼의 초기 표시 여부 설정
    if (items.length <= itemsPerPage) {
        loadMoreButton.hide(); // 항목이 8개 이하일 경우 더보기 버튼 숨김
    } else {
        loadMoreButton.show(); // 항목이 8개 초과일 경우 더보기 버튼 보임
    }

    loadMoreButton.on('click', showItems);
    
    
    
    //당첨자 마이페이지 이동
    $('#event_mypage').click(function(){
		$.ajax({
			url:'eventMyPageLoginCheck',
			type:'post',
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 확인 가능합니다.');
				}else if(param.result == 'success'){
					location.href='/myPage/myEvent';
				}else{
					alert('당첨자 발표 확인 오류');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});
});