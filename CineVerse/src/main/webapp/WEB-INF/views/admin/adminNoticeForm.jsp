<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 게시판 글쓰기 시작 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>

<script type="text/javascript">
    document.addnoticeListener('DOMContentLoaded', function() {
        const myForm = document.getElementById('RegisterNotice_form');
        myForm.onsubmit = function() {
            const items = document.querySelectorAll('.input-check');
            for (let i = 0; i < items.length; i++) {
                if (items[i].value.trim() === '') {
                    const label = document.querySelector('label[for="' + items[i].id + '"]');
                    alert(label.textContent + ' 항목은 필수 입력입니다!');
                    items[i].value = '';
                    items[i].focus();
                    return false; // 폼 제출 방지
                }
            }
        };
    });
</script>
	<h2>공지사항 등록</h2>
	<form:form action="adminNoticeForm" enctype="multipart/form-data" id="registerNotice_form" modelAttribute="NoticeVO">
	<ul>
		<li>	
			<label for="nb_title">공지사항명</label>
			<input type="text" name="nb_title" id="nb_title" class="input-check">
			<form:errors path="nb_title"></form:errors>
		</li>
		<li>
			<label for="nb_upload">공지사항사진</label>
			<input type="file" name="nb_upload" id="nb_upload" class="input-check" accept="image/gif,image/png,image/jpeg">
			<form:errors path="nb_upload"></form:errors>
		</li>
		<li>
			<label for="nb_content">공지사항내용</label>
			<textarea rows="5" cols="30" name="nb_content" id="nb_content" class="input-check"></textarea>
			<form:errors path="nb_content"></form:errors>
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
		<li>
			<input type="submit" value="등록">
		</li>
	</ul>
	
</form:form>

