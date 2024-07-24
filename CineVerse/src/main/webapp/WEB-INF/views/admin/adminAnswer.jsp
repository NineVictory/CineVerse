<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 게시판 글쓰기 시작 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>

<script>
    function adminAnswer(consult_content, consult_num) {
        var content = document.getElementById("consult_answer").value;
        $.ajax({
            type: "POST", 
            url: "${pageContext.request.contextPath}/updateAnswer",
            data: { consult_content: consult_content, consult_num: consult_num },
            success: function(response) {
                if (response === "success") {
                    // 업데이트 성공 시 페이지 리로드 혹은 메시지 표시 등의 동작 추가 가능
                    alert("답변 완료");
                    location.reload(); // 예시로 페이지를 새로고침
                } else {
                    alert("답변 실패");
                }
            },
            error: function() {
                alert("서버 오류가 발생했습니다.");
            }
        });
    }
</script>

<div class="page-container">
	<div class="answer_insert_form">
		<h2>문의답변</h2>
		<form:form action="adminAnswer" enctype="multipart/form-data"
			id="answer_form" modelAttribute="consultVO">
			<ul>
				<li>
					<label for="consult_answer">내용</label>
					<form:textarea rows="5" cols="30" path="consult_answer"
						class="input-check" id="consult_answer" />
					<form:errors path="consult_answer" element="div"
						cssClass="error-message"></form:errors>
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
				<button type="button" id="submit_btn"
					onclick="adminAnswer('${consult_content}', ${consult_num})">등록하기</button>
			</div>
		</form:form>
	</div>
</div>
