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
});