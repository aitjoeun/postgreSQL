08.1.DML(insert,update,delete)_tjoeunDB.sql

/*
	* DML
	  INSERT : 테이블에 데이터 삽입
	  UPDATE : 테이블의 데이터를 수정
	  DELETE : 테이블의 데이터(행)을 삭제
*/
--==========================================================
/*
	1. INSERT
		 테이블에 새로운 행을 추가하는 구문
		 
		 [표현식]
		 1) INSERT INTO 테이블명 VALUES (값1, 값2, 값3,...);
		 		테이블의 모든 컬럼에 대한 값을 한행을 넣고 할 때 사용
		 		컬럼의 순서를 지켜 VALUES에 값을 나열해야 함
*/
insert into EMPLOYEE_COPY VALUES(300, '더조은', '031103-3123456', 'tjoeun@google.com'
, '01056748987', 'D3','J7',3500000, 0.1, 208, '2025-08-15', null, DEFAULT);

------------------------------------------------------------------------
/*
		2) INSERT INTO 테이블명(컬럼명1, 컬럼명2,...) VALUES (값1, 값2,...);
			테이블에 내가 선택한 컬럼에 대한 값만 삽입할 때 사용
			그래도 한 행 단위로 추가됨.
			** 주의 : NOT NULL인 컬럼은 반드시 값이 들어가야 함.
			- 기본값이 지정되어 있는것은 값을 안넣으면(컬럼을 아예 안넣음) 자동으로 기본값이 들어감
*/
insert into EMPLOYEE_COPY(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
values (301, '이티어', '051111-4567654','J5',current_date);

-- 컬럼을 제시할때 순서와 상관없이 해도 됨
-- 그러나 데이터값은 제시한 컬럼의 순서와 동일해야 됨
insert into EMPLOYEE_COPY(EMP_NAME, HIRE_DATE, EMP_ID, JOB_CODE, EMP_NO)
values ('이티어', current_date, 302, 'J5', '051111-4567654');

-- 오류 NOT NULL인 JOB_CODE를 안넣어서
insert into EMPLOYEE_COPY(EMP_ID, EMP_NAME, EMP_NO, HIRE_DATE)
values (302, '황반가', '040111-4567634', current_date);

insert 
	into EMPLOYEE_COPY
		(
			  EMP_NAME
			, HIRE_DATE
			, EMP_ID
			, JOB_CODE
			, EMP_NO
		)
values 
		(
				'이티어'
			 , current_date
			 , 302
			 , 'J5'
			 , '051111-4567654'
		);

------------------------------------------------------------------------
/*
		3) INSERT INTO 테이블명 (서브쿼리);
		   VALUES로 값을 직접 명시하는 대신에 서브쿼리로 조회된 결과값을 모두 INSERT함
		   여러행도 가능
*/
-- EMP_01 테이블 생성
create table EMP_01(
	EMP_ID VARCHAR(3),
	EMP_NAME VARCHAR(20),
	DEPT_NAME VARCHAR(35)
);

-- 전체 사원들의 사번, 이름, 부서명 조회
select EMP_ID, EMP_NAME, DEPT_TITLE
  from employee
  left join DEPARTMENT on (DEPT_CODE = DEPT_ID);

-- EMP_01테이블에 데이터 삽입
insert into EMP_01
	select EMP_ID, EMP_NAME, DEPT_TITLE
  from employee
  left join DEPARTMENT on (DEPT_CODE = DEPT_ID);

------------------------------------------------------------------------
/*
		4) WITH절로 두개 이상의 테이블에 한꺼번에 INSERT
		   WITH절 안에서 INSERT, UPDATE, DELETE 같은 데이터 변경 작업도 수행 가능
		   이를 CTE(DATA-MODIFYING)라고 부름
*/
-- 테이트할 테이블 2개 생성
create table EMP_DEPT
as select EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
		from EMPLOYEE
		where 1=0;

create table EMP_MANAGER
as select EMP_ID, EMP_NAME, MANAGER_ID
		from EMPLOYEE
	  where 1=0;	

-- 부서코드가 D1인 사원들의 사번, 이름, 부서코드, 입사일, 사수사번 조회
select EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
from EMPLOYEE
where DEPT_CODE = 'D1';

with DATA_INFO as (
		select EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
		from EMPLOYEE
		where DEPT_CODE = 'D1'
),
INFO1 as (
	insert into EMP_DEPT (EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
	select EMP_ID,EMP_NAME,DEPT_CODE, HIRE_DATE
	  from DATA_INFO
)
insert into EMP_MANAGER (EMP_ID, EMP_NAME, MANAGER_ID)
select EMP_ID, EMP_NAME, MANAGER_ID from DATA_INFO;

--==========================================================
/*
	2. UPDATE
		 테이블에 기록되어 있는 기존 데이터를 수정하는 구문
		 
		 [표현식]
		 UPDATE 테이블명
		 SET 컬럼명 = 바꿀값,
		     컬럼명 = 바꿀값,
		     ....
		 [WHERE 조건];    --> 주의 : 생략하면 전체 모든 행의 데이터가 변경됨
*/
-- 테이블 생성
create table DEPT_COPY
as select * from DEPARTMENT;
commit;

-- D9 부서의 부서명을 '전략기획팀'으로 수정
update dept_copy
set DEPT_TITLE = '전략기획팀';

rollback;










