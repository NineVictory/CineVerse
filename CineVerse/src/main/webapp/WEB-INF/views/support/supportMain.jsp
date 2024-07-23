<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/support.main.js"></script>

<!-- 고객센터 메인 -->
<div id="support_main" class="flexbox-p">
	<div class="flexbox-h main-upper-menu">
		<div class="flexbox-p fast-menu">
			<img src="${pageContext.request.contextPath}/images/kbm/faq.png" width="38">
			<div class="fast-menu-cont flexbox-p">
				<strong>자주 묻는 질문 빠른 검색</strong>
				<div id="search_box">
					<input type="text" class="faq-keyword" class="font14">
					<button title="검색하기" class="faq-mbutton" class="font11">검색</button>
				</div>
			</div>
		</div>
		<div class="flexbox-p fast-menu">
			<img src="${pageContext.request.contextPath}/images/kbm/qna.png" width="48">
			<div class="fast-menu-cont flexbox-p">
				<strong>1:1 문의</strong>
				<span class="font14">24시간 365일 언제든지 문의해주세요</span>
				<a href="consult" class="font14">문의하기</a>
			</div>
		</div>
		<div class="flexbox-p fast-menu">
			<img src="${pageContext.request.contextPath}/images/kbm/file_fill.png" width="37">
			<div class="fast-menu-cont flexbox-p">
				<strong>내 상담 내역 확인</strong>
				<span class="font14">문의하신 내용을 확인하실 수 있습니다</span>
				<a href="${pageContext.request.contextPath}/myPage/consult" target="_blank" rel="noopener noreferrer" class="font14">문의내역 조회</a>
			</div>
		</div>
	</div>
	<div class="flexbox-h main-lower-menu flex-start">
		<div class="left-lower-menu">
			<h4>자주찾는 서비스</h4>
			<div class="imenu">
			 <c:if test="${empty user}">
		        <a href="${pageContext.request.contextPath}/member/findId">
		            <span>아이디/<br>비밀번호 찾기 ></span>
		        </a>
		    </c:if>
		    <c:if test="${!empty user}">
		        <a>
		            <span class="disabled">아이디/<br>비밀번호 찾기 ></span>
		        </a>
		    </c:if>
			<%--<a href="${pageContext.request.contextPath}/member/findId" data-user="${user}" class="loginCheck-findId"><span>아이디/<br>비밀번호 찾기 ></span></a>--%>
				<a href="${pageContext.request.contextPath}/myPage/reservation" target="_blank" rel="noopener noreferrer"><span>예매/<br>취소내역 확인 ></span></a>
				<a href="${pageContext.request.contextPath}/myPage/pointList" target="_blank" rel="noopener noreferrer"><span>멤버십 포인트<br> 내역 ></span></a>
				<a href="${pageContext.request.contextPath}/myPage/coupon" target="_blank" rel="noopener noreferrer"><span>관람권/<br>할인 쿠폰 ></span></a>
			</div>
		</div>
		<div class="right-lower-menu">
			<div class="main-news"><h4 style="display:inline-block;">공지/뉴스</h4> &nbsp;<img src="${pageContext.request.contextPath}/images/kbm/plus2.png" width="24px;" height="24px;"onclick="location.href='notice'"></div>
			<table>
				<c:if test="${count > 0}">
					<c:forEach items="${list}" var="notice" varStatus="status">
					    <c:if test="${status.index < 5}">
					        <tr>
								<td>

									<c:choose>
					                    <c:when test="${fn:length(notice.nb_title) > 40}">
					                        <a class="main-notice-title" href="noticeDetail?nb_num=${notice.nb_num}">${fn:substring(notice.nb_title, 0, 40)}...</a>
					                    </c:when>
					                    <c:otherwise>
					                        <a class="main-notice-title" href="noticeDetail?nb_num=${notice.nb_num}">${notice.nb_title}</a>
					                    </c:otherwise>
					                </c:choose>

									<span>${notice.nb_reg_date}</span>
								</td>
							</tr>
					    </c:if>
					</c:forEach>
				</c:if>
				<c:if test="${count == 0}"><tr><td><span>공지사항이 없습니다.</span></td></tr></c:if>	
			</table>
		</div>
	</div>
</div>