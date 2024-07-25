<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/report.form.css" type="text/css">


<div class="report-form">
	<h3>신고하기</h3>
	<hr size="1" width="100%;">
	<div class="flexbox-p">
		<div class="report-info"><label>작성자</label><span>${param.writer}</span></div>
		<div class="report-info"><label>내용</label><span>${param.ab_title}</span></div>
	</div>
	<hr size="1" width="100%;">
	<form action="submitAssignReport" method="post" id="reportForm">
		<input type="hidden" name="mem_num" value="${param.user_num}">
		<input type="hidden" name="ab_num" value="${param.ab_num}">
		<label for="ar_category">신고사유</label>
		<div class="flexbox-p">
         <span><input type="radio" name="ar_category" value="1">스팸홍보/도배</span>
         <span><input type="radio" name="ar_category" value="2">음란물</span>
         <span><input type="radio" name="ar_category" value="3">불법정보</span>
         <span><input type="radio" name="ar_category" value="4">청소년에게 유해한 내용</span>
         <span><input type="radio" name="ar_category" value="5">욕설/생명경시/혐오/차별적 표현</span>
         <span><input type="radio" name="ar_category" value="6">개인정보 노출</span>
         <span><input type="radio" name="ar_category" value="7">불쾌한 표현</span>
         <span><input type="radio" name="ar_category" value="8">기타</span>
        </div>
        <label for="ar_content">신고내용(선택)</label>
        <textarea id="ar_content" name="ar_content"></textarea><br><br>

        <input type="submit" class="report-submit" value="신고하기">
    </form>
    
</div>