<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/myPage.password.js"></script>
<!-- 비밀번호 변경 시작 -->
<div class="myPage_main">
	<div class="reservation_display">
		<span class="myPage_title_re">비밀번호 변경</span>
	</div>									  
	<form:form action="passwdChange" id="member_change" modelAttribute="myPageVO">
	<ul>
		<li>
			<form:label path="now_passwd">현재 비밀번호</form:label>
			<form:password path="now_passwd" placeholder="영문,숫자만 4~12자"/>
			<form:errors path="now_passwd" cssClass="error-color"/>
		</li>
		<li>
			<form:label path="mem_passwd">변경할 비밀번호</form:label>
			<form:password path="mem_passwd" placeholder="영문,숫자만 4~12자"/>
			<form:errors path="mem_passwd" cssClass="error-color"/>
		</li>
		<li>
			<label for="confirm_passwd">비밀번호 확인</label>
			<input type="password" id="confirm_passwd">
			<div id="message_password"></div>
		</li>
<%-- 		<li>
			<div id="captcha_div">
				<img src="getCaptcha" id="captcha_img" width="200" height="90">
			</div>
			<input type="button" value="새로고침" id="reload_btn">
			<script type="text/javascript">
				$(function(){
					$('#reload_btn').click(function(){
						$.ajax({
							url: 'getCaptcha',
							type: 'get',
							success: function(){
																				// 공백으로 구분 (공백이 없으면 전체 페이지가 리스타트)
								$('#captcha_div').load(location.href + ' #captcha_div');	
							},
							error:function(){
								alert('네트워크 오류 발생')
							}
						})
					});
				});
			</script>
		</li>
		<li>
			<form:label path="captcha_chars">캡챠 문자 확인</form:label>
			<form:input path="captcha_chars"/>
			<form:errors path="captcha_chars" cssClass="error-color"/>
		</li>	 --%>	
	</ul>
	<div class="align-center">
		<form:button class="default-btn">변경하기</form:button>
		<input type="button" value="마이페이지" class="default-btn" onclick="location.href='${pageContext.request.contextPath}/myPage/myPageMain'">
	</div>
	</form:form>

</div>
<!-- 비밀번호 끝 -->