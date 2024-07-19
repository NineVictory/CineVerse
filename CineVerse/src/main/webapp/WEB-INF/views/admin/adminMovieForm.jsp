<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('insert_form');
    form.onsubmit = function() {
        const contentTextarea = document.getElementById('m_content');
        let content = contentTextarea.value;

        // 정규식을 이용해 URL을 <video> 태그로 변환
        const videoUrls = content.match(/https?:\/\/\S+\.mp4/g);
        if (videoUrls) {
            videoUrls.forEach(url => {
                const videoTag = `<video width="320" height="240" controls><source src="${url}" type="video/mp4">Your browser does not support the video tag.</video>`;
                content = content.replace(url, videoTag);
            });
        }

        contentTextarea.value = content;
    };
});
</script>
<div class="page-container">
	<h2>영화 등록</h2>
	<div class="insert_movie_form">
		<form:form action="insertMovie" method="post" enctype="multipart/form-data" id="insert_form" modelAttribute="movieVO"> 
		<ul>
			<li>
				<form:label path="m_status">영화 상영여부</form:label>
				<input type="radio" name="m_status" value="1" id="m_status1">상영
				<input type="radio" name="m_status" value="2" id="m_status2">미상영
			</li>
			<li>	
				<form:label path="m_name">영화명</form:label>
				<form:input path="m_name" id="m_name" maxlength="100" cssClass="input-check"/>
			</li>
			<li>
				<form:label path="m_opendate">개봉일</form:label>
				<form:input path="m_opendate" id="m_opendate" type="date" cssClass="input-check"/>
			</li>
			<li>
				<form:label path="m_companys">제작사</form:label>
				<form:input path="m_companys" id="m_companys" cssClass="input-check"/>
			</li>
			<li>
				<form:label path="m_upload">포스터</form:label>
				<form:input path="m_upload" id="m_upload" type="file" cssClass="input-check" accept="image/gif,image/png,image/jpeg"/>
			</li>
			<li>
				<form:label path="m_genre">장르명</form:label>
				<form:input path="m_genre" id="m_genre" cssClass="input-check"/>
			</li>
			<li>
				<form:label path="director">감독이름</form:label>
				<form:input path="director" id="director" cssClass="input-check"/>
			</li>
			<li>
				<form:label path="actor">영화배우</form:label>
				<form:input path="actor" id="actor" cssClass="input-check"/>
			</li>
            <li>
				<form:label path="plot">영화 줄거리</form:label>
				<form:textarea path="plot" id="plot" rows="5" cols="30" cssClass="input-check"/>
				<script>
					function MyCustomUploadAdapterPlugin(editor) {
						editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
							return new UploadAdapter(loader);
						}
					}
					ClassicEditor
						.create(document.querySelector('#plot'), {
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
			<li>
				<form:label path="m_content">영화소개</form:label>
				<form:input path="m_content" id="m_content" cssClass="input-check"/>
				<%-- <form:textarea path="m_content" id="m_content" rows="5" cols="30" cssClass="input-check"/> --%>
<!-- 				<script>
					function MyCustomUploadAdapterPlugin(editor) {
						editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
							return new UploadAdapter(loader);
						}
					}
					ClassicEditor
						.create(document.querySelector('#m_content'), {
							extraPlugins: [MyCustomUploadAdapterPlugin]
						})
						.then(editor => {
							window.editor = editor;
						})
						.catch(error => {
							console.error(error);
						});
				</script>  -->
   <!--  <script>
        function MyCustomUploadAdapterPlugin(editor) {
            editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
                return new UploadAdapter(loader);
            };
        }
        
        ClassicEditor
            .create(document.querySelector('#m_content'), {
                extraPlugins: [MyCustomUploadAdapterPlugin],
                // HTML 태그 허용 설정 추가
                htmlSupport: {
                    allow: [
                        {
                            name: 'video',
                            attributes: true,
                            classes: true,
                            styles: true
                        },
                        {
                            name: 'source',
                            attributes: true,
                            classes: true,
                            styles: true
                        },
                        {
                            name: 'oembed',
                            attributes: true,
                            classes: true,
                            styles: true
                        }
                    ]
                },
                mediaEmbed: {
                    previewsInData: true
                }
            })
            .then(editor => {
                window.editor = editor;
            })
            .catch(error => {
                console.error(error);
            });
    </script>				 -->
			</li>
		</ul>
		<div class="btn_display_set">
			<form:button id="submit_btn">등록하기</form:button>
		</div>
		</form:form>
	</div>
</div>
