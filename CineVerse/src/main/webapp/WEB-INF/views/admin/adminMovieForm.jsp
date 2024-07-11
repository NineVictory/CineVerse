<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- include ckeditor js -->
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<!-- 상품 등록 시작 -->
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
<h2>상품 등록</h2>
<f	orm action="insertMovie" method="post" enctype="multipart/form-data" id="insert_form"> 
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
			<input type="date" name="m_opendate" id="m_opendate">
		</li>
		<li>
			<label for="m_companys">제작사</label>
			<input type="text" name="m_companys" id="m_companys">
		</li>
		<li>
			<label for="m_upload">상품사진</label>
			<input type="file" name="m_upload" class="input-check" id="m_upload" accept="image/gif,image/png,image/jpeg">
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
		<li>
			<input type="submit" value="등록">
		</li>
	</ul>
	
</form>
<!-- 상품 등록 끝 -->