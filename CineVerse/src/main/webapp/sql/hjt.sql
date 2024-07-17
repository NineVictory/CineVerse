--영화관 컬럼 삭제
ALTER TABLE cinema DROP COLUMN c_theater;
ALTER TABLE cinema DROP COLUMN c_seat;
ALTER TABLE cinema DROP COLUMN c_filename;

--외래키로 c_num 받는 테이블 c_num 외래키 제약 조건 제거
ALTER TABLE seat DROP CONSTRAINT FK_seat_1;
ALTER TABLE movie_time DROP CONSTRAINT FK_movie_time_2;

--c_num 받는 테이블 c_num 컬럼지우기
ALTER TABLE seat DROP COLUMN c_num;
ALTER TABLE movie_time DROP COLUMN c_num;


--상영관 테이블 추가
CREATE TABLE theater(
	th_num NUMBER NOT NULL,
	c_num NUMBER NOT NULL,
	th_name VARCHAR2(15) NOT NULL,
	th_seat_count NUMBER NOT NULL,
	CONSTRAINT theater_pk PRIMARY KEY (th_num),
    CONSTRAINT theater_fk FOREIGN KEY (c_num) REFERENCES cinema (c_num)
);
create sequence theater_seq;

--기존에 c_num 외래키로 쓰던 테이블들에 th_num 컬럼 추가
-- 1. NULL 허용 열 추가
ALTER TABLE seat ADD th_num NUMBER;
ALTER TABLE movie_time ADD th_num NUMBER;


-- 2. 데이터 업데이트 (임의의 값으로 업데이트)
UPDATE seat SET th_num = 1;
UPDATE movie_time SET th_num = 1; -- 실제 상황에 맞게 값을 설정
COMMIT;

-- 3. NOT NULL 제약 조건 추가
ALTER TABLE seat MODIFY th_num NUMBER NOT NULL;
ALTER TABLE movie_time MODIFY th_num NUMBER NOT NULL;

-- 4. theater 테이블에 th_num값으로 임의의 값 추가 
INSERT INTO theater (th_num, c_num, th_name, th_position) VALUES (1, 36, '가', '나');  -- 이 과정에서 c_num은 기존에 있던 데이터인 36을 가져옴


--th_num 추가한 테이블들의 th_num에 외래키 제약 조건 추가
ALTER TABLE seat ADD CONSTRAINT FK_seat_1 FOREIGN KEY (th_num) REFERENCES theater (th_num);
ALTER TABLE movie_time ADD CONSTRAINT FK_movie_time_2 FOREIGN KEY (th_num) REFERENCES theater (th_num);





































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



