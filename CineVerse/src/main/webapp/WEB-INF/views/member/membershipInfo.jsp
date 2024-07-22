<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
								<c:if test="${!empty user }">
									<div class="mypage_box">
									<div class="my_info">
										<p class="name">
											<img src="${pageContext.request.contextPath}/myPage/viewProfile?mem_num=${member.mem_num}" width="100" height="100" class="my-photo">
											<strong>${member.mem_name }님은</strong> 
											<span class="txt_rank_common">
											<c:choose>
												<c:when test="${member.mem_rank == 1 }">BASIC</c:when>
												<c:when test="${member.mem_rank == 2 }">MEMBER</c:when>
												<c:when test="${member.mem_rank == 3 }">REGULAR</c:when>
												<c:when test="${member.mem_rank == 4 }">VIP</c:when>
												<c:when test="${member.mem_rank == 5 }">VVIP</c:when>
											</c:choose>
											</span>
											<span class="light">등급입니다.</span>
										</p>
										
										<div class="remain_points">
											<p>
											<span class="font_roboto">
											<c:choose>
												<c:when test="${member.mem_rank + 1 == 1 }">BASIC</c:when>
												<c:when test="${member.mem_rank + 1 == 2 }">MEMBER</c:when>
												<c:when test="${member.mem_rank + 1 == 3 }">REGULAR</c:when>
												<c:when test="${member.mem_rank + 1 == 4 }">VIP</c:when>
												<c:when test="${member.mem_rank + 1 == 5 }">VVIP</c:when>
											</c:choose>
											</span>까지 남은 금액 
											
											<c:choose>
											    <c:when test="${member.mem_rank == 1}">
											        <c:set var="remainingPoints" value="${50000 - member.used_point}" />
											        <c:if test="${remainingPoints < 0 }">을 충족하였습니다.</c:if>
											        <c:if test="${remainingPoints > 0}"><em>${remainingPoints}</em>원</c:if> 
											    </c:when>
											    <c:when test="${member.mem_rank == 2}">
											        <c:set var="remainingPoints" value="${100000 - member.used_point}" />
											        <c:if test="${remainingPoints < 0 }">을 충족하였습니다.</c:if>
											        <c:if test="${remainingPoints > 0}"><em>${remainingPoints}</em>원</c:if> 
											    </c:when>
											    <c:when test="${member.mem_rank == 3}">
											        <c:set var="remainingPoints" value="${200000 - member.used_point}" />
											        <c:if test="${remainingPoints < 0 }">을 충족하였습니다.</c:if>
											        <c:if test="${remainingPoints > 0}"><em>${remainingPoints}</em>원</c:if> 
											    </c:when>
											    <c:when test="${member.mem_rank == 4}">
											        <c:set var="remainingPoints" value="${250000 - member.used_point}" />
											        <c:if test="${remainingPoints < 0 }">을 충족하였습니다.</c:if>
											        <c:if test="${remainingPoints > 0}"><em>${remainingPoints}</em>원</c:if> 
											    </c:when>
											</c:choose>
											</p>
										</div>
										
										<c:if test="${remainingPoints < 0}">
                						<div class="next_month_rank">
                   						 	<p>6개월 뒤 예상 등급: 
                    					<c:choose>
						                        <c:when test="${member.mem_rank + 1 == 1 }">BASIC</c:when>
												<c:when test="${member.mem_rank + 1 == 2 }">MEMBER</c:when>
												<c:when test="${member.mem_rank + 1 == 3 }">REGULAR</c:when>
												<c:when test="${member.mem_rank + 1 == 4 }">VIP</c:when>
												<c:when test="${member.mem_rank + 1 == 5 }">VVIP</c:when>
						                    </c:choose>
						                    </p>
						                </div>
						            	</c:if>
										<div class="next_rank">
											<progress max="<c:if test="${member.mem_rank == 1 }">50000</c:if><c:if test="${member.mem_rank == 2 }">100000</c:if><c:if test="${member.mem_rank == 3 }">200000</c:if><c:if test="${member.mem_rank == 4 }">250000</c:if>" value="${member.used_point }"></progress>
											<div class="rank_progress">
											<span> <strong>
											<c:choose>
												<c:when test="${member.mem_rank == 1 }">BASIC</c:when>
												<c:when test="${member.mem_rank == 2 }">MEMBER</c:when>
												<c:when test="${member.mem_rank == 3 }">REGULAR</c:when>
												<c:when test="${member.mem_rank == 4 }">VIP</c:when>
												<c:when test="${member.mem_rank == 5 }">VVIP</c:when>
											</c:choose>
											</strong>
											</span>
											<span>	<strong>
											<c:choose>
												<c:when test="${member.mem_rank + 1 == 1 }">BASIC</c:when>
												<c:when test="${member.mem_rank + 1 == 2 }">MEMBER</c:when>
												<c:when test="${member.mem_rank + 1 == 3 }">REGULAR</c:when>
												<c:when test="${member.mem_rank + 1 == 4 }">VIP</c:when>
												<c:when test="${member.mem_rank + 1 == 5 }">VVIP</c:when>
											</c:choose>
											</strong>
											</span>
											</div>
										</div>
									</div>
								</div>
								</c:if>
								
								<c:if test="${empty user }">
									<div class="nomem_page_box">
	                                    <div class="user_info">
	                                        <div class="bx_con">
	                                        		<p class="txt"><strong>회원가입 하시고</strong><br>VIP의 풍성한 혜택을 만나보세요.</p>
	                                        		<a href="${pageContext.request.contextPath}/member/register" class="btn_col3 ty3 rnd">회원가입</a>
	                                        </div>
	                                        <div class="bx_btm">
	                                        		<p class="txt">이미 CINEVERSE 회원이신가요?</p>
	                                        		<a href="${pageContext.request.contextPath}/member/login" class="btn_lnk2">로그인</a>
	                                        </div>
	                                        
	                                    </div>
	                                </div>
                                </c:if>
                            </div>
                            
                            <div class="rank_2020_wrap">
                                <h3 class="tit"><em>VIP</em> 선정 및 유지 기준</h3>
                                <div class="rank_2020_list_ty2">
                                    <dl class="tit">
                                        <dt class="ic_2024_basic">
                                        <span class="txt_2020_rank1">BASIC</span></dt>
                                        <dd>일반회원</dd>
                                        <dd> &thinsp; </dd>
                                    </dl>
                                    <dl>
                                        <dt class="ic_2024_member"><span class="txt_2020_rank2">MEMBER</span></dt>
                                        <dd><em>Member 6</em>개월 유지</dd>
                                        <dd><em>5 </em>만원 이상</dd>
                                    </dl>
                                    <dl>
                                        <dt class="ic_2024_regular"><span class="txt_2020_rank3">REGULAR</span></dt>
                                        <dd><em>Regular 6</em>개월 유지</dd>
                                        <dd><em>10 </em>만원 이상</dd>
                                    </dl>
                                    <dl>
                                        <dt class="ic_2024_vip"><span class="txt_2020_rank4">VIP</span></dt>
                                        <dd><em>VIP 6</em>개월 유지</dd>
                                        <dd><em>20 </em>만원 이상</dd>
                                    </dl>
                                    <dl>
                                        <dt class="ic_2024_vvip"><span class="txt_2020_rank4">VVIP</span></dt>
                                        <dd><em>VVIP 6</em>개월 유지</dd>
                                        <dd><em>25 </em>만원 이상</dd>
                                    </dl>
                                </div>
                            </div>
                            
							<div class="benefit_wrap">
								<h3 class="tit">
									<em>VIP</em> 혜택
								</h3>
								<ul class="benefit_box_ty2 type2">
									<li><strong class="ic_rank_member">MEMBER</strong>
									<div class="benefit">
											<div class="listbox">
												<ul class="list type1">
													<li><strong>주중영화 2000원 할인권</strong><span><em>1</em>매</span></li>
													<li>&nbsp;</li>
													<li>&nbsp;</li>
												</ul>
											</div>
										</div>
										<div class="benefit">
											<ul class="list">
												<li><strong>벌스샵 2000원 할인권</strong><span><em>1</em> 매</span></li>
												<li>&nbsp;</li>
												<li>&nbsp;</li>
												<li>&nbsp;</li>
											</ul>
										</div>
										</li>
									<li><strong class="ic_rank_regular">REGULAR</strong>
									<div class="benefit">
											<div class="listbox">
												<ul class="list type1">
													<li><strong>주중영화 3000원 할인권</strong><span><em>1</em>매</span></li>
													<li><strong>주중영화 4000원 할인권</strong><span><em>1</em>매</span></li>
													<li>&nbsp;</li>
												</ul>
											</div>
										</div>
										<div class="benefit">
											<ul class="list">
												<li><strong>벌스샵 3000원 할인권</strong><span><em>2</em> 매</span></li>
												<li>&nbsp;</li>
												<li>&nbsp;</li>
												<li>&nbsp;</li>
											</ul>
										</div>
										</li>
									<li><strong class="ic_rank_vip">VIP</strong>
									<div class="benefit">
											<div class="listbox">
												<ul class="list type1">
													<li><strong>주중영화 3000원 할인권</strong><span><em>2</em>매</span></li>
													<li><strong>주중영화 5000원 할인권</strong><span><em>1</em>매</span></li>
													<li>&nbsp;</li>
												</ul>
											</div>
										</div>
										<div class="benefit">
											<ul class="list">
												<li><strong>벌스샵 4000원 할인권</strong><span><em>1</em> 매</span></li>
												<li><strong>벌스샵 5000원 할인권</strong><span><em>1</em> 매</span></li>
												<li>&nbsp;</li>
												<li>&nbsp;</li>
											</ul>
										</div>
										</li>
									<li><strong class="ic_rank_vvip">VVIP</strong>
									<div class="benefit">
											<div class="listbox">
												<ul class="list type1">
													<li><strong>주중영화 3000원 할인권</strong><span><em>2</em>매</span></li>
													<li><strong>주중영화 5000원 할인권</strong><span><em>1</em>매</span></li>
													<li><strong>주중영화관람권</strong><span><em>1</em>매</span></li>
												</ul>
											</div>
										</div>
										<div class="benefit">
											<ul class="list">
												<li><strong>벌스샵 4000원 할인권</strong><span><em>1</em> 매</span></li>
												<li><strong>벌스샵 5000원 할인권</strong><span><em>1</em> 매</span></li>
												<li><strong>벌스샵 6000원 할인권</strong><span><em>1</em> 매</span></li>
												<li>&nbsp;</li>
											</ul>
										</div>
										</li>
								</ul>
						</div>
						</div>
					</div>
				</li>
			</ul>
		</div>
		
	</div>
</div>