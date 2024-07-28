$(function() {
    $('.m_cancle').click(function() {
        let check = confirm('예매를 취소하시겠습니까?');
        if (check) {
            let mb_num = $(this).attr('data-num');
            let mem_num = $(this).attr('data-mnum');
            let mb_price = $(this).attr('data-price');
            let ph_payment = $(this).attr('data-payment');
            $.ajax({
                url: 'delResMov',
                type: 'post',
                data: { mb_num: mb_num, mem_num: mem_num, mb_price: mb_price, ph_payment: ph_payment },
                dataType: 'json',
                success: function(param) {
                    if (param.result == 'logout') {
                        alert('로그인 후 이용가능합니다');
                    } else if (param.result == 'wrongAccess') {
                        alert('타인의 예매내역은 취소할 수 없습니다.');
                    } else if (param.result == 'success') {
                        alert('예매 취소 완료');
                        location.reload();
                    } else {
                        alert('예매취소 오류 발생');
                    }
                },
                error: function() {
                    alert('네트워크 오류');
                }
            });
        }
    });
});
