/*
DDL 실습문제
도서관리 프로그램을 만들기 위한 테이블들 만들기
이때, 제약조건에 이름을 부여할 것.
       각 컬럼에 주석달기

1. 출판사들에 대한 데이터를 담기위한 출판사 테이블(TB_PUBLISHER)
   컬럼  :  PUB_NO(출판사번호) NUMERIC -- 기본키(PUBLISHER_PK) 
	PUB_NAME(출판사명) VARCHAR(50) -- NOT NULL(PUBLISHER_NN)
	PHONE(출판사전화번호) VARCHAR(13) - 제약조건 없음
*/
create table TB_PUBLISHER (
	PUB_NO numeric constraint PUBLISHER_PK primary key,
	PUB_NAME VARCHAR(50) constraint PUBLISHER_NN not null,
	PHONE VARCHAR(13)
);

comment on column TB_PUBLISHER.PUB_NO is '출판사번호';
comment on column TB_PUBLISHER.PUB_NAME is '출판사명';
comment on column TB_PUBLISHER.PHONE is '출판사전화번호';

-- 3개 정도의 샘플 데이터 추가하기
insert into TB_PUBLISHER VALUES(1, 'TJOEUN출판사','02-1234-7777');

/*
2. 도서들에 대한 데이터를 담기위한 도서 테이블(TB_BOOK)
   컬럼  :  BK_NO (도서번호) NUMERIC -- 기본키(BOOK_PK)
	BK_TITLE (도서명) VARCHAR(50) -- NOT NULL(BOOK_NN_TITLE)
	BK_AUTHOR(저자명) VARCHAR(20) -- NOT NULL(BOOK_NN_AUTHOR)
	BK_PRICE(가격) NUMERIC
	BK_PUB_NO(출판사번호) NUMERIC -- 외래키(BOOK_FK) (TB_PUBLISHER 테이블을 참조하도록)
			         이때 참조하고 있는 부모데이터 삭제 시 자식 데이터도 삭제 되도록 옵션 지정
*/
create table TB_BOOK(
	BK_NO numeric constraint BOOK_PK primary key,
	BK_TITLE VARCHAR(50) constraint BOOK_NN_TITLE NOT null,
	BK_AUTHOR VARCHAR(20) constraint BOOK_NN_AUTHOR NOT null,
	BK_PRICE numeric,
	BK_PUB_NO numeric constraint BOOK_FK REFERENCES TB_PUBLISHER on delete CASCADE
);

comment on column TB_BOOK.BK_NO is '도서번호';
comment on column TB_BOOK.BK_TITLE is '도서명';
comment on column TB_BOOK.BK_AUTHOR is '저자명';
comment on column TB_BOOK.BK_PRICE is '가격';
comment on column TB_BOOK.BK_PUB_NO is '출판사번호';

-- 5개 정도의 샘플 데이터 추가하기
insert into TB_BOOK VALUES(1010, 'PostgreSQL','tjoeun',35000, 1);

/*
3. 회원에 대한 데이터를 담기위한 회원 테이블 (TB_MEMBER)
   컬럼명 : MEMBER_NO(회원번호) NUMERIC -- 기본키(MEMBER_PK)
   MEMBER_ID(아이디) VARCHAR(30) -- 중복금지(MEMBER_UQ), NOT NULL
   MEMBER_PWD(비밀번호)  VARCHAR(30) -- NOT NULL(MEMBER_NN_PWD)
   MEMBER_NAME(회원명) VARCHAR(20) -- NOT NULL(MEMBER_NN_NAME)
   GENDER(성별)  CHAR(1)-- 'M' 또는 'F'로 입력되도록 제한(MEMBER_CK_GEN)
   ADDRESS(주소) VARCHAR(70)
   PHONE(연락처) VARCHAR(13)
   STATUS(탈퇴여부) CHAR(1) - 기본값으로 'N' 으로 지정, 그리고 'Y' 혹은 'N'으로만 입력되도록 제약조건(MEMBER_CK_STA)
   ENROLL_DATE(가입일) DATE -- 기본값으로 CURRENT_DATE, NOT NULL 제약조건(MEMBER_NN_EN)
*/
create table TB_MEMBER(
	MEMBER_NO numeric constraint MEMBER_PK primary key,
	MEMBER_ID VARCHAR(30) NOT null constraint MEMBER_UQ unique,
	MEMBER_PWD VARCHAR(30) constraint MEMBER_NN_PWD NOT null,
	MEMBER_NAME VARCHAR(20) constraint MEMBER_NN_NAME NOT null,
	GENDER CHAR(1) constraint MEMBER_CK_GEN CHECK(GENDER in ('M','F')),
	ADDRESS VARCHAR(70),
	PHONE VARCHAR(13),
	STATUS CHAR(1) default 'N' constraint MEMBER_CK_STA CHECK(STATUS in ('Y','N')),
	ENROLL_DATE DATE constraint MEMBER_NN_EN NOT null DEFAULT CURRENT_DATE 
);

comment on column TB_MEMBER.MEMBER_NO is '회원번호';
comment on column TB_MEMBER.MEMBER_ID is '아이디';
comment on column TB_MEMBER.MEMBER_PWD is '비밀번호';
comment on column TB_MEMBER.MEMBER_NAME is '회원명';
comment on column TB_MEMBER.GENDER is '성별';
comment on column TB_MEMBER.ADDRESS is '주소';
comment on column TB_MEMBER.PHONE is '연락처';
comment on column TB_MEMBER.STATUS is '탈퇴여부';
comment on column TB_MEMBER.ENROLL_DATE is '가입일';

-- 5개 정도의 샘플 데이터 추가하기
insert into TB_MEMBER VALUES(100, 'user01','pass01','강남길','M','서울특별시 강남구', '010-1111-2222',default,DEFAULT);
insert into TB_MEMBER(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME)
	VALUES(200, 'user02','pass02','황수호');

/*
4. 어떤 회원이 어떤 도서를 대여했는지에 대한 대여목록 테이블(TB_RENT)
   컬럼  :  RENT_NO(대여번호) NUMERIC -- 기본키(RENT_PK)
	RENT_MEM_NO(대여회원번호) NUMERIC -- 외래키(RENT_FK_MEM) TB_MEMBER와 참조하도록
			이때 부모 데이터 삭제시 자식 데이터 값이 NULL이 되도록 옵션 설정
	RENT_BOOK_NO(대여도서번호) NUMERIC -- 외래키(RENT_FK_BOOK) TB_BOOK와 참조하도록
			이때 부모 데이터 삭제시 자식 데이터 값이 NULL값이 되도록 옵션 설정
	RENT_DATE(대여일) DATE -- 기본값 CURRENT_DATE
*/
create table TB_RENT(
	RENT_NO numeric constraint RENT_PK primary key, 
	RENT_MEM_NO numeric constraint RENT_FK_MEM references TB_MEMBER on delete set null,
	RENT_BOOK_NO numeric constraint RENT_FK_BOOK references TB_BOOK on delete set null,
	RENT_DATE DATE default CURRENT_DATE
);

comment on column TB_RENT.RENT_NO is '대여번호';
comment on column TB_RENT.RENT_MEM_NO is '대여회원번호';
comment on column TB_RENT.RENT_BOOK_NO is '대여도서번호';
comment on column TB_RENT.RENT_DATE is '대여일';

-- 3개 정도 샘플데이터 추가하기
insert into TB_RENT VALUES(3000, 100, 1010, DEFAULT);
insert into TB_RENT VALUES(3001, 200, 1010, '2026-10-28');