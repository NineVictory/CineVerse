<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>

<script type="text/javascript">
	window.onload=function(){
		const myForm = document.getElementById('board_modify');
		myForm.onsubmit=function(){
			const type = document.getElementById('cb_type');
			if(type.value.trim() == '' || type.value === 'select'){
				alert('게시물 유형을 선택하세요');
				type.value = '';
				type.focus();
				return false;
			}
			const title = document.getElementById('cb_title');
			if(title.value.trim() == ''){
				alert('제목을 입력하세요');
				title.value = '';
				title.focus();
				return false;
			}
			const content = document.getElementById('cb_content');
			if(content.value.trim() == ''){
				alert('내용을 입력하세요');
				content.value = '';
				content.focus();
				return false;
			}
		};
	};

</script>

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
				</div>
				<form:errors path="cb_type" cssClass="error-color"/>
				<form:input path="cb_title" id="cb_title" class="custom-title borderR" placeholder=" 제목을 입력해주세요"/>
				<form:errors path="cb_title" cssClass="error-color"/>
			</div>
			<div>
				<form:textarea path="cb_content" placeholder="내용을 입력해주세요"/>
				<form:errors path="cb_content" cssClass="error-color"/>
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
			</div>
			
		<div class="align-center btn-container">
			<form:button class="default-btn1">수정</form:button>
			<input type="button" value="목록" class="default-btn2" onclick="location.href='list'">
		</div>
	</form:form>
	</div>
</div>