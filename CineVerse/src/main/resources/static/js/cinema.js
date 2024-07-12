$(function(){
	$('.secondary-location-a').click(function(event){
		//서버와 통신
		$.ajax({
			url: 'cinemaList',
			type: 'get',
			data: {c_location:$(this).attr('data-num')},
			dataType: 'json',
			success: function(param){
				$('#branch').empty();
				$(param.list).each(function(index,item){
					let output =  '<li class="hide_location_menu_li">'
					output	+= '<a href="#" class="location-hide-menu-a">'
					output	+= item.c_branch
					output	+= '</a>'
					output	+= '</li>'
					$('#branch').append(output);
				});
			},
			error: function(){
				alert('네트워크 오류 발생');
			}
		});
		//기본 이벤트 제거
		event.preventDefault();
	});
});