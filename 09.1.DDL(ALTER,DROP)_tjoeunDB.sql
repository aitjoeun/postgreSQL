09.1.DDL(ALTER,DROP)_tjoeunDB.sql

/*
	* ALTER
	  객체를 변경하는 구문
	  
	  [표현식]
	  ALTER TABLE 테이블명 변경할 내용;
	  
	  - 변경할 내용
	    1) 컬럼추가 / 수정 / 삭제
	    2) 제약조건 추가 / 삭제  -> 수정불가(수정하려면 삭제하고 다시 새로 추가)
	    3) 컬럼명 / 제약조건명 / 테이블명 변경
*/
--------------------------------------------------------------------------------------------
/*
	1. 컬럼 추가 / 수정 / 삭제
		1.1 컬럼 추가(ADD)
		
		[표현법]
		ADD 컬럼명 데이터타입 [DEFAULT 기본값]
 */
create table dept_cp
as select *
		from DEPARTMENT;

-- dept_cp에 cname컬럼 추가
alter table DEPT_CP add CNAME VARCHAR(20);

-- LANME 컬럼 추가 기본값도 추가
alter table DEPT_CP add LNAME VARCHAR(20) default '한국';
--> 새로운 컬럼이 만들어지고 내가 지정한 기본값으로 채워짐

/*
		1.2 컬럼 수정 : ALTER COLUMN
		
		[표현법]
		- 데이터 타입 수정
		  ALTER COLUMN 컬럼명 TYPE 바꾸고자하는데이터타입
		  
		- DEFALUT값 수정
		  ALTER COLUMN 컬럼명 SET DEFAULT 바꾸고자하는기본값
*/
-- DEPT_CP테이블에서 DEPT_ID의 데이터타입을 CHAR(3)으로 변경
alter TABLE DEPT_CP alter column DEPT_ID type CHAR(3);

-- 컬럼값에 문자가 들어있는 경우 컬럼의 데이터타입을 숫자형으로 변경 못함
alter table DEPT_CP alter column DEPT_ID type numeric;

-- 컬럼값에 자료형은 문자이지만 숫자로만 구성된 값이라도 NUMERIC으로 변환 안됨
-- 컬럼값에 자료형은 문자이지만 숫자로만 구성된 값이면 USING으로 타입변환한 후에는 자료형 변경가능
alter table DEPT_CP add TYPE_CH VARCHAR(20);
update dept_cp set TYPE_CH = '30';
alter table DEPT_CP alter column TYPE_CH type numeric
using TYPE_CH::NUMERIC;  -- 없으면 오류

-- 컬럼의값이 내가 변경하고자는 자료형의 범위를 넘어서면 오류
alter table DEPT_CP alter column DEPT_TITLE type VARCHAR(5);

-- 다중 변경 가능
-- DEPT_TITLE 컬럼의 타입을 VARCHAR(40)
-- DEPT_ID 컬럼의 타입을 VARCHAR(2)
-- LNAME 컬럼의 기본값을 '미국'으로 변경
alter table dept_cp
	alter column DEPT_TITLE type VARCHAR(40),
	alter column DEPT_ID type VARCHAR(2),
	alter column LNAME set default '미국';

insert into DEPT_CP (LOCATION_ID) values ('L2');

/*
	1.3 컬럼 삭제
	
	[표현법]
	DROP COLUMN 컬럼명
 */
create table DEPT_COPY2
as select * from DEPT_CP;

-- DEPT_COPY2에서 DEPT_ID컬럼 지우기
alter table DEPT_COPY2 drop column DEPT_ID;

-- 다중 삭제 가능
alter table dept_copy2
	drop column CNAME,
	drop column TYPE_CH;

alter table DEPT_COPY2 drop column LNAME;
alter table DEPT_COPY2 drop column LOCATION_ID;
alter table DEPT_COPY2 drop column DEPT_TITLE;

--------------------------------------------------------------------------------------------
/*
	2. 제약조건 추가 / 삭제
		2.1. 제약조건 추가
			ALTER TABLE 테이블명 변경할내용
			
		2.2. 제약조건 삭제
			DROP CONSTRAINT 제약조건
			ALTER COLUMN 컬럼명 DROP NOT NULL
*/
-- DEPT_ID컬럼에 기본키(이름 DCOPY_PK)
-- DEPT_TITLE컬럼에 UNIQUE 추가(이름 DCOPY_UQ)
-- LNAME에 NOT NULL제약조건 추가
alter table dept_cp
	add constraint DCOPY_PK primary key (DEPT_ID),
	add constraint DCOPY_UQ UNIQUE(DEPT_TITLE),
	alter column LNAME set not null;
	
delete from dept_cp
where DEPT_ID is null;

-- 제약조건 삭제
alter table DEPT_CP drop constraint dcopy_pk;

-- 다중삭제
alter table dept_cp
	drop constraint dcopy_uq,
	alter column lname drop not null;

select constraint_name, constraint_type
from information_schema.table_constraints
where table_name = 'dept_cp';

--------------------------------------------------------------------------------------------
/*
	3. 컬럼명 / 제약조건명 / 테이블명 변경
		3.1 컬럼명 변경
		
		[표현법]
		RENAME COLUMN 기존컬럼명 TO 바꿀컬럼명
*/
-- DEPT_CP에서 DEPT_TITLE를 DEPT_NAME으로 변경
alter table DEPT_CP rename column DEPT_TITLE to DEPT_NAME;		

/*
		3.2 제약조건명 변경
		[표현법]
		RENAME CONSTRAINT 기존제약조건명 TO 바꿀제약조건명
*/
alter table DEPT_CP rename constraint DEPT_CP_DEPT_ID_NOT_NULL to DCOPY_LID_NN;
		
		
		
	
