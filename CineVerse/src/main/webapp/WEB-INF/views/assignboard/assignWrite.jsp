<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>

<script type="text/javascript">
	window.onload=function(){
		const myForm = document.getElementById('assignboard_register');
		myForm.onsubmit=function(){
			const type = document.getElementsByName('ab_type');
			var typeValid = false;
		    for (var i = 0; i < type.length; i++) {
				if (type[i].checked) {
					typeValid = true;
					break;
				}
			}
			if (!typeValid) {
				alert('카테고리를 선택하세요');
				return false;
			}
						
			
			/* const type = document.getElementById('ab_type');
			if(type.value.trim() == '' || type.value === 'select'){
				alert('카테고리를 선택하세요');
				type.value = '';
				type.focus();
				return false;
			} */
			const file = document.getElementById('ab_filename');
			if(file.value.trim() == ''){
				alert('상품이미지를 선택하세요');
				file.value = '';
				file.focus();
				return false;
			}
			
			const title = document.getElementById('ab_title');
			if(title.value.trim() == ''){
				alert('상품명을 입력하세요');
				title.value = '';
				title.focus();
				return false;
			}
						
			const radios = document.getElementsByName('ab_item_status');
			var formValid = false;
		    for (var i = 0; i < radios.length; i++) {
				if (radios[i].checked) {
					formValid = true;
					break;
				}
			}
			if (!formValid) {
				alert('상품상태를 선택하세요');
				return false;
			}
			/* document.getElementById('error-message').style.display = 'block';
			        return false; // 폼 제출 방지 */

			const content = document.getElementById('ab_content');
			if(content.value.trim() == ''){
				alert('상품설명을 입력하세요');
				content.value = '';
				content.focus();
				return false;
			}
			
			const price = document.getElementById('ab_price');
			if(price.value.trim() == ''){
				alert('가격을 입력하세요');
				price.value = '';
				price.focus();
				return false;
			}
		};
	};

</script>

<div class="page-container page-main">
	<div class="board-main">
	<h2>상품등록</h2>
	
	<hr size="1" width="100%">
	<form:form action="write" id="assignboard_register" enctype="multipart/form-data" modelAttribute="assignVO">
		<div class="상품정보">
			<div class="flexbox-h info-container">
				<div class="item-label">카테고리</div>
				<div class="">

					<form:radiobutton path="ab_type" value="handover" />양도

					<form:radiobutton path="ab_type" value="exchange" />교환

				</div>
			</div>
		
			<div class="flexbox-h">
				<div class="item-label">
					상품이미지
					<small>(0/3)</small>
				</div>
				<div class="flexbox-p">
				<ul>
					<li>
						이미지 등록(아이콘 변경 예정)
						<input type="file" name="ab_filename" id="ab_filename" accept="image/jpg, image/jpeg, image/png" multiple>
					</li>
				</ul>
				<div>상품 이미지는 1:1로 보여집니다.</div>
				</div>
			</div>
			<div class="flexbox-h">
				<div class="item-label">
					상품명
				</div>
				<div>
					<div class="divcontainer">
						<form:input path="ab_title" id="ab_title" class="custom-title borderR" placeholder="상품명을 입력해주세요"/>
						<form:errors path="ab_title" cssClass="error-color"/>
					</div>
					<div class="divcontainer">
						(0/40)
					</div>
				</div>
			</div>
			<div class="flexbox-h">
				<div class="item-label">
					상품상태
				</div>
				<div class="">
					<div>
					<form:radiobutton path="ab_item_status" value="0" />새 상품(미사용)<span>사용하지 않은 새 상품</span>
					</div>
					<div>
					<form:radiobutton path="ab_item_status" value="1" />사용감 없음<span>사용은 했지만 눈에 띄는 흔적이나 얼룩이 없음</span>
					</div>
					<div>
					<form:radiobutton path="ab_item_status" value="2" />사용감 적음<span>눈에 띄는 흔적이나 얼룩이 약간 있음</span>
					</div>
					<div>
					<form:radiobutton path="ab_item_status" value="3" />사용감 많음<span>눈에 띄는 흔적이나 얼룩이 많이 있음</span>
					</div>
					<div>
					<form:radiobutton path="ab_item_status" value="4" />고장/파손 상품<span>기능 이상이나 외관 손상 등으로 수리/수선 필요</span>
					</div>
				</div>
			</div>
			<div class="flexbox-h">
				<div class="item-label">
					설명
				</div>
				<div>
					<textarea name="ab_content" id="ab_content" rows="9" cols="120" placeholder="구매시기, 하자 유무 등 상품 설명을 최대한 자세히 적어주세요.
전화번호, SNS계정 등 개인정보 입력은 제한될 수 있어요."></textarea>
				</div>
			</div>
			
		</div>
		<hr size="1" width="100%">
		<div>
			<div class="flexbox-h">
				<div class="item-label">
					가격
				</div>
				<input type="number" name="ab_price" id="ab_price" placeholder=" 가격을 입력해주세요" value=""
   					 oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
			</div>
		</div>
		
		<hr size="1" width="100%">
		
		<div class="flexbox-h side">
			<input type="button" value="목록" class="default-btn2" onclick="location.href='list'">
			<form:button class="default-btn1">등록</form:button>
		</div>
	</form:form>
	</div>
</div>