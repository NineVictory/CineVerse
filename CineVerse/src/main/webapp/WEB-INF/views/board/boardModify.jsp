<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>


<div class="page-container page-main">
	<div class="board-main">
	<h2>글수정</h2>
	<form:form action="update" id="board_modify" enctype="multipart/form-data" modelAttribute="boardVO">
			<form:hidden path="cb_num"/>
			<div class="form-group">
				<div class="category">
					<form:label path="cb_type" class="custom-type">분류</form:label>
					<form:select path="cb_type" id="cb_type" class="custom-type borderR">
						<option value="select" disabled selected>선택하세요</option>
						<form:option value="movieTalk">영화톡톡</form:option>
	            		<form:option value="dailyTalk">일상톡톡</form:option>
					</form:select>
				<form:errors path="cb_type" cssClass="error-color"/>	
				</div>
				<div>
					<form:input path="cb_title" id="cb_title" class="custom-title borderR" placeholder=" 제목을 입력해주세요"/>
					<form:errors path="cb_title" cssClass="error-color"/>
				</div>	
			</div>
			<div>
				<form:textarea path="cb_content" placeholder="내용을 입력해주세요"/>
				<script>
				 function MyCustomUploadAdapterPlugin(editor) {
					    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
					        return new UploadAdapter(loader);
					    }
					}
				 
				 ClassicEditor
		            .create( document.querySelector( '#cb_content' ),{
		            	extraPlugins: [MyCustomUploadAdapterPlugin]
		            })
		            .then( editor => {
						window.editor = editor;
					} )
		            .catch( error => {
		                console.error( error );
		            } );
			    </script>
			    <form:errors path="cb_content" cssClass="error-color"/>
			</div>
			
		<div class="align-center btn-container">
			<form:button class="default-btn1">수정</form:button>
			<input type="button" value="목록" class="default-btn2" onclick="location.href='list'">
		</div>
	</form:form>
	</div>
</div>