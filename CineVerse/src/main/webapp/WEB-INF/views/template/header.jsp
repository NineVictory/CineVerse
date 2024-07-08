<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 상단 시작 -->
    <div class="header-main">
        <div class="logo"><a href="${pageContext.request.contextPath}/main/main"><img src="${pageContext.request.contextPath}/images/cmj/main_logo.png" alt="메인 로고"
                    style="width: 200px; height: auto;"></a></div>
        <div class="main">
            <ul class="main_menu1">
                <li><a href="#"><img src="${pageContext.request.contextPath}/images/cmj/facebook.png" alt="Facebook"></a></li>
                <li><a href="#"><img src="${pageContext.request.contextPath}/images/cmj/github.png" alt="Github"></a></li>
                <li><a href="#"><img src="${pageContext.request.contextPath}/images/cmj/instagram.png" alt="Instagram"></a></li>
                <li><a href="#"><img src="${pageContext.request.contextPath}/images/cmj/twitter.png" alt="Twitter"></a></li>
            </ul>
            <ul class="main_menu2">
                <li><a href="#">고객 센터</a></li>
                <li><a href="#">멤버십</a></li>
                <c:if test="${!empty user }">
                	<li><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
                </c:if>
                <c:if test="${empty user}">
				<li><a href="${pageContext.request.contextPath}/member/login">로그인</a></li>                
                </c:if>
            </ul>
            <ul class="main_menu3">
            	<c:if test="${!empty user }">
                	<li><a href="${pageContext.request.contextPath}/myPage/myPageMain" class="btn_my"><img src="${pageContext.request.contextPath}/images/cmj/user.png" width="15" class="user-img">마이</a></li>
                </c:if>
                <c:if test="${empty user}">
					<li><a href="${pageContext.request.contextPath}/member/register" class="btn_my"><img src="${pageContext.request.contextPath}/images/cmj/user.png" width="15" class="user-img">회원가입</a></li>          
                </c:if>
                <li><a href="#" class="btn_reserve"><img src="${pageContext.request.contextPath}/images/cmj/reserve.png" width="18" class="ticket-img">바로 예매</a></li>
            </ul>
        </div>
        <div id="nav" class="area__gnbmovingbar">
            <ul>
                <li>
                    <a href="#">예매</a>
                    <div>
                        <ul>
                            <li><a href="#" title="예매하기">예매하기</a></li>
                            <li><a href="#" title="상영시간표">상영시간표</a></li>
                            <li><a href="#" title="할인안내">할인안내</a></li>
                        </ul>
                    </div>
                </li>
                <li>
                    <a href="#">영화</a>
                    <div>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/movie/movieList" title="홈">홈</a></li>
                            <li><a href="#" title="현재상영작">현재상영작</a></li>
                            <li><a href="#" title="상영예정작">상영예정작</a></li>
                        </ul>
                    </div>
                </li>
                <li>
                    <a href="#">영화관</a>
                    <div>
                        <ul>
                            <li class=""><a href="#" title="스페셜관">스페셜관</a></li>
                            <li><a href="#" title="서울">서울</a></li>
                            <li><a href="#" title="경기/인천">경기/인천</a></li>
                            <li><a href="#" title="충청/대전">충청/대전</a></li>
                            <li><a href="#" title="전라/광주">전라/광주</a></li>
                            <li><a href="#" title="경북/대구">경북/대구</a></li>
                            <li><a href="#" title="경남/부산/울산">경남/부산/울산</a></li>
                            <li><a href="#" title="강원">강원</a></li>
                            <li><a href="#" title="제주">제주</a></li>
                        </ul>
                    </div>
                </li>
                <li>
                    <a href="#">이벤트</a>
                    <div>
                        <ul>
                            <li><a href="#" title="홈">홈</a></li>
                            <li><a href="#" title="영화">영화</a></li>
                            <li><a href="#" title="시사회/무대인사">시사회/무대인사</a></li>
                            <li><a href="#" title="제휴할인">제휴할인</a></li>
                        </ul>
                    </div>
                </li>
                <li>
                	<a href="${pageContext.request.contextPath}/board/list">커뮤니티</a>
                	<div>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/board/list?type=movieTalk" title="영화톡톡">영화톡톡</a></li>
                            <li><a href="${pageContext.request.contextPath}/board/list?type=swap">양도/교환</a></li>
                        </ul>
                    </div>
                </li>
                <li><a href="${pageContext.request.contextPath}/shop/shopMain">벌스샵</a></li>
                <li class="wrap_nav_underline"><span class="nav_underline"></span></li>
            </ul>
        </div>
    
        <script>
            document.querySelectorAll('#nav > ul > li').forEach(function(menu) {
                menu.addEventListener('mouseenter', function() {
                    this.querySelector('div').style.display = 'block';
                    this.querySelector('div').style.opacity = 1;
                });
    
                menu.addEventListener('mouseleave', function() {
                    this.querySelector('div').style.display = 'none';
                    this.querySelector('div').style.opacity = 0;
                });
            });
        </script>
    </div>
<!-- 상단 끝 -->





