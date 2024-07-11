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
	<form:form action="write" id="qna_register" enctype="multipart/form-data"><%-- modelAttribute="" --%>
		<div class="회원정보">
		
		
		</div>
		<div class="주의">
		
		</div>
		
		<div class="문의상세">
		
			<div class="flexbox-h">
				<div class="item-label p-center">문의유형</div>
				<div class="p-center">

					<form:radiobutton path="ab_type" value="handover" />문의
					&nbsp;
					<form:radiobutton path="ab_type" value="exchange" />불만
					&nbsp;
					<form:radiobutton path="ab_type" value="exchange" />칭찬
					&nbsp;
					<form:radiobutton path="ab_type" value="exchange" />제안
					&nbsp;
					<form:radiobutton path="ab_type" value="exchange" />분실물

				</div>
			</div>
			
			<div class="flexbox-h">
				<div class="item-label p-center">영화관 선택</div>
				<div class="p-center">

					<form:radiobutton path="ab_type" value="handover" />선택하지 않음
					&nbsp;
					<form:radiobutton path="ab_type" value="exchange" />선택함
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
			<div>
				제목
				<form:input path="title" id="title" class="custom-title borderR" placeholder=" 제목을 입력해 주세요"/>
				<form:errors path="cb_title" cssClass="error-color"/>
			</div>
			<div>
				내용
				<form:textarea path="content" placeholder="※문의 내용 및 첨부파일 내에 개인정보(신용카드번호, 계좌번호, 주민번호 등)가 포함되지 않도록 유의하시기 바랍니다.
※이벤트 굿즈 재고 문의 안내
  경품 특성상 실시간으로 소진되어 재고 안내가 어려운 관계로 문의 글에 대한 답변이 어렵습니다."/>
				<form:errors path="content" cssClass="error-color"/>
				 
			</div>
			<div>
				첨부파일
				<input type="file">
				<form:errors path="cb_title" cssClass="error-color"/>
				<span><b>*첨부가능 확장자</b>: 이미지(jpg,gif,png,jpeg), 워드문서(hwp,ppt,pptx,xls,xlsx,doc,docx,zip,pdf,txt)</span>
			</div>
		</div>
		<div class="align-center btn-container">
			<form:button class="default-btn1">등록</form:button>
			<input type="button" value="목록" class="default-btn2" onclick="location.href='list'">
		</div>
	</form:form>
	
</div>