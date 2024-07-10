/**
 * 
 */

 var swiper = new Swiper('.swiper-container', {
	    loop: true,
	    pagination: {
	        el: '.swiper-pagination',
	        clickable: true,
	    },
	    navigation: {
	        nextEl: '.swiper-button-next',
	        prevEl: '.swiper-button-prev',
	    },
	    autoplay: {
	        delay: 5000,
	        disableOnInteraction: false,
	    },
	});

	// 모달 관련 코드
	var modal = document.getElementById('modal');
	var modal2 = document.getElementById('modal2');
	var modal3 = document.getElementById('modal3');
	var span = document.getElementsByClassName('close')[0];
	var span2 = document.getElementsByClassName('close')[1];
	var span3 = document.getElementsByClassName('close')[2];

	// 첫 번째 슬라이드를 클릭하면 모달 열기
	document.querySelectorAll('.swiper-slide')[0].addEventListener('click', function() {
	    modal.style.display = 'block';
	});
	
	// 두 번째 슬라이드를 클릭하면 모달 열기
	document.querySelectorAll('.swiper-slide')[1].addEventListener('click', function() {
	    modal2.style.display = 'block';
	});
	
	// 세 번째 슬라이드를 클릭하면 모달 열기
	document.querySelectorAll('.swiper-slide')[2].addEventListener('click', function() {
	    modal3.style.display = 'block';
	});

	// 모달 닫기
	span.onclick = function() {
	    modal.style.display = 'none';
	}
	// 2번째 슬라이더 모달
	span2.onclick = function() {
	    modal2.style.display = 'none';
	}
	// 세번째 슬라이더 모달
	span3.onclick = function() {
	    modal3.style.display = 'none';
	}

	// 모달 외부 클릭 시 닫기
	window.onclick = function(event) {
	    if (event.target == modal) {
	        modal.style.display = 'none';
	    } else if (event.target == modal2) {
	        modal2.style.display = 'none';
	    } else if (event.target == modal3) {
	        modal3.style.display = 'none';
	    }
	}
	
	