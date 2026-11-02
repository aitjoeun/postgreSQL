/*
	DDL(DATA DEFINITION LANGUAGE) : 데이터 정의 언어
	: PostgreSQL에서 제공하는 객체(object)를 만들고(create), 구조를 변경하고(alter),
	  구조 자체를 삭제(drop)하는 언어
	  즉, 실제 데이터값이 아니라 구조 자체를 정의하는 언어
	  주로 DB관리자, 설계자가 사용함
	  
	  객체(OBJECT) : 테이블(TABLE), 뷰(VIEW), 인덱스(INDEX), 패키지(PACKAGE),
	  							트리거(TRIGGER), 프로시저(PROCEDURE), 함수(FUNCTION) 등
*/
--======================================================================
--	<CREATE>
--	객체를 생성하는 구문
--======================================================================
/*
	1. 테이블 생성
		 - 테이블이란 : 행(ROW)과 열(COLUMN)로 구성된 가장 기본적인 데이터베이스 객체
		 						 모든 데이터들은 테이블을 통해 저장되
		 [표현식]
		 (CREATE 객체명)
		 CREATE TABLE 테이블명 (
		 		컬럼명 자료형(크기),
		 		컬럼명 자료형(크기),
		 		컬럼명 자료형,
		 		...
		 );
		 
		 * 테이블 생성시 자주 사용하는 자료형
		   1. 문자형 데이터 타입
		      데이터타입						설명							예시
		      ------------------------------------------
		      CHAR(n)			고정길이 문자열				CHAR(3)
		      VARCHAR(n)	최대 n글자까지 저장		VARCHAR(20)			--> 가변길이(들어오는 글자에따라 저장공간이 됨)
		      VARCHAR			길이 제한 없이 저장		VARCHAR
		      TEXT				길이 제한 없이 저장		TEXT
		      
		   2. 숫자형 데이터 타입
		      데이터타입														설명					 예시
		      ------------------------------------------------------
		      NUMERIC([전체자리수, 소수자리수])		정확한 숫자 저장		NUMERIC
		      SERIAL												자동 증가하는 정수		SERIAL
		      
		   3. 날짜 데이터 타입
		      데이터타입				설명							예시
		      ----------------------------------------------
		      DATE				날짜 저장				2026-11-02
		      TIMESTAMP		날짜+시간 저장		2026-11-02 12:42:43
		      
		   4. 기타 데이터 타입
		      BOOLEAN : 자료형이 아니라 값이 없거나 알 수 없다는 의미
		        값					의미
		      -------------------------
		      TRUE		참
		      FALSE		거짓
		      NULL    알수 없음, 값이 없음     
 */
-- 회원 테이블 MEMBER 생성
create TABLE member (
		MEM_NO numeric,
		MEM_ID VARCHAR(20),
		MEM_PWD VARCHAR(20),
		MEM_NAME VARCHAR(20),
		GENDER CHAR(3),
		PHONE VARCHAR(13),
		EMAIL VARCHAR(50),
		MEM_DATE DATE
);

create TABLE member2 (
		MEM_NO numeric,
		MEM_ID VARCHAR,
		MEM_PWD VARCHAR,
		MEM_NAME VARCHAR,
		GENDER CHAR(3),
		PHONE VARCHAR,
		EMAIL VARCHAR,
		MEM_DATE DATE
);

create TABLE member3 (
		MEM_NO numeric,
		MEM_ID TEXT,
		MEM_PWD TEXT,
		MEM_NAME TEXT,
		GENDER CHAR(3),
		PHONE TEXT,
		EMAIL TEXT,
		MEM_DATE DATE
);

create TABLE member4 (
		MEM_NO SERIAL,
		MEM_ID TEXT,
		MEM_PWD TEXT,
		MEM_NAME TEXT,
		GENDER CHAR(3),
		PHONE TEXT,
		EMAIL TEXT,
		SALARY numeric(10, 2),  -- 정수 8자리 + 소수 2자리
		SALARY2 numeric,
		MEM_DATE TIMESTAMP,
		ACTIVE BOOLEAN 
);

-----------------------------------------------------------
/*
	2. 컬럼에 주석 달기(컬럼에 대한 설명)
		
		[표현법]
		COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
		
		>> 잘못 작성시 수정 후 다시 실행하면 됨
 */

