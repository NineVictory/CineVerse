<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 자주 찾는 질문 -->
<div id="support_main" class="">
	<h3>공지/뉴스</h3>
	<div class="faq-sub-info">
		회원님들께서 가장 자주하시는 질문을 모았습니다.<br>
		궁금하신 내용에 대해 검색해보세요.
	</div>
	
	<div>
	<div class="faq-title flexbox-h side">
		<span>${faq.f_title}</span>
		<div class="rdate-hit">
			<div><span>등록일</span><span class="rh">${faq.f_reg_date}</span></div>
			<div><span>조회수</span><span class="rh">${faq.f_hit}</span></div>
		</div>
	</div>
	
	</div>
	<div class="faq-content">${faq.f_content}</div>
	
<!-- 	<hr size="1" width="100%" class="faq-detail-hr"> -->
	<div class="align-right notice-list-btn">
		<input type="button" value="목록" onclick="location.href='faq'">
	</div>
</div>