<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 배송지 관리 시작 -->
<div class="myPage_main">
	<div class="reservation_display">
		<span class="myPage_title_re">배송지 관리</span>
	</div>
	<form:form action="addAddress" id="member_modify" modelAttribute="address">
		<div class="login_form_inputs">
			<div class="login_form_all">
				<div class="login_form_inputs_id_passwd" style="border: none; margin-left: 10px;">
					<input type="radio" id="a_default" name="a_default" value="1">기본
					<input type="radio" id="a_default" name="a_default" value="2">기본 X
				</div>
			</div>
			<div class="login_form_all">
				<div class="login_form_inputs_id_passwd">
					<form:input path="a_name" placeholder="배송지 이름을 입력해주세요"
						class="input_style" autocomplete="off" />
				</div>
				<form:errors element="div" path="a_name" cssClass="error-color" />
			</div>
			<span>우편주소 찾기</span>
			<div class="login_form_all">
				<div class="login_form_inputs_id_passwd">
					<form:input path="a_zipcode" />
					<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"
						class="default-btn">
					<form:errors path="a_zipcode" cssClass="error-color" />
				</div>
			</div>
			<div class="login_form_all">
				<div class="login_form_inputs_id_passwd">
					<form:input path="a_address1" placeholder="주소를 입력해주세요"
						autocomplete="off" />
					<form:errors path="a_address1" cssClass="error-color" />
				</div>
			</div>
			<div class="login_form_all">
				<div class="login_form_inputs_id_passwd">
					<form:input path="address2" placeholder="상세 주소를 입력해주세요"
						autocomplete="off" />
					<form:errors path="address2" cssClass="error-color" />
				</div>
			</div>
			<div class="login_form_all">
				<div class="login_form_inputs_id_passwd">
					<form:input path="a_phone" placeholder="전화번호를 입력해주세요"
						class="input_style" />
				</div>
				<form:errors element="div" path="a_phone" cssClass="error-color" />
			</div>
			<div class="modify_btn_all">
				<input type="submit" value="배송지 추가" class="user_modify_btn">
			</div>
		</div>
	</form:form>
	<div class="myPage_address">
		<c:if test="${count==0}">
            등록된 주소가 없습니다.
        </c:if>
		<c:if test="${count>=1}">
			<c:forEach var="a" items="${address}">
				<c:if test="${a.a_default==1}">
					<!-- 기본 주소 -->
					<div class="my_address_del_modi">
						<div class="my_address_info">
							<div class="myPage_address">
								<span class="my_address_1">${a.a_address1}</span> <span
									class="my_address_2">${a.a_address2}</span> <span
									class="my_address_number">(${a.a_zipcode})</span>
							</div>
							<div>
								<span class="add_del_btn">삭제</span> <span class="add_modi_btn">수정</span>
							</div>
						</div>
					</div>
					<!-- 기본 주소 -->
				</c:if>
				<c:if test="${a.a_default!=1}">
					<!-- 기타 주소 -->
					<div class="my_address_del_modi">
						<div class="my_address_info">
							<div class="myPage_address">
								<span class="my_address_1">${a.a_address1}</span> <span
									class="my_address_2">${a.a_address2}</span> <span
									class="my_address_number">(${a.a_zipcode})</span>
							</div>
							<div>
								<span class="add_del_btn">삭제</span> <span class="add_modi_btn">수정</span>
							</div>
						</div>
					</div>
					<!-- 기타 주소 -->
				</c:if>
			</c:forEach>
		</c:if>
	</div>
</div>
<!-- 배송지 관리 끝 -->
