<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 벌스샵 결제 시작 -->
<div class="main_content">
	<div class="buy-main">
		<h2>결제하기</h2>
		<span>배송지 정보</span>
		<%-- <form:form action="shopPay" id="shop_pay" method="post">
		받는 사람  <form:input path="a_name"/>
		연락처 <form:input path="a_phone"/>
		우편번호 <form:input path="a_zipcode"/>
		주소 <form:input path="a_address1"/>
		상세 주소 <form:input path="a_address2"/>
		</form:form> --%>
		<%-- <form action="shopPay" id="shop_pay" method="post">
			<div class="address-form">
				<ul>
					<li>받는 사람  <input type="text" name="a_name"></li>
					<li>연락처 <input type="text" name="a_phone"></li>
					<li>우편번호 <input type="text" name="a_zipcode"></li>
					<li>주소 <input type="text" name="a_address1"></li>
					<li>상세 주소 <input type="text"  name="a_address2"></li>
				</ul>
			</div>
		</form> --%>
	<form action="shopPay" id="shop_pay" method="post">
	    <div class="select-address">
	    	<ul>
		        <li><input type="checkbox" name="address1" id="address1" checked> <span>기본</span></li>
		        <li><input type="checkbox" name="address2" id="address2"> <span>집</span></li>
		        <li><input type="checkbox" name="address3" id="address3"><span>학교</span></li>
	        </ul>
	    </div>
	</form>

<script>
    // JavaScript로 체크박스 제어
    const checkboxes = document.querySelectorAll('.select-address input[type="checkbox"]');
    
    checkboxes.forEach((checkbox) => {
        checkbox.addEventListener('click', function() {
            // 모든 체크박스를 순회하며 현재 클릭된 체크박스 이외의 것들은 체크를 해제한다.
            checkboxes.forEach((cb) => {
                if (cb !== this) {
                    cb.checked = false;
                }
            });
        });
    });
</script>
</div>
	
</div>
<!-- 벌스샵 결제 끝-->
