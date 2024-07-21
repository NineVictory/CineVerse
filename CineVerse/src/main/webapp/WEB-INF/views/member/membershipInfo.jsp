<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.membership-content {
    width: 1330px;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.membership-title {
width: 1160px;
    padding: 20px 0 10px;
    margin-bottom: 10px;
    font-size: 24px;
    border-bottom: 1px solid #eee;
}

.vip_top_infor {
	display: flex;
	overflow: hidden;
	position: relative;
	margin: 0 auto 50px;
	border-radius: 10px;
	box-shadow: 0 10px 10px rgba(0, 0, 0, .1);
	background-color: #FFF;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.vip_top_infor .nomem_page_box {
	margin: 40px 38px 62px;
}

.vip_top_infor .nomem_page_box .user_info .bx_con {
	margin-bottom: 20px;
	text-align: center;
}

.user_info {
	display: flex;
	width: 1160px;
	align-items: center;
	flex-direction: column;
	justify-content: center;
}

a.btn_lnk2 {
	border-bottom: 1px solid #666;
	font-size: 12px;
	color: #666;
	vertical-align: middle;
}

a, a:link, a:visited, a:active, a:hover {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}

.vip_top_infor .nomem_page_box .user_info .bx_con .txt {
	line-height: 1.4;
	margin-bottom: 10px;
	font-size: 18px;
	color: #666;
}

.btn_col3 {
	display: inline-block;
	box-sizing: border-box;
	border-radius: 4px;
	border: 1px solid #000000;
	font-size: 14px;
	color: #000000 !important;
	text-align: center;
	vertical-align: middle;
	background-color: #ffffff;
	height: 28px;
	line-height: 26px;
	padding: 0 14px;
	border-radius: 52px;
}

.bx_btm {
	display: flex;
	gap: 70px;
	align-items: center;
	justify-content: center;
}

.membership-rows {
	padding: 0px;
}

.rank_2020_wrap .rank_2020_list_ty2 {
    position: relative;
    margin-top: 20px;
    border-top: 1px solid #bbb;
}

.rank_2020_wrap .rank_2020_list_ty2::before {
    content: '';
    position: absolute;
    left: 0;
    top: 79px;
    width: 100%;
    height: 1px;
    background-color: #bbb;
}

.rank_2020_wrap .rank_2020_list_ty2::after {
    display: block;
    content: '';
    clear: both;
}

.rank_2020_wrap .rank_2020_list_ty2 dl {
    float: left;
    width: 20%;
    text-align: center;
}

.rank_2020_wrap .rank_2020_list_ty2 dl.tit {
    width: 20%;
}

.rank_2020_wrap .rank_2020_list_ty2 dl dt {
    margin-bottom: 16px;
    padding-top: 40px;
}

.rank_2020_wrap .rank_2020_list_ty2 dl dd {
    padding: 28px 0;
    font-size: 15px;
    border-bottom: 1px solid #eee;
}


</style>
    
<div class="page-container">
	<div class="membership-content">
		<h2 class="membership-title">멤버십</h2>
		
		<div class="membership-details">
			<ul class="membership-rows">
				<li>
					<div class="contents_vip">
						<div class="vip-details">
							<h2></h2>			
							<div class="vip_top_infor">
                                <div class="nomem_page_box">
                                    <div class="user_info">
                                        <div class="bx_con">
                                        	<c:if test="${empty user }">
                                        		<p class="txt"><strong>회원가입 하시고</strong><br>VIP의 풍성한 혜택을 만나보세요.</p>
                                        		<a href="${pageContext.request.contextPath}/member/register" class="btn_col3 ty3 rnd">회원가입</a>
                                        	</c:if>
                                        </div>
                                        <div class="bx_btm">
                                        	<c:if test="${empty user }">
                                        		<p class="txt">이미 CINEVERSE 회원이신가요?</p>
                                        		<a href="${pageContext.request.contextPath}/member/login" class="btn_lnk2">로그인</a>
                                       	 	</c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="rank_2020_wrap">
                                <h3 class="tit"><em>VIP</em> 선정 및 유지 기준</h3>
                                <div class="rank_2020_list_ty2">
                                    <dl class="tit">
                                        <dt class="ic_2020_vip"><span class="txt_2020_rank1">BASIC</span></dt>
                                        <dd>일반회원</dd>
                                        <dd> &thinsp; </dd>
                                    </dl>
                                    <dl>
                                        <dt class="ic_2020_vvip"><span class="txt_2020_rank2">MEMBER</span></dt>
                                        <dd><em>Member 6</em>개월 유지</dd>
                                        <dd><em>5 </em>만원 이상</dd>
                                    </dl>
                                    <dl>
                                        <dt class="ic_2020_gold"><span class="txt_2020_rank3">REGULAR</span></dt>
                                        <dd><em>Regular 6</em>개월 유지</dd>
                                        <dd><em>10 </em>만원 이상</dd>
                                    </dl>
                                    <dl>
                                        <dt class="ic_2020_platinum"><span class="txt_2020_rank4">VIP</span></dt>
                                        <dd><em>VIP 6</em>개월 유지</dd>
                                        <dd><em>15 </em>만원 이상</dd>
                                    </dl>
                                    <dl>
                                        <dt class="ic_2020_platinum"><span class="txt_2020_rank4">VVIP</span></dt>
                                        <dd><em>VVIP 6</em>개월 유지</dd>
                                        <dd><em>20 </em>만원 이상</dd>
                                    </dl>
                                </div>
                            </div>
                            
                            
						</div>
					</div>
				</li>
			</ul>
		</div>
		
	</div>
</div>