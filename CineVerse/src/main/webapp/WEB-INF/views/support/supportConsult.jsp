<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- 1:1 문의 -->
<div id="support_main" class="">
	<h3>1:1 문의</h3>
	<div class="faq-sub-info">
		자주 찾는 질문에서 원하는 답변을 찾지 못하셨군요.<br>
		불편사항이나 문의사항을 남겨주시면 최대한 신속하게 답변 드리겠습니다.
	</div>

	<div class="qna-member-info">
		<div class="align-right check-info">체크(<span class="font-red">*</span>)된 항목은 필수 입력 사항입니다.</div>
		<div class="member-info-gap"><span class="info-label">이름</span><span>홍길동</span></div>
		<div class="flexbox-h phone-email">
			<div class="member-info-gap">
			<span class="info-label">휴대전화</span><span>010-****-1234</span>
			</div>
			<div class="member-info-gap">
			<span class="info-label">이메일</span><span>test@test.com</span>
			</div>
		</div>
	</div>
	
	<div class="warning flexbox-h">

			<img src="${pageContext.request.contextPath}/images/kbm/heart01.png" width="25px;" height="25px">
			<div>
				고객님의 문의에 답변하는 직원은 <span class="font-red">고객 여려분의 가족 중 한 사람</span>일 수 있습니다.
				<p>
				CINEVERSE는 고객의 언어폭력(비하, 욕설, 반말, 성희롱 등)으로부터 고객상담지원을 보호하기 위해<br>
				관련 법에 따라 수사기관에 필요한 조치를 요구할 수 있으며, 형법에 의해 처벌 대상이 될 수 있습니다.
			</div>

	</div>
	
	<form:form action="write" id="qna_register" enctype="multipart/form-data" modelAttribute="consultVO">
		
		<div class="문의상세">
		
			<div class="flexbox-h form-items">
				<div class="form-label p-center">문의유형&nbsp;<span class="font-red">*</span></div>
				<div class="p-center">

					<form:radiobutton path="consult_type" value="inquiry" />문의
					&nbsp;
					<form:radiobutton path="consult_type" value="dissatisfaction" />불만
					&nbsp;
					<form:radiobutton path="consult_type" value="compliment" />칭찬
					&nbsp;
					<form:radiobutton path="consult_type" value="proposal" />제안
					&nbsp;
					<form:radiobutton path="consult_type" value="missing" />분실물

				</div>
			</div>
			
			<div class="flexbox-h form-items">
				<div class="form-label p-center">영화관 선택</div>
				<div class="p-center">

					<form:radiobutton path="cinema" value="none"/>선택하지 않음
					&nbsp;
					<form:radiobutton path="cinema" value="selected" />선택함
					&nbsp;
					
					<form:select path="" id="" class="">
						<option value="select" disabled selected>지역선택</option>
						<form:option value="1">1</form:option>
	            		<form:option value="2">2</form:option>
					</form:select>
					
					<form:select path="" id="" class="">
						<option value="select" disabled selected>영화관 선택</option>
						<form:option value="1">1</form:option>
	            		<form:option value="2">2</form:option>
					</form:select>

				</div>
			</div>
			<div class="flexbox-h form-items">
				<div class="form-label">제목&nbsp;<span class="font-red">*</span></div>
				<form:input path="consult_title" class="custom-title" placeholder=" 제목을 입력해 주세요"/>
				<form:errors path="consult_title" cssClass="error-color"/>
			</div>
			<div class="flexbox-h form-items">
				<div class="form-label">내용&nbsp;<span class="font-red">*</span></div>
				<form:textarea path="consult_content" placeholder="※문의 내용 및 첨부파일 내에 개인정보(신용카드번호, 계좌번호, 주민번호 등)가 포함되지 않도록 유의하시기 바랍니다.
※이벤트 굿즈 재고 문의 안내
  경품 특성상 실시간으로 소진되어 재고 안내가 어려운 관계로 문의 글에 대한 답변이 어렵습니다."/>
				<form:errors path="consult_content" cssClass="error-color"/>
				 
			</div>
			<div class="flexbox-h form-items">
				<div class="form-label">첨부파일</div>
				<div class="file-info">
					<input type="file" name="consult_file" id="consult_file">
					<form:errors path="consult_file" cssClass="error-color"/>
					<div><b>*첨부가능 확장자</b>: 이미지(jpg,gif,png,jpeg), 워드문서(hwp,ppt,pptx,xls,xlsx,doc,docx,zip,pdf,txt)</div>
				</div>
			</div>
		</div>
		<div class="flexbox-h side btn-container">
			<input type="button" value="목록" class="default-btn4" onclick="location.href='list'">
			<form:button class="default-btn3">등록</form:button>
		</div>
	</form:form>
	
</div>