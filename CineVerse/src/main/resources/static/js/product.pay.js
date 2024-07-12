$(function(){
    var spanElement = document.querySelector('.price-result span');
    var totalValue = parseFloat(spanElement.textContent.trim().replace(',', '')); // 콤마 제거 후 숫자로 변환

    // 페이지 로드 시 초기 total 값 설정
    $('.ttt').text(`${numberWithCommas(totalValue)}원`);
    $('input[name="mc_num"]').val(''); // 초기에는 mc_num을 빈 값으로 설정

    $('.single-select').change(function(event){
        const mc_num = $(this).data('num');
        const sale = parseFloat($(this).data('point')); // sale을 숫자로 변환
        const isChecked = $(this).is(':checked');

        if (isChecked) {
            const formattedSale = numberWithCommas(sale);
            $('#selected_coupon_info').val(`${mc_num},${formattedSale}`);

            $.ajax({
                url: 'coupon', 
                method: 'get',
                data: {mc_num: mc_num, sale: sale},
                success: function(param){
                    if(param.result == 'logout'){
                        alert('로그인 후 이용해주세요');
                    } else if(param.result == 'success'){
                        let cr = sale;
                        $('.cr').text(`${formattedSale}원`);
                        let total = parseFloat(totalValue) - sale; // totalValue를 숫자로 변환하여 계산
                        $('.ttt').text(`${numberWithCommas(total)}원`);
                        updateHiddenInput(total, mc_num); // hidden input의 값을 업데이트, mc_num 전달
                    } else {
                        alert('쿠폰 적용 오류 발생');
                    }
                },
                error: function() {
                    alert("네트워크 오류");
                }
            });
        } else {
            $('#selected_coupon_info').val('');
            $('.cr').text('0원');
            $('.ttt').text(`${numberWithCommas(totalValue)}원`); // 해제 시 원래 값으로 되돌림
            updateHiddenInput(totalValue, ''); // hidden input의 값을 원래 값으로 업데이트, mc_num 빈 값 전달
        }
    });

    function updateHiddenInput(value, mc_num) {
        let adjustedTotal = value >= 50000 ? value : value - 3000;
        $('input[name="total"]').val(`${adjustedTotal}`); // 원화 기호 없이 숫자만 표시
        $('input[name="mc_num"]').val(mc_num); // mc_num 업데이트
    }

    function numberWithCommas(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
});
