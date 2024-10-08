<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/addressList.js"></script>
<!-- 배송지 관리 시작 -->
<div class="myPage_main">
	<div class="reservation_display">
		<span class="myPage_title_re">배송지 관리</span>
	</div>
	<form:form action="addressList" id="member_modify"
		modelAttribute="addressVO" method="post">
		<div class="login_form_inputs_my">
			<div class="login_form_all_my">
				<div class="login_form_inputs_id_passwd_my"
					style="border: none; margin-left: 10px;">
					<input type="radio" id="a_default" name="a_default" value="1">기본
					<input type="radio" id="a_default" name="a_default" value="2">기본
					X
				</div>
			</div>
			<div class="login_form_all_my">
				<div class="login_form_inputs_id_passwd_my">
					<form:input path="a_name" placeholder="배송지 이름을 입력해주세요"
						class="input_style" autocomplete="off" />
				</div>
				<form:errors element="div" path="a_name" cssClass="error-color" />
			</div>
			<div class="login_form_all_my">
				<div class="login_form_inputs_id_zipcode_my">
					<form:input path="a_zipcode" id="zipcode"
						placeholder="우편번호를 입력해주세요" class="input_zipcode_my"
						autocomplete="off" />
					<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"
						class="zipcode-btn_my">
				</div>
				<form:errors element="div" path="a_zipcode" cssClass="error-color" />
			</div>
			<div class="login_form_all_my">
				<div class="login_form_inputs_id_passwd_my">
					<form:input path="a_address1" id="address1"
						placeholder="주소를 입력해주세요" class="input_style" autocomplete="off" />
				</div>
				<form:errors element="div" path="a_address1" cssClass="error-color" />
			</div>
			<div class="login_form_all_my">
				<div class="login_form_inputs_id_passwd_my">
					<form:input path="a_address2" id="address2"
						placeholder="상세 주소를 입력해주세요" class="input_style" autocomplete="off" />
				</div>
				<form:errors element="div" path="a_address2" cssClass="error-color" />
			</div>
			<div class="login_form_all_my">
				<div class="login_form_inputs_id_passwd_my">
					<form:input path="a_phone" placeholder="전화번호를 입력해주세요(-하이픈 제외)"
						class="input_style" />
				</div>
				<form:errors element="div" path="a_phone" cssClass="error-color" />
			</div>
			<div class="modify_btn_all_my">
				<input type="submit" value="배송지 추가" class="user_modify_btn">
			</div>
		</div>
	</form:form>

	<div class="myPage_address">
		<c:if test="${count == 0}">
            <div class="empty_position"></div>
        </c:if>
		<c:if test="${count >= 1}">
			<c:forEach var="a" items="${addressList}">
				<c:if test="${a.a_status == 1}">
					<c:if test="${a.a_default == 1}">
						<!-- 기본 주소 -->
						<div class="my_address_del_modi">
							<div class="my_address_info">
								<div class="myPage_address">
									<span class="my_address_1">${a.a_address1}</span> <span
										class="my_address_2">${a.a_address2}</span> <span
										class="my_address_number">(${a.a_zipcode})</span>
								</div>
								<div class="add_btn">
									<input type="button" class="add_del_btn" data-num="${a.a_num}"
										value="삭제">
								</div>
							</div>
						</div>
						<!-- 기본 주소 -->
					</c:if>
					<c:if test="${a.a_default != 1}">
						<!-- 기타 주소 -->
						<div class="my_address_del_modi">
							<div class="my_address_info">
								<div class="myPage_address">
									<span class="my_address_1">${a.a_address1}</span> <span
										class="my_address_2">${a.a_address2}</span> <span
										class="my_address_number">(${a.a_zipcode})</span>
								</div>
								<div class="add_btn">
									<input type="button" class="add_del_btn" data-num="${a.a_num}"
										value="삭제">
								</div>
							</div>
						</div>
						<!-- 기타 주소 -->
					</c:if>
				</c:if>
			</c:forEach>
		</c:if>
	</div>
	<script>
		document
				.addEventListener(
						"DOMContentLoaded",
						function() {
							const radios = document
									.getElementsByName('a_default');
							let isChecked = false;
							for (let i = 0; i < radios.length; i++) {
								if (radios[i].checked) {
									isChecked = true;
									break;
								}
							}
							if (!isChecked) {
								document
										.querySelector('input[name="a_default"][value="2"]').checked = true;
							}
						});
	</script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
	<!-- 우편번호 시작 -->
	<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
	<div id="layer"
		style="display: none; position: fixed; overflow: hidden; z-index: 1; -webkit-overflow-scrolling: touch;">
		<img src="//t1.daumcdn.net/postcode/resource/images/close.png"
			id="btnCloseLayer"
			style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1"
			onclick="closeDaumPostcode()" alt="닫기 버튼">
	</div>

	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		// 우편번호 찾기 화면을 넣을 element
		var element_layer = document.getElementById('layer');

		function closeDaumPostcode() {
			// iframe을 넣은 element를 안보이게 한다.
			element_layer.style.display = 'none';
		}

		function execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 각 주소의 노출 규칙에 따라 주소를 조합한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var addr = ''; // 주소 변수
							var extraAddr = ''; // 참고항목 변수

							//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
							if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
								addr = data.roadAddress;
							} else { // 사용자가 지번 주소를 선택했을 경우(J)
								addr = data.jibunAddress;
							}

							// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
							if (data.userSelectedType === 'R') {
								// 법정동명이 있을 경우 추가한다. (법정리는 제외)
								// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
								if (data.bname !== ''
										&& /[동|로|가]$/g.test(data.bname)) {
									extraAddr += data.bname;
								}
								// 건물명이 있고, 공동주택일 경우 추가한다.
								if (data.buildingName !== ''
										&& data.apartment === 'Y') {
									extraAddr += (extraAddr !== '' ? ', '
											+ data.buildingName
											: data.buildingName);
								}
								// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
								if (extraAddr !== '') {
									extraAddr = ' (' + extraAddr + ')';
								}
								//(주의)address1에 참고항목이 보여지도록 수정
								// 조합된 참고항목을 해당 필드에 넣는다.
								//(수정) document.getElementById("address2").value = extraAddr;

							}
							//(수정) else {
							//(수정)    document.getElementById("address2").value = '';
							//(수정) }

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('zipcode').value = data.zonecode;
							//(수정) + extraAddr를 추가해서 address1에 참고항목이 보여지도록 수정
							document.getElementById("address1").value = addr
									+ extraAddr;
							// 커서를 상세주소 필드로 이동한다.
							document.getElementById("address2").focus();

							// iframe을 넣은 element를 안보이게 한다.
							// (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
							element_layer.style.display = 'none';
						},
						width : '100%',
						height : '100%',
						maxSuggestItems : 5
					}).embed(element_layer);

			// iframe을 넣은 element를 보이게 한다.
			element_layer.style.display = 'block';

			// iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
			initLayerPosition();
		}

		// 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
		// resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
		// 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
		function initLayerPosition() {
			var width = 300; //우편번호서비스가 들어갈 element의 width
			var height = 400; //우편번호서비스가 들어갈 element의 height
			var borderWidth = 5; //샘플에서 사용하는 border의 두께

			// 위에서 선언한 값들을 실제 element에 넣는다.
			element_layer.style.width = width + 'px';
			element_layer.style.height = height + 'px';
			element_layer.style.border = borderWidth + 'px solid';
			// 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
			element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width) / 2 - borderWidth)
					+ 'px';
			element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height) / 2 - borderWidth)
					+ 'px';
		}
	</script>
	<!-- 우편번호 끝 -->
</div>
<!-- 배송지 관리 끝 -->
