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
<div class="movie_modify_form">
	<h2>영화 수정</h2>
	<form:form action="adminMovieModify" enctype="multipart/form-data" id="modifyMovie_form" modelAttribute="movieVO">
	<input type="hidden" name="m_code" value="${movieVO.m_code}">
	<ul>
		<li>	
			<label for="m_name">제목</label>
			<form:input path="m_name" class="input-check"/>
			<form:errors path="m_name" element="div" cssClass="error-message"></form:errors>
		</li>
		<li>	
			<label for="">상영여부</label>
			<form:select path="m_status" class="input-check">
				<form:option value="1">상영중</form:option>
				<form:option value="2">미상영</form:option>
			</form:select>
			<form:errors path="m_status" element="div" cssClass="error-message"></form:errors>
		</li>
		<li>
			<label for="m_content">내용</label>
			<form:textarea rows="5" cols="30" path="m_content" class="input-check"/>
			<form:errors path="m_content" element="div" cssClass="error-message"></form:errors>
			<script>
				 function MyCustomUploadAdapterPlugin(editor) {
					    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
					        return new UploadAdapter(loader);
					    }
					}
				 
				 ClassicEditor
		            .create( document.querySelector( '#m_content' ),{
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
		<li>
			<label for="m_upload">사진</label>
			<input type="file" name="m_upload" id="m_upload" class="input-check" accept="image/gif,image/png,image/jpeg">
			<form:errors path="m_upload" element="div" cssClass="error-message"></form:errors>
			<c:if test="${!empty movieVO.m_filename}">
				<div id="file_detail">
					(${movieVO.m_filename})파일이 등록되어 있습니다.
				</div>
				</c:if>
		</li>
		
	</ul>
	<div class="btn_display_set">
		<form:button id="submit_btn">등록하기</form:button>
	</div>
</form:form>
	
</div>
</div>

