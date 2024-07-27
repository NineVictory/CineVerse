$(function(){
    $('.add_del_btn').click(function(){
        let check = confirm('삭제하시겠습니까?');
        if(check){
            let mr_num = $(this).attr('data-num');
            let mem_num = $(this).attr('data-mnum');
            $.ajax({
                url: 'deleteReview',
                type: 'post',
                data: {mr_num: mr_num, mem_num: mem_num},
                dataType: 'json',
                success: function(param){
                    if(param.result == 'logout'){
                        alert('로그인 후 이용 가능합니다');
                    } else if(param.result == 'wrongAccess'){
                        alert('타인의 리뷰는 삭제할 수 없습니다');
                    } else if(param.result == 'success'){
                        alert('리뷰 삭제 완료');
                        location.reload();
                    } else {
                        alert('삭제 오류 발생');
                    }
                },
                error: function(){
                    alert('네트워크 오류');
                }
            });
        }
    });
});
