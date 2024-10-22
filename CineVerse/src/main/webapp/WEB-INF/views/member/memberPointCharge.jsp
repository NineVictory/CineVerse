<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.2.1.js"></script>
<script src="${pageContext.request.contextPath}/js/member.point.js"></script>
<div class="page-container">
	<h2 class="point_title">포인트 충전</h2>
	<div class="point_charge_all">
		<div class="point_charge_toss">
			<h3>충전 금액 선택하기</h3>
			<div class="choose_amount">
				<ul class="choose_list">
					<li>
						<div class="inputs">
							<input type="radio" name="cp_item" value="5000">5,000P
						</div>
						<div class="amount">
							<span>5,000원</span>
						</div>
					</li>
					<li>
						<div class="inputs">
							<input type="radio" name="cp_item" value="10000">10,000P
						</div>
						<div class="amount">
							<span>10,000원</span>
						</div>
					</li>
					<li>
						<div class="inputs">
							<input type="radio" name="cp_item" value="15000">15,000P
						</div>
						<div class="amount">
							<span>15,000원</span>
						</div>
					</li>
					<li>
						<div class="inputs">
							<input type="radio" name="cp_item" value="20000">20,000P
						</div>
						<div class="amount">
							<span>20,000원</span>
						</div>
					</li>
					<li>
						<div class="inputs">
							<input type="radio" name="cp_item" value="30000">30,000P
						</div>
						<div class="amount">
							<span>30,000원</span>
						</div>
					</li>
					<li>
						<div class="inputs">
							<input type="radio" name="cp_item" value="40000">40,000P
						</div>
						<div class="amount">
							<span>40,000원</span>
						</div>
					</li>
					<li>
						<div class="inputs">
							<input type="radio" name="cp_item" value="50000">50,000P
						</div>
						<div class="amount">
							<span>50,000원</span>
						</div>
					</li>
					<li>
						<div class="inputs">
							<input type="radio" name="cp_item" value="100000">100,000P
						</div>
						<div class="amount">
							<span>100,000원</span>
						</div>
					</li>
					<li>
						<div class="inputs">
							<input type="radio" name="cp_item" value="500000">500,000P
						</div>
						<div class="amount">
							<span>500,000원</span>
						</div>
					</li>
<!-- 					<li>
						<div class="inputs">
							<input type="radio" name="cp_item" value="1000000">10,000,000P
						</div>
						<div class="amount">
							<span>10,000,000원</span>
						</div>
					</li> -->
				</ul>
				
				<h3>구매자 정보 입력하기</h3>
				<div class="buyer_info">
					<c:if test="${!empty user }">
					<input type="hidden" id="mem_num" name="mem_num" value="${user.mem_num }">
					<label class="buyer_info_all">구매자 아이디 <input type="text" id="buyer_name" value="${user.mem_id }" disabled="disabled"></label>
					<label class="buyer_info_all">구매자 이메일 <input type="email" id="buyer_email" value="${user.mem_email }" ></label>
					</c:if>
					<c:if test="${empty user }">
						<label class="buyer_info_all">구매자 아이디 <input type="text" id="buyer_name" disabled="disabled"></label>
						<label class="buyer_info_all">구매자 이메일 <input type="email" id="buyer_email" disabled="disabled" ></label>
					</c:if>
				</div>

				<div>
					<h3>결제 방법 선택하기</h3>
					<div>
						<div class="charge_types">
							<h4>카카오페이</h4>
							<div>
								<button class="charge_btn" id="charge_kakao">충전하기</button>
							</div>
						</div>

						<div class="charge_types">
							<h4>토스페이</h4>
							<div>
								<button class="charge_btn" id="charge_toss">충전하기</button>
							</div>
						</div>
					</div>
				</div>
				
				
						
			</div>
		</div>
	</div>
</div>


