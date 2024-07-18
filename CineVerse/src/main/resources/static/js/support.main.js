$(function(){
	
	$('.faq-mbutton').click(function(){
		let faqKeyword = $('.faq-keyword').val();
		if(faqKeyword.trim() == ''){
			alert('검색어를 입력해 주세요.');
		}else{
			location.href = 'supportFaq/keyword=' + faqKeyword;
		}
	});
});