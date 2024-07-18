$(function(){
	let faqKeyword = document.querySelector('.faq-keyword').val();
	$('.faq-mbutton').click(function(){
		if(faqKeyword == null){
			alert('검색어를 입력해 주세요.');
		}else{
			location.href = 'supportFaq/keyword=' + faqKeyword;
		}
	});
});