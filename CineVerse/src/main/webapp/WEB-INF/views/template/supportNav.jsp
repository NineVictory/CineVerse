<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 고객센터 메뉴 -->
<style>
.supportNav .support_nav_active{
   		/* font-weight: 800;  */
/*         color: #fff; !important; */
        background:#3F66ED;
}
.supportNav .support_nav_active a{
        color: #fff; !important;
}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script>
    $(document).ready(function() {
        // 현재 URL 경로 가져오기
        var currentPath = window.location.pathname;
        
        $('.supportNav a').each(function() {
            if ($(this).attr('href') === currentPath) {
            	$(this).parent().addClass('support_nav_active');
            }else{
            	$(this).parent().removeClass('support_nav_active');
            }
            if(currentPath === '/support/consultForm'){
            	$('#cl').addClass('support_nav_active');
            }
            if (currentPath.includes('/support/consultDetail')){
            	$('#cl').addClass('support_nav_active');
            }
            if (currentPath.includes('/support/consultList')){
            	$('#cl').addClass('support_nav_active');
            }
            if (currentPath.includes('/support/notice')){
            	$('#nl').addClass('support_nav_active');
            }
            if (currentPath.includes('/support/faq')){
            	$('#fl').addClass('support_nav_active');
            }
            
        });
        
        $('.supportNav a').click(function(event) {
            $('.support_nav').removeClass('support_nav_active');
            if($(this).attr('href') != '/support/main'){
            	$(this).parents().find('.main').removeClass('support_nav_active');
            }
            if ($(this).attr('href') === currentPath) {
	        	$(this).parent().addClass('support_nav_active');
	        }
            if(currentPath === '/support/consultForm'){
            	$('#cl').addClass('support_nav_active');
            }
            if (currentPath.includes('/support/consultDetail')){
            	$('#cl').addClass('support_nav_active');
            }
            if (currentPath.includes('/support/consultList')){
            	$('#cl').addClass('support_nav_active');
            }
            if (currentPath.includes('/support/notice')){
            	$('#nl').addClass('support_nav_active');
            }
            if (currentPath.includes('/support/faq')){
            	$('#fl').addClass('support_nav_active');
            }
            
            /* $(this).parent().addClass('support_nav_active'); */
        });
    });
</script>
<div class="supportNav">
    <ul>
        <li class="support_nav support_nav_active main"><a href="/support/main"> 고객센터 메인 </a></li>
        <li class="support_nav" id="fl"><a href="/support/faq"> 자주 찾는 질문 </a></li>
        <li class="support_nav" id="nl"><a href="/support/notice"> 공지/뉴스 </a></li>
        <li class="support_nav" id="cl"><a href="/support/consultList"> 1:1 문의 </a></li>
        <li class="support-call">
			<img src="https://adimg.cgv.co.kr/images/202302/house/CGV_BUGS_160x300.png" width="160" height="300" border="0" alt="광고-BUGS">
		</li>
        <li class="support-call">
			<img src="https://adimg.cgv.co.kr/images/202406/Doraemon/0709_160x35.png" width="160" height="35" border="0" alt="광고-극장판 도라에몽: 진구의 지구 교향곡">
		</li>
    </ul>
</div>
