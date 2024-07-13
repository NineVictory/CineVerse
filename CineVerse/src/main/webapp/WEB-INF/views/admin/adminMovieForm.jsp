<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- include ckeditor js -->
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    const myForm = document.getElementById('insert_form');
    //이벤트 연결
    myForm.onsubmit = function() {
        const radioGroups = [
            document.querySelectorAll('input[name="m_status"]:checked'),
        ];

        for (let group of radioGroups) {
            if (group.length < 1) {
                alert('영화 상영여부는 필수 ');
                return false;
            }
        }

        const items = document.querySelectorAll('.input-check');
        for (let i = 0; i < items.length; i++) {
            if (items[i].value.trim() == '') {
                const label = document.querySelector('label[for="'+items[i].id+'"]');
                alert(label.textContent + ' 항목은 필수 입력입니다!');
                items[i].value = '';
                items[i].focus();
                return false;
            }
        }
    };
});
</script>
<div class="page-container">
	<h2>영화 등록</h2>
	<div class="insert_movie_form">
		<form:form action="insertMovie" method="post" enctype="multipart/form-data" id="insert_form" modelAttribute="movieVO"> 
		<ul>
			<li>
				<label for="m_status">영화 상영여부 </label>
				<input type="radio" name="m_status" value="1" id="m_status1">상영
				<input type="radio" name="m_status" value="2" id="m_status2">미상영
			</li>
			<li>	
				<label for="m_name">영화명</label>
				<input type="text" name="m_name" id="m_name" maxlength="100" class="input-check">
			</li>
			<li>
				<label for="m_opendate">개봉일</label>
				<input type="date" name="m_opendate" id="m_opendate" class="input-check">
			</li>
			<li>
				<label for="m_companys">제작사</label>
				<input type="text" name="m_companys" id="m_companys" class="input-check">
			</li>
			<li>
				<label for="m_upload">포스터</label>
				<input type="file" name="m_upload" class="input-check" id="m_upload" accept="image/gif,image/png,image/jpeg">
			</li>
			<li>
				<label for="genre">장르명</label>
				<input type="text" name="genre" id="genre" class="input-check">
			</li>
			<li>
				<label for="director">감독이름</label>
				<input type="text" name="director" id="director" class="input-check">
			</li>
			<li>
				<label for="actor">영화배우</label>
				<input type="text" name="actor" id="actor" class="input-check">
			</li>
			<li>
				<label for="m_content">영화소개</label>
				<textarea rows="5" cols="30" name="m_content" id="m_content" class="input-check"></textarea>
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
			</ul>
			<div class="btn_display_set">
				<form:button id="submit_btn">등록하기</form:button>
			</div>
		</form:form>
	</div>
</div>

