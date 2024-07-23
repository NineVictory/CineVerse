<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<script src="${pageContext.request.contextPath}/js/assign.img.upload2.js"></script>

<script type="text/javascript">

</script>

<div class="page-container page-main">
	<div class="board-main">
	<h2>상품수정</h2>
	
	<hr size="1" width="100%">
	<form:form action="update" id="assignboard_modify" enctype="multipart/form-data" modelAttribute="assignVO">
		<form:hidden path="ab_num"/>
		<div class="상품정보">
			<div class="flexbox-h info-container border-bottom">
				<div class="item-label p-center">카테고리</div>
				<div class="p-center">

					<form:radiobutton path="ab_type" value="handover" />양도
					&nbsp;
					<form:radiobutton path="ab_type" value="exchange" />교환
					&nbsp;
					<form:errors path="ab_type" cssClass="error-color"/>
					
				</div>
			</div>
		
			<div class="flexbox-h info-container border-bottom" style="align-items:flex-start;">
				<div class="item-label">
					<div>
					상품이미지
					</div>
				</div>
				<div class="flexbox-p">
					<div class="image-upload-ul">
						<div class="image-upload">
							이미지 등록
							<form:input type="file" path="ab_upload" accept="image/jpg, image/jpeg, image/png"/>
						</div>
					</div>
					<div>상품 이미지는 PC에서 1:1로 보여집니다.</div>
					<form:errors path="ab_upload" cssClass="error-color"/>
				</div>
				<div class="flexbox-p">
					<div id="preview">
						<%-- <c:if test="${!empty ab_filenames}">
							<c:forEach var="filename" items="${ab_filenames}" >
								<script type="text/javascript">
								$(document).ready(function() {
									var imageUrl = '${pageContext.request.contextPath}/upload/'+filename;
									var container = $('<div>').addClass('preview-image-container');
									var img = $('<img>').attr({'src':imageUrl, 'data-filename':filename}).addClass('preview-image');
									var removeButton = $('<button>').addClass('remove-button').text('X');
									removeButton.on('click', function() {
					                    container.remove(); // 미리보기 삭제
					                    updateFileInput(filename); // input 파일 목록 업데이트
					                });

					                container.append(img).append(removeButton);
					                $('#preview').append(container);
								});
								</script>
							</c:forEach>
							
        
						</c:if> --%>
					</div>
				</div>	
				
				
		
			</div>
			<div class="flexbox-h info-container border-bottom">
				<div class="item-label p-start">
					상품명
				</div>
				<div>
					<div class="flexbox-h">
						<div class="p-start">
							<form:input path="ab_title" id="ab_title" class="custom-title borderR" placeholder="상품명을 입력해 주세요."/>	
						</div>
						&nbsp;
						<div class="divcontainer p-center">
							(0/40)
						</div>
					</div>
					<form:errors path="ab_title" cssClass="error-color"/>
				</div>	
				
			</div>
			<div class="flexbox-h info-container border-bottom">
				<div class="item-label">
					상품상태
				</div>
				<div class="item-status-radio">
					<div>
					<form:radiobutton path="ab_item_status" value="0"/><span class="span1">새 상품(미사용)</span><span class="span2">사용하지 않은 새 상품</span>
					</div>
					<div>
					<form:radiobutton path="ab_item_status" value="1"/><span class="span1">사용감 없음</span><span class="span2">사용은 했지만 눈에 띄는 흔적이나 얼룩이 없음</span>
					</div>
					<div>
					<form:radiobutton path="ab_item_status" value="2"/><span class="span1">사용감 적음</span><span class="span2">눈에 띄는 흔적이나 얼룩이 약간 있음</span>
					</div>
					<div>
					<form:radiobutton path="ab_item_status" value="3"/><span class="span1">사용감 많음</span><span class="span2">눈에 띄는 흔적이나 얼룩이 많이 있음</span>
					</div>
					<div>
					<form:radiobutton path="ab_item_status" value="4"/><span class="span1">고장/파손 상품</span><span class="span2">기능 이상이나 외관 손상 등으로 수리/수선 필요</span>
					<form:errors path="ab_item_status" cssClass="error-color"/>
					
					</div>
				</div>
			</div>
			<div class="flexbox-h info-container">
				<div class="item-label">
					설명
				</div>
				<div class="flexbox-p">
					<form:textarea path="ab_content" placeholder="구매시기, 하자 유무 등 상품 설명을 최대한 자세히 적어주세요.
전화번호, SNS계정 등 개인정보 입력은 제한될 수 있어요." value="${assignVO.ab_content}"/>
					<script>
					 function MyCustomUploadAdapterPlugin(editor) {
						    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
						        return new UploadAdapter(loader);
						    }
						}
					 
					 ClassicEditor
			            .create( document.querySelector( '#ab_content' ),{
			            	extraPlugins: [MyCustomUploadAdapterPlugin]
			            })
			            .then( editor => {
							window.editor = editor;
						} )
			            .catch( error => {
			                console.error( error );
			            } );
				    </script>
					<form:errors path="ab_content" cssClass="error-color"/>
				</div>
			</div>
			
		</div>
		<h2>가격</h2>
		<hr size="1" width="100%">
		<div>
			<div class="flexbox-h info-container item-price">
				
				<div class="item-label">
					가격
				</div>
				<div class="flexbox-p">
					<div style="position:relative" class="price-container">
						<!-- <input type="number" name="ab_price" id="ab_price" placeholder="가격을 입력해주세요" value=""
		   					 oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"> -->
						<form:input path="ab_price" placeholder="가격을 입력해주세요" value=""
		       				oninput="limitInputLength(this, 9);" min="0" max="999999999"/>
		       				<script type="text/javascript">
			       				function limitInputLength(input, maxLength) {
			       				    // 입력된 값에서 숫자와 소수점만 남기고 나머지는 제거합니다.
			       				    let processedValue = input.value.replace(/[^\d.]/g, '').replace(/(\..*)\./g, '$1');
			
			       				    // 길이 제한을 초과하는 경우 입력 값을 잘라냅니다.
			       				    if (processedValue.length > maxLength) {
			       				        processedValue = processedValue.slice(0, maxLength);
			       				    }
			
			       				    // 최종적으로 처리된 값을 입력 필드에 설정합니다.
			       				    input.value = processedValue;
			       				}
		       				</script>
						<span class="won">원</span>
					</div>
					<form:errors path="ab_price" cssClass="error-color"/>
				</div>
			</div>
		</div>
		
		
		<div class="align-right assign-btn">
			<form:button class="default-btn3">수정</form:button>
			<input type="button" value="목록" class="default-btn4" onclick="location.href='list'">
		</div>
	</form:form>
	</div>
</div>