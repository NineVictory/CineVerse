$(function(){
	$('#board_report').click(function() {
		var user_num = $(this).data('memnum');
		var cb_num = $(this).data('num');
		var cb_title = $(this).data('title');
		var writer = $(this).data('writer');
		alert(user_num + ',' + cb_num + ',' + cb_title + ',' + writer);

	    if (user_num == null || user_num == undefined || user_num.toString().trim() == '') {
	        alert('로그인 후 신고할 수 있습니다.');
	    }else {
			window.open('/board/boardReportForm?cb_num='+cb_num+'&writer='+writer+'&cb_title='+cb_title+'&user_num='+user_num, '_blank', 'width=550,height=650');
			
			/*$.ajax({
				url:'assign/reportform',
				type:'post',
				data:{
					user_num : user_num,ab_num,
					ab_num : ab_num,
					ab_title : ab_title,
					writer : writer
				},
				dataType:'json',
				success:function(param){
					if(param.result == 'success'){
						window.open('/assignboard/reportForm?ab_num=' + ab_num, '_blank', 'width=550,height=650');
					}else {
						alert('신고하기 오류 발생');
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});
			
	        
	        newWindow.document.close();
	
	        newWindow.document.getElementById('reportForm').addEventListener('submit', function(event) {
	            var categorySelected = false;
	            var categories = newWindow.document.getElementsByName('ar-category');
	            for (var i = 0; i < categories.length; i++) {
	                if (categories[i].checked) {
	                    categorySelected = true;
	                    break;
	                }
	            }
	
	            if (!categorySelected) {
	                newWindow.alert('신고 사유를 선택해주세요.');
	                event.preventDefault();
	            } else {
	                newWindow.alert('신고가 접수되었습니다.');
	                newWindow.close();
	            }
	        });*/
	
	    }
	});

});