--영화관 컬럼 삭제
ALTER TABLE cinema DROP COLUMN c_theater;
ALTER TABLE cinema DROP COLUMN c_seat;
ALTER TABLE cinema DROP COLUMN c_filename;

--외래키로 c_num 받는 테이블 c_num 컬럼지우기
ALTER TABLE seat DROP CONSTRAINT c_num;
ALTER TABLE movie_time DROP CONSTRAINT c_num;

--상영관 테이블 추가
CREATE TABLE theater(
	th_num NUMBER NOT NULL,
	c_num NUMBER NOT NULL,
	th_name VARCHAR2(15) NOT NULL,
	th_position VARCHAR2(15) NOT NULL,
	CONSTRAINT theater_pk PRIMARY KEY (th_num),
    CONSTRAINT theater_fk FOREIGN KEY (c_num) REFERENCES cinema (c_num)
);

--기존에 c_num 외래키로 쓰던 테이블들에 th_num 외래키 추가
ALTER TABLE seat ADD CONSTRAINT th_num FOREIGN KEY (th_num) REFERENCES theater (th_num);





































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



