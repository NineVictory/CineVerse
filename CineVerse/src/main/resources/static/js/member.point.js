/**
 * 
 */

$(function() {

	$('#charge_kakao').click(function() {
		// getter
		var IMP = window.IMP;
		IMP.init('imp83031471');
		var money = $('input[name="cp_item"]:checked').val();
		console.log(money);

		IMP.request_pay(
			{
				pg: "kakaopay",
				pay_method: "card",
				merchant_uid: "merchant_" + new Date().getTime(), // 상점에서 생성한 고유 주문번호
				name: "주문명:결제테스트",
				amount: money,
				buyer_email: "test@portone.io",
				buyer_name: "구매자이름",
			},

			function(rsp) {
				console.log(rsp);
				if (rsp.success) {
					var msg = '결제가 완료되었습니다.';
					msg += '고유ID : ' + rsp.imp_uid;
					msg += '결제 금액 : ' + rsp.paid_amount;
					$.ajax({
						type: "GET",
						url: "/member/point", //충전 금액값을 보낼 url 설정
						data: {
							"amount": money
						},
					});
				} else {
					var msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;
				}
				alert(msg);
				document.location.href = "/member/pointCharge"; //alert창 확인 후 이동할 url 설정
			});
	});

	$('#charge_toss').click(function() {
		// getter
		var IMP = window.IMP;
		IMP.init('imp83031471');
		var money = $('input[name="cp_item"]:checked').val();
		console.log(money);

		IMP.request_pay(
			{
				pg: "tosspay",
				pay_method: "card",
				merchant_uid: "merchant_" + new Date().getTime(),
				name: "주문명:결제테스트",
				amount: money,
				buyer_email: "test@portone.io",
				buyer_name: "구매자이름",
				buyer_tel: "010-1234-5678",
			},

			function(rsp) {
				console.log(rsp);
				if (rsp.success) {
					var msg = '결제가 완료되었습니다.';
					msg += '고유ID : ' + rsp.imp_uid;
					msg += '결제 금액 : ' + rsp.paid_amount;
					$.ajax({
						type: "GET",
						url: "/member/point", //충전 금액값을 보낼 url 설정
						data: {
							"amount": money
						},
					});
				} else {
					var msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;
				}
				alert(msg);
				document.location.href = "/member/pointCharge"; //alert창 확인 후 이동할 url 설정
			});
	});
})