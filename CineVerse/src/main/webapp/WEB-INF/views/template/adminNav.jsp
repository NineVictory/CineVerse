<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <div class="adminNav left-outer">
        <div class="menuVar">
            <ul>
                <li><img src="${pageContext.request.contextPath}/images/cmj/logo.png"
                        onclick="location.href = '${pageContext.request.contextPath}/main/main'" /></li>

                <li onclick="toggleSubMenu('menuMember')"><h2>회원</h2></li>
                <ul id="menuMember">
                    <li><a href="${pageContext.request.contextPath}/admin/adminMember">회원관리</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/adminMembership">구독맴버십</a></li>
                </ul>

                <li onclick="toggleSubMenu('menuMovie')"><h2>영화</h2></li>
                <ul id="menuMovie">
                	<li><a href="${pageContext.request.contextPath}/admin/adminMovieForm">영화등록</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/adminMovie">영화</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/adminCinema">영화관</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/adminReservation">예매</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/adminReview">리뷰관리</a></li>
                </ul>

                <li><a href="${pageContext.request.contextPath}/admin/adminNotice"><h2>공지사항</h2></a></li>
                <li><a href="${pageContext.request.contextPath}/admin/adminEvent"><h2>이벤트</h2></a></li>
                <li><a href="${pageContext.request.contextPath}/admin/adminPayment"><h2>포인트</h2></a></li>

                <li onclick="toggleSubMenu('menuBoard')"><h2>게시판</h2></a></li>
                <ul id="menuBoard">
                    <li><a href="${pageContext.request.contextPath}/admin/adminAssignment">양도/교환</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/adminCommunity">영화 톡톡</a></li>
                </ul>

                <li onclick="toggleSubMenu('menuShop')"><h2>벌스샵</h2></li>
                <ul id="menuShop">
                    <li><a href="${pageContext.request.contextPath}/admin/adminShop">상품등록</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/adminProductList">상품목록</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/adminDelivery">배송상태</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/adminAddress">배송지</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/adminShopQna">문의</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/adminShopReview">후기</a></li>
                </ul>

                <li><a href="#"><h2>쿠폰</h2></a></li>
                <li><a href="#"><h2>1:1 문의</h2></a></li>
            </ul>
        </div>
    </div>

    <script>
        function toggleSubMenu(menuId) {
            var subMenu = document.getElementById(menuId);
            if (subMenu.style.display === 'block') {
                subMenu.style.display = 'none';
            } else {
                subMenu.style.display = 'block';
            }
            // 클릭된 메뉴의 스타일 변경
            var clickedMenu = document.querySelector('li[onclick="toggleSubMenu(\'' + menuId + '\')"]');
            clickedMenu.style.backgroundColor = '#ccc'; // 회색 배경색 설정
        }
    </script>