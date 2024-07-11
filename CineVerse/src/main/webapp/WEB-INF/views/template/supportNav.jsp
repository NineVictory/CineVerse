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
        });
        
        $('.supportNav a').click(function(event) {
            $('.support_nav').removeClass('support_nav_active');
            if($(this).attr('href') != '/support/main'){
            	$(this).parents().find('.main').removeClass('support_nav_active');
            }
            if ($(this).attr('href') === currentPath) {
	        	$(this).parent().addClass('support_nav_active');
	        }
            
            /* $(this).parent().addClass('support_nav_active'); */
        });
    });
</script>
<div class="supportNav">
    <ul>
        <li class="support_nav support_nav_active main"><a href="/support/main"> 고객센터 메인 </a></li>
        <li class="support_nav"><a href="/support/faq"> 자주 묻는 질문 </a></li>
        <li class="support_nav"><a href="/support/news"> 공지/뉴스 </a></li>
        <li class="support_nav"><a href="#<%--support/qna--%>"> 1:1 문의 </a></li>
        <li class="support-call"><div>CINEVERSE<br>고객센터<br>1234-5678<br><img src="${pageContext.request.contextPath}/images/kbm/heart01.png">10:00 ~ 19:00</div></li>
    </ul>
</div>
