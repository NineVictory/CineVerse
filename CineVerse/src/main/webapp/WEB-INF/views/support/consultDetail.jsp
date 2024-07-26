<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/consult.form.js"></script>

<!-- 1:1 문의 -->
<div id="support_main" class="">
	<h3>1:1 문의</h3>
	<div class="qna-member-info">
		<div class="member-info-gap"><span class="info-label">이름</span><span>${user.mem_name}</span></div>
		<div class="flexbox-h phone-email">
			<div class="member-info-gap">
			<span class="info-label">휴대전화</span>${user.mem_phone}<span></span>
			</div>
			<div class="member-info-gap">
			<span class="info-label">이메일</span><span>${user.mem_email}</span>
			</div>
		</div>
	</div>
	
	
	<div class="consultDetail-main">
	
		<div class="c-category">
			<div>
			<span class="c-label">문의유형</span>
			<span class="ctype">
				<c:if test="${consult.consult_type == 'inquiry'}">문의</c:if>
				<c:if test="${consult.consult_type == 'dissatisfaction'}">불만</c:if>
				<c:if test="${consult.consult_type == 'compliment'}">칭찬</c:if>
				<c:if test="${consult.consult_type == 'proposal'}">제안</c:if>
				<c:if test="${consult.consult_type == 'missing'}">분실물</c:if>
				<c:if test="${consult.consult_type == 'exchange'}">교환/환불</c:if>
			</span>
			</div>
			<c:if test="${!empty consult.od_number}">
			<span class="c-label">주문번호</span> <a href="${pageContext.request.contextPath}/myPage/boughtDetail?order_num=${consult.order_num}" class="corder-num">${consult.od_number}</a>
			</c:if>	
		</div>
		
		<div class="c-tc">
			<div class="cquestion">
				<div class="ctitle"><img src="${pageContext.request.contextPath}/images/kbm/question_icon.png" width="25px;" height="24px;"><h3 style="display:inline-block;">${consult.consult_title}</h3></div>
	
				<hr size="1" width="100%" class="c-hr">
				
				<div class="ccontent">
					<c:if test="${!empty consult.consult_file}">
					<div><img src="${pageContext.request.contextPath}/upload/${consult.consult_file}" style="max-height:300px;"></div>
					</c:if>
					${consult.consult_content}
				</div>
			</div>
			
			<c:if test="${!empty consult.consult_answer}">
			<div class="canswer">
				<div class="ccon"><img src="${pageContext.request.contextPath}/images/kbm/arrow.png" width="30px;" height="30px;"><h3 style="display:inline-block;">답변</h3></div>
				<hr size="1" width="100%" class="c-hr">
				<div class="ccontent">${consult.consult_answer}</div>
			</div>
			</c:if>
			
			<hr size="1" width="100%" class="c-hr">
			
			<div class="toList">
				<input type="button" value="목록" class="default-btn4" onclick="location.href='consultList'">
			</div>
		</div>
	</div>
</div>