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
<div class="notice_modify_form">
		<h2>공지사항 수정</h2>
	<form:form action="adminNoticeModify" enctype="multipart/form-data" id="modifyNotice_form" modelAttribute="noticeVO">
	<input type="hidden" name="nb_num" value="${noticeVO.nb_num}">
	<ul>
		<li>	
			<label for="nb_title">제목</label>
			<form:input path="nb_title" class="input-check"/>
			<form:errors path="nb_title" element="div" cssClass="error-message"></form:errors>
		</li>
		<li>
			<label for="nb_upload">사진</label>
			<input type="file" name="nb_upload" id="nb_upload" class="input-check" accept="image/gif,image/png,image/jpeg">
			<form:errors path="nb_upload" element="div" cssClass="error-message"></form:errors>
			<c:if test="${!empty nbVO.nb_filename}">
				<div id="file_detail">
					(${noticeVO.nb_filename})파일이 등록되어 있습니다.
				</div>
		</c:if>
		</li>
		<li>
			<label for="nb_content">내용</label>
			<form:textarea rows="5" cols="30" path="nb_content" class="input-check"/>
			<form:errors path="nb_content" element="div" cssClass="error-message"></form:errors>
			<script>
				 function MyCustomUploadAdapterPlugin(editor) {
					    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
					        return new UploadAdapter(loader);
					    }
					}
				 ClassicEditor
		            .create( document.querySelector( '#nb_content' ),{
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

