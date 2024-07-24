<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 게시판 글 수정 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- include ckeditor js -->
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<div class="page-container">
<div class="Answer_insert_form">
    <h2>글 수정</h2>
    <form:form action="adminAnswer" id="regisiteAnswer_form" enctype="multipart/form-data" modelAttribute="consultVO">
        <form:hidden path="consult_num"/>
        <ul>
            <li>
                <label for="consult_answer">내용</label>
                <form:textarea id="consult_answer" path="consult_answer" class="input-check"/>
                <form:errors path="consult_answer" element="div" cssClass="error-message"/>
                <script>
                    function MyCustomUploadAdapterPlugin(editor) {
                        editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
                            return new UploadAdapter(loader);
                        }
                    }

                    ClassicEditor
                        .create(document.querySelector('#consult_answer'), {
                            extraPlugins: [MyCustomUploadAdapterPlugin]
                        })
                        .then(editor => {
                            window.editor = editor;
                        })
                        .catch(error => {
                            console.error(error);
                        });
                </script>
            </li>
        </ul>
		<div class="btn_display_set">
			<form:button id="submit_btn">등록하기</form:button>
		</div>
    </form:form>
    </div>
</div>
<!-- 게시판 글 수정 끝 -->
