<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<!-- 상품 등록 시작 -->

<div class="page-container">
    <h2>상품 수정</h2>
    <div class="insert_product_form">
        <form:form action="modifyProduct" method="post" enctype="multipart/form-data" id="register_form" modelAttribute="productVO">
        	<form:hidden path="p_num"/> 
            <ul>
                <li>
                    <label for="p_status">상품 표시 여부</label>
                    <form:radiobutton path="p_status" value="1" checked="true"/>미표시
                    <form:radiobutton path="p_status" value="2"/>표시
                    <form:errors path="p_status" element="div" cssClass="error"/>
                </li>
                <li>
                    <label for="p_category">상품 카테고리</label>
                    <form:radiobutton path="p_category" value="1"/> MARVEL
                    <form:radiobutton path="p_category" value="2"/> DISNEY
                    <form:radiobutton path="p_category" value="3"/> DISNEY PRINCESS
                    <form:radiobutton path="p_category" value="4"/> PIXAR
                    <form:radiobutton path="p_category" value="5"/> Studio GHIBLI
                    <form:radiobutton path="p_category" value="6"/> Warner Bros.
                    <form:radiobutton path="p_category" value="7"/> Universal Studio
                    <form:radiobutton path="p_category" value="8"/> ETC
                    <form:errors path="p_category" element="div" cssClass="error"/>
                </li>
                <li>    
                    <label for="p_name">상품명</label>
                    <form:input type="text" path="p_name" id="p_name" maxlength="100" class="input-check"/>
                    <form:errors path="p_name" element="div" cssClass="error"/>
                </li>
                <li>
                    <label for="p_price">가격</label>
                    <form:input type="number" path="p_price" id="p_price" min="1" max="999999999" class="input-check"/>
                    <form:errors path="p_price" element="div" cssClass="error"/>
                </li>
                <li>
                    <label for="p_quantity">수량</label>
                    <form:input type="number" path="p_quantity" id="p_quantity" min="0" max="9999999" class="input-check"/>
                    <form:errors path="p_quantity" element="div" cssClass="error"/>
                </li>
                <li>
                    <label for="p_upload">상품사진</label>
                    <input type="file" id="p_upload" name="p_upload" accept="image/gif,image/png,image/jpeg,image/jpg" class="input-check">
                    <form:errors path="p_upload" element="div" cssClass="error"/>
                    <c:if test="${!empty productVO.p_filename}">
                        <div id="file_detail">
                            (${productVO.p_filename}) 파일이 등록되어 있습니다.
                            <input type="button" value="파일 삭제" id="file_del">
                        </div>
                        <script type="text/javascript">
                            $(document).ready(function() {
                                $('#file_del').click(function() {
                                    const choice = confirm('삭제하시겠습니까?');
                                    if(choice) {
                                        $.ajax({
                                            url: 'deleteFile',
                                            data: {p_num: '${productVO.p_num}' },
                                            type: 'post',
                                            dataType: 'json',
                                            success: function(param) {
                                                if(param.result == 'logout') {
                                                    alert('로그인 후 사용하세요');
                                                } else if(param.result == 'noAdmin') {
                                                    alert('잘못된 접속입니다.');
                                                } else if(param.result == 'success') {
                                                    $('#file_detail').hide();
                                                } else {
                                                    alert('파일 삭제 오류 발생');
                                                }
                                            },
                                            error: function() {
                                                alert('네트워크 오류 발생');
                                            }
                                        });
                                    }
                                });
                            });
                        </script>
                    </c:if>
                </li>
                <li>
                    <label for="p_content">상품설명</label>
                    <form:textarea rows="5" cols="30" path="p_content" id="p_content" class="input-check"/>
                    <script>
                        function MyCustomUploadAdapterPlugin(editor) {
                            editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
                                return new UploadAdapter(loader);
                            }
                        }

                        ClassicEditor
                            .create(document.querySelector('#p_content'), {
                                extraPlugins: [MyCustomUploadAdapterPlugin]
                            })
                            .then(editor => {
                                window.editor = editor;
                            })
                            .catch(error => {
                                console.error(error);
                            });
                    </script>
                    <form:errors path="p_content" element="div" cssClass="error"/>
                </li>
            </ul>
            <div class="btn_display_set">
                <form:button id="submit_btn">등록하기</form:button>
            </div>
        </form:form>
    </div>
</div>
<!-- 상품 등록 끝 -->
