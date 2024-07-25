$(function(){
	$('#board_report').click(function() {
		var user_num = $(this).data('memnum');
		var cb_num = $(this).data('num');
		var cb_title = $(this).data('title');
		var writer = $(this).data('writer');

	    if (user_num == null || user_num == undefined || user_num.toString().trim() == '') {
	        alert('로그인 후 신고할 수 있습니다.');
	    }else {
			window.open('/board/boardReportForm?cb_num='+cb_num+'&writer='+writer+'&cb_title='+cb_title+'&user_num='+user_num, '_blank', 'width=500,height=650');
				
	    }
	});

});