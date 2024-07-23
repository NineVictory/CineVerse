<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 자주 묻는 질문 -->
<div id="support_main" class="">
	<h3>공지/뉴스</h3>
	<div class="news-sub-info">
		CINEVERSE의 주요한 이슈 및 여러가지 소식들을 확인하실 수 있습니다.
	</div>
	
	<div>
	<div class="notice-title flexbox-h side">
		<span>${notice.nb_title}</span>
		<div class="rdate-hit">
			<div><span>등록일</span><span class="rh">${notice.nb_reg_date}</span></div>
			<div><span>조회수</span><span class="rh">${notice.nb_hit}</span></div>
		</div>
	</div>
	
	</div>
	<div class="notice-content">${notice.nb_content}</div>
	
<!-- 	<hr size="1" width="100%" class="notice-detail-hr"> -->
	<div class="align-right notice-list-btn">
		<input type="button" value="목록" onclick="location.href='notice'">
	</div>
</div>