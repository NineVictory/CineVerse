<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 상품 등록 시작 -->
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    const myForm = document.getElementById('register_form');
    //이벤트 연결
    myForm.onsubmit = function() {
        const radioGroups = [
            document.querySelectorAll('input[name="p_status"]:checked'),
            document.querySelectorAll('input[name="p_category"]:checked')
        ];

        for (let group of radioGroups) {
            if (group.length < 1) {
                alert('상품 표시 여부, 상품 카테고리는 필수 선택하세요!');
                return false;
            }
        }

        const items = document.querySelectorAll('.input-check');
        for (let i = 0; i < items.length; i++) {
            if (items[i].value.trim() == '') {
                const label = document.querySelector('label[for="'+items[i].id+'"]');
                alert(label.textContent + ' 항목은 필수 입력입니다!');
                items[i].value = '';
                items[i].focus();
                return false;
            }
        }
    };
});
</script>
<h2>상품 등록</h2>
<form action="registerProduct" method="post" enctype="multipart/form-data" id="register_form"> 
	<ul>
		<li>
			<label for="p_radio">상품 표시 여부</label>
			<input type="radio" name="p_status" value="1" id="p_status1">미표시
			<input type="radio" name="p_status" value="2" id="p_status2">표시
		</li>
		<li>
			<label for="p_category">상품 카테고리</label>
			<input type="radio" name="p_category" value="1" id="p_category1"> MARVEL
			<input type="radio" name="p_category" value="2" id="p_category2"> DISNEY
			<input type="radio" name="p_category" value="3" id="p_category3"> DISNEY PRINCESS
			<input type="radio" name="p_category" value="4" id="p_category4"> PIXAR
			<input type="radio" name="p_category" value="5" id="p_category5"> Studio GHIBLI
			<input type="radio" name="p_category" value="6" id="p_category6"> Warner Bros.
			<input type="radio" name="p_category" value="7" id="p_category7"> Universal Studio
			<input type="radio" name="p_category" value="8" id="p_category8"> ETC
			
		</li>
		<li>	
			<label for="p_name">상품명</label>
			<input type="text" name="p_name" id="p_name" maxlength="100" class="input-check">
		</li>
		<li>
			<label for="p_price">가격</label>
			<input type="number" name="p_price" id="p_price" min="1" max="999999999" class="input-check">
 		</li>
		<li>
			<label for="p_quantity">수량</label>
			<input type="number" name="p_quantity" id="p_quantity" min="0" max="9999999" class="input-check">
		</li>
		<li>
			<label for="p_filename">상품사진</label>
			<input type="file" name="p_filename" class="input-check" id="p_filename" accept="image/gif,image/png,image/jpeg">
		</li>
		<li>
			<label for="p_content">상품설명</label>
			<textarea rows="5" cols="30" name="p_content" id="p_content" class="input-check"></textarea>
		</li>
		<li>
			<input type="submit" value="등록">
		</li>
	</ul>
	
</form>
<!-- 상품 등록 끝 -->

<%-- 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
	<h2>상품 등록</h2>
		<form:form action="registerProduct" method="post" enctype="multipart/form-data" id="register_form" modelAttribute="productForm" modelAttribute="productVO"> 
			<ul>
				<li>
					<label for="p_radio">상품 표시 여부</label>
					<form:radiobutton path="p_status" id="p_status1" value="1"/>미표시
					<form:radiobutton path="p_status" id="p_status2" value="2"/>표시
					<form:errors path="p_status" cssClass="error"/>
				</li>
				<li>
					<label for="p_category">상품 카테고리</label>
					<form:radiobutton path="p_category" id="p_category1" value="1"/> MARVEL
					<form:radiobutton path="p_category" id="p_category2" value="2"/> DISNEY
					<form:radiobutton path="p_category" id="p_category3" value="3"/> DISNEY PRINCESS
					<form:radiobutton path="p_category" id="p_category4" value="4"/> PIXAR
					<form:radiobutton path="p_category" id="p_category5" value="5"/> Studio GHIBLI
					<form:radiobutton path="p_category" id="p_category6" value="6"/> Warner Bros.
					<form:radiobutton path="p_category" id="p_category7" value="7"/> Universal Studio
					<form:radiobutton path="p_category" id="p_category8" value="8"/> ETC
					<form:errors path="p_category" cssClass="error"/>
				</li>
				<li>	
					<label for="p_name">상품명</label>
					<form:input type="text" path="p_name" id="p_name" maxlength="100" class="input-check"/>
					<form:errors path="p_name" cssClass="error"/>
				</li>
				<li>
					<label for="p_price">가격</label>
					<form:input type="number" path="p_price" id="p_price" min="1" max="999999999" class="input-check"/>
					<form:errors path="p_price" cssClass="error"/>
		 		</li>
				<li>
					<label for="p_quantity">수량</label>
					<form:input type="number" path="p_quantity" id="p_quantity" min="0" max="9999999" class="input-check"/>
					<form:errors path="p_quantity" cssClass="error"/>
				</li>
				<li>
					<label for="p_filename">상품사진</label>
					<form:input type="file" path="p_filename" class="input-check" id="p_filename" accept="image/gif,image/png,image/jpeg"/>
					<form:errors path="p_filename" cssClass="error"/>
				</li>
				<li>
					<label for="p_content">상품설명</label>
					<form:textarea rows="5" cols="30" path="p_content" id="p_content" class="input-check"/>
					<form:errors path="p_content" cssClass="error"/>
				</li>
				<li>
					<input type="submit" value="등록">
				</li>
			</ul>
		</form:form>
</div>
 --%>