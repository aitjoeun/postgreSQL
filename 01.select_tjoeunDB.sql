/*
	여러줄 주석 : ctrl+shift+/
*/
--  한줄 주석 : ctrl + /
/*
 * DML(Data Manipulation Language) : 데이터 조작언어
   : 테이블에 값을 검색(select), 삽입(insert), 수정(update), 삭제(delete)하는 구문
*/
--====================================================================
/*
 (') 홑따옴표 : 문자열을 감싸주는 기호
 (") 쌍따옴표 : 컬럼명 등을 감싸주는 기호
*/

/*
 	<select>
   데이터 조회할 때 사용
   
   >> Result set : 행들의 집합
   
   [표현법]
   SELECT 조회하고자하는 컬럼, 컬럼, ...
   FROM 테이블명;
 */

-- EMPLOYEE테이블에 있는 모든 컬럼(*)조회
select *
from EMPLOYEE;

-- EMPLOYEE테이블에서 사번, 이름, 급여 조회
select EMP_ID, EMP_NAME, SALARY
from EMPLOYEE;

-- JOB테이블의 모든 컬럼 조회
select *
from JOB;

---------------- 실습문제 -------------------
-- 1. JOB테이블에서 직급명만 조회
select JOB_NAME 
from JOB;

-- 2. DEPARTMENT테이블에서 모든 컬럼 조회
select * from department;

-- 3. DEPARTMENT테이블에서 테이블의 부서코드, 부서명 조회
select DEPT_ID, DEPT_TITLE from DEPARTMENT;

-- 4. EMPLOYEE테이블에서 사번, 사원명, 이메일, 전화번호, 입사일, 급여 조회
select EMP_ID, EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
from EMPLOYEE;

/*
  <컬럼값을 통한 산술연산>
  SELECT절 컬럼명 작성부분에 산술연산 쓸수 있다
*/
-- EPLOYEE테이블에서 사원명, 사원의 연봉 조회
select EMP_NAME, SALARY*12
from EMPLOYEE;

-- EMPLYEE에서 사원명, 보너스, 급여 조회
select EMP_NAME, BONUS, SALARY
from EMPLOYEE;

-- EMPLOYEE에서 사원명, 급여, 보너스, 연봉, 보너스가포함된연봉 조회
select EMP_NAME, SALARY, BONUS, SALARY*12, (BONUS*SALARY+SALARY)*12
from EMPLOYEE;

-- EMPLOYEE에서 사원명, 입사일, 근무일수
-- DATE형식끼리 연산 가능 : +, -
-- 오늘 날짜 CURRENT_DATE
select EMP_NAME, HIRE_DATE, CURRENT_DATE - HIRE_DATE
from EMPLOYEE;

-----------------------------------------------------------------
/*
  <컬럼명에 별칭 지정하기>
  산술연산시 컬럼명이 ?column?으로 나옴. 이때 별칭을 부여하여 처리
  
  [표현법]
  컬럼명 별칭 / 컬럼명 as 별칭 / 컬럼명 "별칭" / 컬럼명 as "별칭"
  
  * 반드시 별칭에 쌍따옴표("")가 들어가야 할 때
     -> 별칭에 띄어쓰기가 들어 있던지, 특수문자가 포함되어 있는 경우
 */

select EMP_NAME
			,SALARY
			,BONUS
			,SALARY*12 연봉
			,(BONUS*SALARY+SALARY)*12 총소득
from EMPLOYEE;

select EMP_NAME, SALARY, BONUS, SALARY*12 "연봉(원)", (BONUS*SALARY+SALARY)*12 "총 소득"
from EMPLOYEE;













