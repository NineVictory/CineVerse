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
        };
    });
</script>

<div class="page-container">
	<%-- <h2>${consult.consult_title}</h2>
	<ul class="detail-info">
		<li>회원번호 : ${consult.mem_num} 
		분류 : <c:if test="${consult.consult_type == 'dissatisfaction'}"> 불만사항</c:if> 
		<c:if test="${consult.consult_type == 'exchange'}">교환/환불</c:if>
		<c:if test="${consult.consult_type == 'proposal'}">제안</c:if> 
		<c:if test="${consult.consult_type == 'compliment'}">칭찬</c:if> 
		<c:if test="${consult.consult_type == 'inquiry'}">문의</c:if> 
		<c:if test="${consult.consult_type == 'missing'}">분실</c:if>  
			 내용 : ${consult.consult_content} 작성일 : ${consult.consult_reg_date}
	</ul> --%>
	<div class="event_insert_form">
		<h2>문의답변</h2>
		<form:form action="adminAnswer" enctype="multipart/form-data"
			id="answer_form" modelAttribute="consultVO">
			<ul>
				<li><label for="consult_answer">내용</label> <form:textarea
						rows="5" cols="30" path="consult_answer" class="input-check" /> <form:errors
						path="consult_answer" element="div" cssClass="error-message"></form:errors>
					<script>
				 function MyCustomUploadAdapterPlugin(editor) {
					    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
					        return new UploadAdapter(loader);
					    }
					}
				 ClassicEditor
		            .create( document.querySelector( '#answer_content' ),{
		            	extraPlugins: [MyCustomUploadAdapterPlugin]
		            })
		            .then( editor => {
						window.editor = editor;
					} )
		            .catch( error => {
		                console.error( error );
		            } );
			    </script></li>

			</ul>
			<div class="btn_display_set">
				<form:button id="submit_btn">등록하기</form:button>
			</div>
		</form:form>

	</div>
</div>

