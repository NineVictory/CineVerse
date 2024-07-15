$(function(){
    $(document).on('click', '.add-del-btn', function(){
        // 주소 번호
        let a_num = $(this).attr('data-num');
        // CSRF 토큰
        let csrfToken = $("meta[name='_csrf']").attr("content");
        let csrfHeader = $("meta[name='_csrf_header']").attr("content");
        
        // 서버와 통신
        $.ajax({
            url: 'deleteAddress',
            type: 'post',
            data: {a_num: a_num},
            dataType: 'json',
            beforeSend: function(xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
            success: function(param){
                if(param.result == 'logout'){
                    alert('로그인해야 삭제할 수 있습니다.');
                } else if(param.result == 'success'){
                    alert('삭제 완료!');
                    // 필요한 경우 리스트를 다시 로드하거나 DOM에서 삭제된 요소를 제거하세요.
                    location.reload(); // 예시로 페이지를 새로고침
                } else if(param.result == 'wrongAccess'){
                    alert('타인의 글을 삭제할 수 없습니다.');
                } else {
                    alert('삭제 오류 발생');
                }
            },
            error: function(){
                alert('네트워크 오류 발생!');
            }
        });
    });
});
