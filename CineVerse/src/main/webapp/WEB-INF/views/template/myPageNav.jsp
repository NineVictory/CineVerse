<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
    .myPageNav .mp_nav_active a , .myPageNav .mp_li_active a {
   		 font-weight: 800; 
        color: #3F66ED !important;
    }
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script>
    $(document).ready(function() {
        // 현재 URL 경로 가져오기
        var currentPath = window.location.pathname;
        
        // 경로에 따라 적절한 메뉴 항목에 클래스 추가
        $('.myPageNav a').each(function() {
            if ($(this).attr('href') === currentPath) {
                var parentClass = $(this).parent().hasClass('mp_nav') ? 'mp_nav_active' : 'mp_li_active';
                $(this).parent().addClass(parentClass);
            }
        });

        // 메뉴 항목 클릭 시 강조 처리
        $('.myPageNav a').click(function(event) {
            // 모든 .mp_nav, .mp_li 클래스에서 .mp_nav_active, .mp_li_active 제거
            $('.mp_nav').removeClass('mp_nav_active');
            $('.mp_li').removeClass('mp_li_active');

            // 클릭된 a 태그의 부모 li에 .mp_nav_active 또는 .mp_li_active 클래스 추가
            var parentClass = $(this).parent().hasClass('mp_nav') ? 'mp_nav_active' : 'mp_li_active';
            $(this).parent().addClass(parentClass);
        });
    });
</script>
<div class="myPageNav">
    <ul>
        <li class="mp_nav_myPage" id="mp_nav_myPage"><a href="/myPage/myPageMain">MY 페이지</a></li>
        <li class="mp_nav" id="mp_nav_reservation"><a href="/myPage/reservationList">나의 예매내역</a></li>
        <li class="mp_nav" id="mp_nav_coupon"><a href="/myPage/coupon">나의 쿠폰</a></li>
        <li class="mp_nav" id="mp_nav_expectingMovie">나의 활동</li>
        <li class="mp_li" id="mp_li_expectingMovie"><a href="/myPage/expectingMovie">기대되는 영화</a></li>
        <li class="mp_li" id="mp_li_watchedMovie"><a href="/myPage/watchedMovie">내가 본 영화</a></li>
        <li class="mp_li" id="mp_li_review"><a href="/myPage/review">내가 쓴 평점</a></li>
        <li class="mp_nav" id="mp_nav_boardWrite">커뮤니티</li>
        <li class="mp_li" id="mp_li_bookMark"><a href="/myPage/bookMark">게시글 북마크</a></li>
        <li class="mp_li" id="mp_li_bookMark"><a href="/myPage/boardFav">게시글 좋아요</a></li>
        <li class="mp_li" id="mp_li_boardWrite"><a href="/myPage/boardWrite">내가 쓴 글</a></li>
        <li class="mp_li" id="mp_li_boardReply"><a href="/myPage/boardReply">내가 쓴 댓글</a></li>
        
        <li class="mp_nav" id="mp_nav_boardWrite">양도/교환</li>
        <li class="mp_li" id="mp_li_bookMark"><a href="/myPage/aBoardBookMark">찜한 게시글</a></li>
        <li class="mp_li" id="mp_li_boardWrite"><a href="/myPage/aBoardWrite">내가 쓴 글</a></li>
        
        
        <li class="mp_nav" id="mp_nav_calendar"><a href="#">내 캘린더</a></li><!-- controller부터 추가 -->
        
        <li class="mp_nav" id="mp_nav_eventHistory"><a href="/myPage/myEvent">이벤트 참여 내역</a></li>
        <li class="mp_nav" id="mp_nav_purchase">구매</li>
        <li class="mp_li" id="mp_li_pointCharge"><a href="/myPage/pointList">포인트 내역</a></li>
        <li class="mp_li" id="mp_li_goodsPayment"><a href="/myPage/bought">굿즈 결제 내역</a></li>
        
        <li class="mp_nav" id="mp_nav_chatHistory"><a href="/myPage/chatList">채팅이력</a></li><!-- jsp 내용 추가 -->
        
        <li class="mp_nav" id="mp_nav_memberInfo">회원정보</li>
        <li class="mp_li" id="mp_li_delivery"><a href="/myPage/addressList">배송지 관리</a></li>
        <li class="mp_li" id="mp_li_modifyUser"><a href="/myPage/modifyUser">개인정보 변경</a></li>
        <li class="mp_li" id="mp_li_modifyUser"><a href="/myPage/passwdChange">비밀번호 변경</a></li>
        <li class="mp_li" id="mp_li_withdraw"><a href="/myPage/deleteMember">회원 탈퇴</a></li>
        <li class="mp_nav" id="mp_nav_membership"><a href="/myPage/memberShipSub">멤버십 구독</a></li>
        <li class="mp_nav" id="mp_nav_inquiry">나의 문의 내역</li>
        <li class="mp_li" id="mp_li_oneOnOne"><a href="/myPage/consult">1:1 문의</a></li>
    </ul>
</div>
