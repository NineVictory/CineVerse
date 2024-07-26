<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 게시판 글쓰기 시작 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>


<div class="page-container">
<div class="event_modify_form">
	<h2>이벤트 수정</h2>
	<form:form action="adminEventModify" enctype="multipart/form-data" id="modifyEvent_form" modelAttribute="eventVO">
	<input type="hidden" name="event_num" value="${eventVO.event_num}">
	<ul>
		<li>	
			<label for="event_name">제목</label>
			<form:input path="event_name" class="input-check" value="${eventVO.event_name}"/>
			<form:errors path="event_name" element="div" cssClass="error-message"></form:errors>
		</li>
		<li>	
			<label for="event_name">분류</label>
			<form:select path="event_type" class="input-check">
				<form:option value="1">영화</form:option>
				<form:option value="2">시사회/무대인사</form:option>
				<form:option value="3">제휴할인</form:option>
			</form:select>
			<form:errors path="event_type" element="div" cssClass="error-message"></form:errors>
		</li>
		<li>
			<label for="event_upload">사진</label>
			<input type="file" name="event_upload" id="event_upload" class="input-check" accept="image/gif,image/png,image/jpeg">
			<form:errors path="event_upload" element="div" cssClass="error-message"></form:errors>
			<c:if test="${!empty eventVO.event_filename}">
				<div id="file_detail">
					(${eventVO.event_filename})파일이 등록되어 있습니다.
				</div>
				</c:if>
		</li>
		<div class="dates_all">
		<li>
			<label for="event_start">시작일</label>
			<input type="date" name="event_start" id="event_start" class="input-check">
			<form:errors path="event_start" element="div" cssClass="error-message"></form:errors>
 		</li>
		<li>
			<label for="event_end">마감일</label>
			<input type="date" name="event_end" id="event_end" class="input-check">
			<form:errors path="event_end" element="div" cssClass="error-message"></form:errors>
		</li>
		</div>
		<li>
			<label for="event_content">내용</label>
			<form:textarea rows="5" cols="30" path="event_content" class="input-check"/>
			<form:errors path="event_content" element="div" cssClass="error-message"></form:errors>
			<script>
				 function MyCustomUploadAdapterPlugin(editor) {
					    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
					        return new UploadAdapter(loader);
					    }
					}
				 
				 ClassicEditor
		            .create( document.querySelector( '#event_content' ),{
		            	extraPlugins: [MyCustomUploadAdapterPlugin]
		            })
		            .then( editor => {
						window.editor = editor;
					} )
		            .catch( error => {
		                console.error( error );
		            } );
			    </script> 
		</li>
		
	</ul>
	<div class="btn_display_set">
		<form:button id="submit_btn">등록하기</form:button>
	</div>
</form:form>
	
</div>
</div>

