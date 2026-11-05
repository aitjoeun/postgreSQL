/*
  	<VIEW>
  	: SELECT문을 저장해 두는 데이터베이스 객체
  	
  	- 자주 사용하는 복잡하고 긴 SELECT문을 VIEW로 만들어 
  		매번 긴 쿼리를 작성하지 않아도 편하게 조회할 수 있음
  	- 실제 데이터를 별도로 저장하는게 아니라 저장된 SELECT문을
  	  통행 데이터를 조회하는 가상 테이블
  	- 원본 테이블의 데이터가 변경되면 VIEW 조회 결과에도 반영됨		
*/
-- 한국에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명 조회
select EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
	from EMPLOYEE
	join DEPARTMENT on (DEPT_CODE = DEPT_ID)
	join LOCATION on (LOCATION_ID = local_CODE)
	join national USING (NATIONAL_CODE)
 where NATIONAL_NAME = '한국';

-- 러시아에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명 조회
select EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
	from EMPLOYEE
	join DEPARTMENT on (DEPT_CODE = DEPT_ID)
	join LOCATION on (LOCATION_ID = local_CODE)
	join national USING (NATIONAL_CODE)
 where NATIONAL_NAME = '러시아';

-- 일본에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명 조회
select EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
	from EMPLOYEE
	join DEPARTMENT on (DEPT_CODE = DEPT_ID)
	join LOCATION on (LOCATION_ID = local_CODE)
	join national USING (NATIONAL_CODE)
 where NATIONAL_NAME = '일본';

-----------------------------------------------------------------
/*
	1. VIEW 생성 방법
	
	[표현식]
	CREATE VIEW 뷰명
	AS 서브쿼리;
 */
create view VW_EMPLOYEE
as select EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
	from EMPLOYEE
	join DEPARTMENT on (DEPT_CODE = DEPT_ID)
	join LOCATION on (LOCATION_ID = local_CODE)
	join national USING (NATIONAL_CODE);

select * from VW_EMPLOYEE;

select * from VW_EMPLOYEE
where NATIONAL_NAME = '한국';

select * from VW_EMPLOYEE
where NATIONAL_NAME = '러시아';

select * from VW_EMPLOYEE
where NATIONAL_NAME = '중국';

----------------------------------------------------------------------
/*
 * 뷰 컬럼에 별칭
   서브쿼리의 SELECT절에 함수식이나 산술연산식이 기술되었다면 되도록이면 별칭을 부여하는게 편함.
   별칭을 안넣으면 알아서 붙여주기는 함.
 */
-- 전 사원의 사번, 이름, 직급명, 성별(남/여), 근무년수를 조회할 수 있는 뷰(VW_EMP_JOB)생성
create view VW_EMP_JOB
as select EMP_ID, EMP_NAME, JOB_NAME,
					case when SUBSTR(EMP_NO, 8, 1) in ('1', '3') then '남'
							 when SUBSTR(EMP_NO, 8, 1) in ('2', '4') then '여'
					end,
					EXTRACT(year from CURRENT_DATE) - EXTRACT(year from HIRE_DATE)
		 from employee
		 join JOB USING(JOB_CODE);

select "case" from vw_emp_job;
select "?column?" from vw_emp_job;

drop view VW_EMP_JOB;
drop view VW_JOB;

create view VW_EMP_JOB
as select EMP_ID, EMP_NAME, JOB_NAME,
					case when SUBSTR(EMP_NO, 8, 1) in ('1', '3') then '남'
							 when SUBSTR(EMP_NO, 8, 1) in ('2', '4') then '여'
					end as 성별,
					EXTRACT(year from CURRENT_DATE) - EXTRACT(year from HIRE_DATE) AS 근무년수
		 from employee
		 join JOB USING(JOB_CODE);

select * from VW_EMP_JOB;

select * from VW_EMP_JOB where 성별 = '여';

select * from VW_EMP_JOB where 근무년수 >= 20;

-----------------------------------------------------------------------------
/*
	- AGE() 함수 : 두 날짜 사이의 차이를 연도, 월, 일 단위로 계산해 주는 함수
	  AGE(현재날짜, 과거날짜)
 */

select AGE(CURRENT_DATE, DATE '2020-05-10');

select EMP_ID, EMP_NAME, JOB_NAME,
					case when SUBSTR(EMP_NO, 8, 1) in ('1', '3') then '남'
							 when SUBSTR(EMP_NO, 8, 1) in ('2', '4') then '여'
					end as 성별,
					EXTRACT(year FROM AGE(CURRENT_DATE, HIRE_DATE)) as 근무년수
		 from employee
		 join JOB USING(JOB_CODE);
-----------------------------------------------------------------------------
/*
 * VIEW 삭제
   DROP VIEW 뷰명
*/
drop view VW_EMP_JOB;

