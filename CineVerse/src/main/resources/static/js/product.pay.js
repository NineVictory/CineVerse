$(function() {
    var spanElement = document.querySelector('.price-result span');
    var totalValue = parseFloat(spanElement[1].textContent.trim().replace(',', '')); // 콤마 제거 후 숫자로 변환

    // 페이지 로드 시 초기 total 값 설정
    $('.ttt').text(`${numberWithCommas(totalValue)}원`);
    $('input[name="mc_num"]').val(''); // 초기에는 mc_num을 빈 값으로 설정

    $('.single-select').change(function(event) {
        const mc_num = $(this).data('num');
        const sale = parseFloat($(this).data('point')); // sale을 숫자로 변환
        const isChecked = $(this).is(':checked');
		const noSaleTotal = $(this).attr('data-nosaletotal');
							
        if (isChecked) {
            const formattedSale = numberWithCommas(sale);
            $('input[name="mc_num"]').val('');
            $('#selected_coupon_info').val(`${mc_num},${formattedSale}`);
			
            $.ajax({
                url: 'coupon',
                method: 'get',
                data: {mc_num: mc_num, sale: sale, noSaleTotal: noSaleTotal},
                success: function(param) {
                    if (param.result == 'logout') {
                        alert('로그인 후 이용해주세요');
                    } else if(param.result=='noMin'){
						$('.single-select').prop('checked', false);
						alert('최소 금액 부족으로 쿠폰을 사용할 수 없습니다.')
					} else if(param.result == 'minus'){
						$('.single-select').prop('checked', false);
						alert('쿠폰을 사용할 수 없습니다.')
					} else if (param.result == 'success') {
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
        let adjustedTotal = value >= 50000 ? value : value + 3000;
        $('input[name="total"]').val(`${adjustedTotal}`); 
        $('input[name="mc_num"]').val(mc_num); 
    }

    function numberWithCommas(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
    
    // 폼 제출 시 선택된 checkbox 값을 서버로 전송하고 폼을 제출
    const form = document.querySelector('.bd');
    const hiddenOption = document.getElementById('hidden_option');
    const submitButton = document.querySelector('.bd input[type="submit"]');

	
	submitButton.addEventListener('click', function(event) {
	    event.preventDefault();

        let a_num = $('input[name="a_num"]:checked').val();
        $('#hidden_option').val(a_num);
		
		let agree;
		if ($('input[name="agree"]').is(':checked')) {
		    agree = 1; // 체크되어 있으면 동의
		} else {
		    agree = 2; // 체크 안 되어 있으면 동의 x
		}


		$('#hidden_agree').val(agree);

        // hidden input 필드에 기본값 설정
        if ($('input[name="a_num"]').val() === "") {
            $('input[name="a_num"]').val(0);
        }
        if ($('input[name="mc_num"]').val() === "") {
            $('input[name="mc_num"]').val(0);
        }

        let form_data = $('.bd').serialize();
        $.ajax({
            url: 'buyDirect',
            method: 'POST',
            data: form_data,
            dataType: 'json',
            success: function(param) {
                if (param.result == 'logout') {
                    alert('로그인 후 이용해주세요');
                } else if (param.result == 'noAddress') {
                    alert('주소가 없습니다.');
                } else if(param.result == 'noAgree'){
					alert('결제 동의는 필수입니다.')
				} else if(param.result == 'noPoint'){
					alert('포인트가 부족합니다. 충전 후 진행해주세요.');
				} else if (param.result == 'success') {
					alert('주문이 완료되었습니다.');
					window.location.href = '../myPage/bought';
                } else {
                    alert('결제 오류 발생');
                } 
            },
            error: function() {
                alert('네트워크 오류 발생');
         	}
        });
    });
	
	
	
});
