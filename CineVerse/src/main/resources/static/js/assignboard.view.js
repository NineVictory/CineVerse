$(function(){
	let isLiked = false;

    function toggleLikeBtn() {
		
	}
	$('.likeBtn').click(function(){
		const btn = document.querySelector('.likeBtn');

		isLiked = !isLiked;

		if(isLiked) {
			btn.classList.add('liked');
		}else {
			btn.classList.remove('liked');
		}
	});
	
	
});