-------------------------------------------------------------
-- 생성된 뷰를 통해 INSERT, UPDATE, DELETE가능

create view VW_JOB
as select JOB_CODE, JOB_NAME
		from JOB;

-- 뷰를 통한 INSERT
insert into VW_JOB values ('J8', '인턴');

select * from VW_JOB;
select * from JOB;

-- 뷰를 통한 UPDATE
update vw_job
set JOB_NAME = '알바'
where JOB_CODE = 'J8';

-- 뷰를 통한 DELETE
delete from vw_job where JOB_CODE = 'J8';

/*
	- DML 명령어로 조작이 불가능한 경우
	  1) 뷰에 정의되어 있지 않은 컬럼 조작하고자 할 때
	  2) 뷰에 정의되어 있지 않은 컬럼 중에 원본테이블상에 NOT NULL제약조건이 지정되어 있는 경우 INSERT불가
	  3) 산술식 또는 함수식으로 정의 되어있는 경우
	  4) 그룹함수나 GROUP BY절에 포함되어 있는 경우
	  5) DISTINCT 구문이 포함 되어 있는 경우
	  6) JOIN을 이용하여 여러 테이블을 연결시켜놓은 경우
 */
-- 뷰 생성
create view VW_JOB2
as select JOB_CODE
		from JOB;

select * from VW_JOB2;
select * from JOB;

-- 1) 뷰에 정의되어 있지 않은 컬럼을 조작하려고 할때 오류
-- INSERT
insert into VW_JOB2 (JOB_CODE, JOB_NAME) values ('J8', '인턴');

-- UPDATE
update VW_JOB2
set JOB_NAME = '인턴'
where JOB_CODE = 'J7';

-- DELETE
delete from VW_JOB2
where JOB_NAME = '대리';

-- 2) 뷰에 정의되어 있지 않은 컬럼 중에 원본테이블상에 NOT NULL제약조건이 지정되어 있는 경우
create view VW_JOB3
as select JOB_NAME
		from JOB;

select * from VW_JOB3;
select * from JOB;

-- INSERT
insert into VW_JOB3 VALUES('인턴');

begin;
-- UPDATE(성공)
update VW_JOB3
  set JOB_NAME = '인턴'
 where JOB_NAME = '사원'; 

-- DELETE(외래키가 걸려있지 않으면 가능)
delete from VW_JOB3
where JOB_NAME = '대리';

select * from VW_JOB3;
select * from JOB;

rollback;

-- 3) 산술식 또는 함수식으로 정의 되어있는 경우
drop view VW_EMP_SAL;

create view VW_EMP_SAL
as select EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SALARY, SALARY*12 as 연봉
		from EMPLOYEE;

select * from VW_EMP_SAL;
select EMP_NAME, SALARY from EMPLOYEE;

-- INSERT(연봉(산술식)이 기존테이블에 없어서 오류)
insert into VW_EMP_SAL 
VALUES('400', '김상진', '123456-1234567', 'J5', 3000000, 36000000);

-- UPDATE(연봉이 기존테이블에 없어서 오류)
update VW_EMP_SAL
set 연봉 = 8000000
where EMP_ID = '200';

begin;
-- UPDATE(급여를 UPDATE는 가능)
update VW_EMP_SAL
set SALARY = 9000000
where EMP_ID = '200';

select * from VW_EMP_SAL order by EMP_ID;
select * from EMPLOYEE order by EMP_ID;

-- DELETE
delete from VW_EMP_SAL
where 연봉 = 72000000;

rollback;

-- 4) 그룹함수나 GROUP BY절에 포함되어 있는 경우
--  별칭부여(컬럼명)는 뷰명 옆에 넣어서도 가능
create view VW_GROUPDEPT (부서명, 합계, 평균)
as select DEPT_CODE, SUM(SALARY), CEIL(AVG(SALARY))
		from employee
		group by DEPT_CODE;

select * from VW_GROUPDEPT;
select * from EMPLOYEE;

-- INSERT(오류)
insert into VW_GROUPDEPT VALUES('D3', 8000000, 4000000);

-- UPDATE(오류)
update vw_groupdept
	set 합계 = 5000000
where 부서명 = 'D1';

-- DELETE(오류)
delete from vw_groupdept
where 합계 = 5210000;

-- 5) DISTINCT 구문이 포함 되어 있는 경우
create view VW_EMP_JOB
as select distinct JOB_CODE
	   from EMPLOYEE;

select * from VW_EMP_JOB;

-- INSERT(에러)
insert into VW_EMP_JOB VALUES('J8');

-- UPDATE(에러)
update VW_EMP_JOB
set JOB_CODE = 'J8'
where JOB_CODE = 'J7';




