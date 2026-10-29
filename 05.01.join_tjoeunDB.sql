/*
	<JOIN>
	두개 이상의 테이블에서 데이터를 조회하고자 할 때 사용하는 구문
	조회결과는 하나의 결과물(RESULT SET)로 나옴
	
	- 관계형 데이터베이스는 최소한의 데이터로 각각 테이블에 담고 있어야 함
	  (중복제거를 위해)
	=> 관계형 데이터베이스에서 SQL문을 이용하여 테이블간의 '관계'를 맺는 방법
	
										[JOIN 용어 정리]
	1. 내부조인(INNER JOIN)		=> JOIN ON / JOIN USING
		 자연조인(NATURAL JOIN) => 동일한 컬럼을 자동 조인
	2. 외부조인(OUTER JOIN)
			- 왼쪽 외부 조인(LEFT OUTER JOIN / LEFT JOIN)
			- 오른쪽 외부 조인(RIGHT OUTER JOIN / RIGHT JOIN)
			- 전체 외부 조인(FULL OUTER JOIN / FULL JOIN)
	3. 비등가 조인(NON-EQUAL JOIN)	=> JOIN ON (동등 '=' 비교가 아닌 조인)
	4. 자체 조인(SELF JOIN)				=> JOIN ON (같은 테이블끼리 조인)
	5. 교차 조인(CROSS JOIN)			=> 모든 경우의 수 / 카테시안 곱
*/

--  전체 사원들의 사번, 사원명, 부서코드, 부서명을 조회하고자 한다
select EMP_ID, EMP_NAME, DEPT_CODE
from EMPLOYEE;

select DEPT_ID, DEPT_TITLE
from DEPARTMENT;

--=============================================================================
/*
	1. 등가조인(EQUAL JOIN) / 내부조인(INNER JOIN)
		 연결시키는 컬럼의 값이 "일치하는 행들만" 조인이 되어 조회
 */
-----------------------------------------------------------
-- 1) 연결할 두 컬럼명이 다른 경우()
--		=> 오직 JOIN ON 구문만 사용 가능
--  EMPLOYEE : DEPT_CODE / DEPARTMENT : DEPT_ID
select EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
from EMPLOYEE, DEPARTMENT;
-- DEPARTMENT 행당 23명씩 TOTAL 207행이 나옴

select EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
from employee
join DEPARTMENT on (DEPT_CODE = DEPT_ID);

-----------------------------------------------------------
-- 2) 연결할 두 컬럼명이 같은 경우()
--		=> JOIN ON 또는 JOIN USING 구문 사용 가능
-- EMPLOYEE : JOB_CODE / JOB : JOB_CODE
select EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
from employee
join JOB on (JOB_CODE = JOB_CODE); -- 오류 발생
-- JOB_CODE가 어느테이블의 JOB_CODE인지 알지 못해서

-- 해결방법 1) JOIN ON + 테이블을 명시(별칭도 가능)
select EMP_ID, EMP_NAME, employee.JOB_CODE, JOB_NAME
from employee
join JOB on (employee.JOB_CODE = JOB.JOB_CODE);

select EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
from employee E
join JOB J on (E.JOB_CODE = J.JOB_CODE);

-- 해결방법 2) JOIN USING사용(컬럼명이 같을 때만 사용 가능)
select EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
from employee
join JOB using (JOB_CODE);

---------------------------------------------------------------
-- 3) NUTURAL JOIN
-- 두 테이블에서 이름 같은 컬럼 자동으로 찾아서 매칭해줌
select EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
from employee
natural join JOB;

---------------------------------------------------------------
-- 4) 조인과 함께 조건 제시
-- 직급이 대리인 사원의 사번, 이름, 직급명, 급여를 조회

-- JOIN ON 사용 
select EMP_ID, EMP_NAME, JOB_NAME, SALARY
from employee E
join JOB J on (E.JOB_CODE = J.JOB_CODE)
where JOB_NAME = '대리';

-- JOIN USING 사용
select EMP_ID, EMP_NAME, JOB_NAME, SALARY
from employee
join JOB USING (JOB_CODE)
where JOB_NAME = '대리';

----------------------------  연습 문제 ----------------------------------
-- 1. 부서가 인사관리부인 사원들의 사번, 사원명, 부서명, 보너스 조회

-- 2. DEPARTMENT와 LOCATION테이블을 참조하여 부서코드, 부서명, 지역코드, 지역명 조회

-- 3. 보너스를 받은 사원들의 사번, 사원명, 보너스, 부서명 조회

-- 4. 부서가 총부부가 아닌 사원들의 사원명, 급여, 부서명 조회





