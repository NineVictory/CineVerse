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
    document.addEventListener('DOMContentLoaded', function() {
        const myForm = document.getElementById('RegisterEvent_form');
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
            return true; // 유효성 검사 통과 시 폼 제출
        };
    });
</script>


<div class="page-main">
	<h2>이벤트 등록</h2>
	<form action="adminEventForm" method="post" enctype="multipart/form-data" id="registerEvent_form">
	<ul>
		<li>	
			<label for="event_name">이벤트명</label>
			<input type="text" name="event_name" id="event_name" class="input-check">
		</li>
		<li>
			<label for="event_filename">상품사진</label>
			<input type="file" name="event_filename" class="input-check" id="event_filename" accept="image/gif,image/png,image/jpeg">
		</li>
		<li>
			<label for="event_content">이벤트내용</label>
			<textarea rows="5" cols="30" name="event_content" id="event_content" class="input-check"></textarea>
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
		<li>
			<label for="event_start">시작일</label>
			<input type="date" name="event_start" id="event_start" class="input-check">
 		</li>
		<li>
			<label for="event_end">마감일</label>
			<input type="date" name="event_end" id="event_end" class="input-check">
		</li>
		<li>
			<input type="submit" value="등록">
		</li>
	</ul>
	
</form>
</div>