comment on column member.MEM_NO is '회원번호';
comment on column member.MEM_ID is '회원아이디';
comment on column member.MEM_PWD is '회원비밀번호';
comment on column member.MEM_NAME is '회원명';
comment on column member.GENDER is '성별(남,여)';
comment on column member.PHONE is '전화번호';
comment on column member.EMAIL is '이메일';
comment on column member.MEM_DATE is '회원가입일';

comment on column member.MEM_NAME is '회원이름';

insert into member VALUES(1, 'user01', 'pwd01', 
'강효순', '여', '010-1234-4567', 'user01@naver.com', 
'2026-11-02');

insert into member VALUES(2, 'user02', 'pwd02', 
'남길동', '남', null , NULL, CURRENT_DATE);

insert into member VALUES(NULL,NULL,NULL,NULL,NULL,NULL,NULL,null);

-----------------------------------------------------------------
/*
	<제약조건 CONSTRAINTS>
	- 원하는 데이터값(유효한 형식의 값)만 유지하기 위해 특정 컬럼에 설정하는 제약
	- 데이터 무결성 보장을 목적으로 함
	  : 데이터에 결함이 없는 상태, 즉 데이터가 정확하고 유효하게 유지된 상태
	  1) 개체 무결성 제약 조건 : NOT NULL, UNIQUE, PRIMARY KEY 조건 위배
	  2) 참조 무결성 제약 조건 : FOREIGN KEY(외래키) 조건 위배
	  
	* 제약조건 종류 : NOT NULL, UNIQUE, PRIMARY KEY, CHECK(조건), FOREIGN KEY(외래키)
 
	* 제약조건을 부여하는 2가지 방식
		1) 컬럼 레벨 방식 : 컬럼명의 자료형 옆에 기술
		2) 테이블 레벨 방식 : 모든 컬럼들을 나열한 후 마지막에 기술 
 */
-----------------------------------------------------------
/*
	* NOT NULL 제약조건
	  : 해당 컬럼에 반드시 값이 존재해야 한다.(절대 NULL이면 안됨)
	  
	  >> *** 주의사항 : 오로지 컬럼 레벨 방식만 사용 가능
 */
create table MEM_NOTNULL (
	MEM_NO numeric not null,
	MEM_ID VARCHAR(20) not null,
	MEM_PWD VARCHAR(20) not null,
	MEM_NAME VARCHAR(20) not null,
	GENDER CHAR(1),
	PHONE VARCHAR(13),
	EMAIL VARCHAR(30)
);

insert into MEM_NOTNULL VALUES(1, 'user01','pwd01'
		,'최명길','여','010-3456-6856','user01@naver.com');

insert into mem_notnull values(2, 'user02','pwd02'
		,null, '여','010-3456-3424','user02@naver.com');
-- not null 제약조건 위배로 오류발생

insert into mem_notnull values(2, 'user02','pwd02'
		,'김말똥', '남','010-3456-3424','user02@naver.com');

insert into mem_notnull values(2, 'user03','pwd03'
		,'이순실', '여','010-3343-3424','user03@naver.com');
--id가 중복되었음에도 잘 추가됨

-----------------------------------------------------------
/*
	* UNIQUE 제약 조건
	  : 해당 컬럼에 중복된 값이 들어가서는 안되는 경우
	  컬럼값에 중복을 제한하는 제약조건
 */

-- 컬럼 레벨 방식
create table MEM_UNIQUE(
	MEM_NO numeric not null UNIQUE,
	MEM_ID VARCHAR(20) not null UNIQUE,
	MEM_PWD VARCHAR(20) not null,
	MEM_NAME VARCHAR(20) not null,
	GENDER CHAR(1),
	PHONE VARCHAR(13),
	EMAIL VARCHAR(30)
);

-- 테이블 레벨 방식
create table MEM_UNIQUE2(
	MEM_NO numeric not null,
	MEM_ID VARCHAR(20) not null,
	MEM_PWD VARCHAR(20) not null,
	MEM_NAME VARCHAR(20) not null,
	GENDER CHAR(1),
	PHONE VARCHAR(13),
	EMAIL VARCHAR(30),
	unique (MEM_NO),
	unique (MEM_ID)
);

insert into MEM_UNIQUE VALUES(1,'user01','pwd01',
	'황미남', '남','010-2345-5678','user01@google.com');

insert into MEM_UNIQUE VALUES(1,'user02','pwd02',
	'이미남', '남','010-2345-4678','user02@google.com');




