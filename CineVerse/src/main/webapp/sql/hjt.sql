-- 상품 리뷰
create table product_review (
	pr_num number not null,
    order_num number not null,
	p_content clob not null,
	pr_reg_date date default sysdate not null,
	pr_filename clob null,
	od_num number not null,
	p_num number not null,
	pr_grade number(1) not null,
	constraint product_review_pk primary key (pr_num),
	constraint product_review_fk1 foreign key (od_num) references order_detail (od_num),
	constraint product_review_fk2 foreign key (p_num) references product (p_num)
);

-- 교환/환불
create table order_change(
	oc_num number not null,
	oc_type number not null,
	oc_content clob not null,
	oc_reg_date date default sysdate not null,
	--작성중
);