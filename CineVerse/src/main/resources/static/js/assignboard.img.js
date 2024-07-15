/*$(document).ready(function(){
    $('.slider').slick({
        autoplay: false, // 자동 넘김 비활성화
        dots: true, // 점 네비게이션 표시 여부
        arrows: false // 화살표 네비게이션 숨김
    });

    // 이전 버튼 클릭 시
    $('.prevBtn').click(function(){
        $('.slider').slick('slickPrev'); // 이전 슬라이드로 이동
    });

    // 다음 버튼 클릭 시
    $('.nextBtn').click(function(){
        $('.slider').slick('slickNext'); // 다음 슬라이드로 이동
    });
});*/
$(document).ready(function(){
        $('.slider').slick({
            autoplay: false, // 자동 넘김 비활성화
            dots: false, // 점 네비게이션 숨김
            arrows: false, // 화살표 네비게이션 숨김
            infinite: true, // 무한 반복
            slidesToShow: 1, // 한 번에 보여줄 슬라이드 개수
            slidesToScroll: 1 // 한 번에 넘길 슬라이드 개수
        });

        // 이전 버튼 클릭 시
        $('.slick-prev').click(function(){
            $('.slider').slick('slickPrev'); // 이전 슬라이드로 이동
        });

        // 다음 버튼 클릭 시
        $('.slick-next').click(function(){
            $('.slider').slick('slickNext'); // 다음 슬라이드로 이동
        });
    });
