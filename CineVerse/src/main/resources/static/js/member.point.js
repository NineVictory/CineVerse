$(function() {
	$('#charge_kakao, #charge_toss').click(function() {
		var IMP = window.IMP;
		IMP.init('imp83031471');
		var money = $('input[name="cp_item"]:checked').val();
		var buyerName = $('#buyer_name').val();
		var buyerEmail = $('#buyer_email').val();
		var memNum = $('#mem_num').val();
		var paymentMethod = $(this).attr('id') === 'charge_kakao' ? 'kakaopay' : 'tosspay';
		
		if(money == null){
			alert('충전하실 금액을 선택해주세요.');
			return false;
		}

		IMP.request_pay(
			{
				pg: paymentMethod,
				pay_method: "card",
				merchant_uid: "merchant_" + new Date().getTime(),
				name: "주문명:결제테스트",
				amount: money,
				buyer_email: buyerEmail,
				buyer_name: buyerName,
			},
			function(rsp) {
				if (rsp.success) {
					var msg = '결제가 완료되었습니다.';
					msg +=  rsp.paid_amount + 'P가 충전되었습니다.'  ;
					$.ajax({
						type: "POST",
						url: "pointCharge",
						data: {
							"ph_point": money,
							"mem_num": memNum,
						},
						success: function(response) {
                        if (response.result === "success") {
                            alert(msg);
                            document.location.href = "/member/pointCharge";
                        } else {
                            alert('포인트 충전 오류가 발생했습니다.');
                        }
                    },
                    error: function() {
                        alert('네트워크 오류가 발생했습니다.');
                    }
                });
            } else {
                var msg = '결제에 실패하였습니다.';
                alert(msg);
            }
			}
		);
	});
});
