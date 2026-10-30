/*
	<SUBQUERY>
	- 하나의 SQL문안에 포함된 또 다른 SELECT문
	- 메인 SQL문을 위해 보조 역할을 하는 쿼리문
*/

-- 박서준과 같은 부서에 속한 사원들의 이름 조회
-- 1. 박서준의 부서코드 조회
select DEPT_CODE
from employee
where EMP_NAME = '박서준';  -- D9

-- 2. 부서코드가 D9인 사원들 조회
select EMP_NAME
from employee
where DEPT_CODE = 'D9';

--> 위의 단계를 하나의 쿼리문으로
select EMP_NAME
from employee
where DEPT_CODE = (select DEPT_CODE
										from employee
										where EMP_NAME = '박서준');

-- 전 직원의 평균급여보다 더 많은 급여를 받는 사원들의 사번, 사원명, 급여 조회
-- 1. 평균 급여
select AVG(SALARY)
from employee;  -- 3047662

-- 2. 급여가 3047662보다 많이 받는사람
select EMP_ID, EMP_NAME, SALARY
from employee
where SALARY > 3047662;

--> 위의 단계를 하나의 쿼리문으로
select EMP_ID, EMP_NAME, SALARY
from employee
where SALARY > (select AVG(SALARY)
									from employee);

-----------------------------------------------------------------------
/*
	* 서브쿼리의 구분
	  : 서브쿼리를 수행한 결과값이 몇행 몇열 이냐에 따라 구분
	  
	  - 단일행 서브쿼리 : 서브쿼리의 결과값이 오로지 1개 일 때(한행 한열)
	  - 다중행 서브쿼리 : 서브쿼리의 결과값이 여러행 일 때(여러행 한열)
	  - 다중열 서브쿼리 : 서브쿼리의 결과값이 여러열 일 때(한행 여러열)
	  - 다중행 다중열 서브쿼리 : 서브쿼리의 결과값이 여러행 여러열 일 때(여러행 여러열)
	  
	  >> 서브쿼리의 종류에 따라 서브쿼리 앞에 붙는 연산자가 달라짐
 */

/*
	1. 단일행 서브쿼리(SINGLE ROW SUBQUERY)
		 : 서브쿼리의 결과값이 오로지 1개 일 때(한행 한열)
		 
		 일반 비교연사자 사용가능
		 =, !=, >, ...	 
 */

-- 1) 전 직원의 평균급여보다 급여를 적게 받는 사원들의 사원명, 직급코드, 급여 조회
select EMP_NAME, JOB_CODE, SALARY
from employee
where SALARY < (select AVG(SALARY)
									from EMPLOYEE)
order by SALARY;

-- 2) 최저급여를 받는 사원의 사번, 사원명, 급여, 입사일 조회
select EMP_ID, EMP_NAME, SALARY, HIRE_DATE
from employee
where SALARY = (select MIN(SALARY)
									from EMPLOYEE);

-- 3) 조정연 사원의 급여보다 더 많이 받는 사원의 사번, 사원명, 부서코드, 급여 조회
select EMP_ID, EMP_NAME, DEPT_CODE, SALARY
from employee
where SALARY > (select salary
									from employee
									where EMP_NAME = '조정연');

-- JOIN
-- 4) 조정연 사원의 급여보다 더 많이 받는 사원의 사번, 사원명, 부서명, 급여 조회 
select EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
from employee
join DEPARTMENT on (DEPT_CODE = DEPT_ID)
where SALARY > (select salary
									from employee
									where EMP_NAME = '조정연');

-- 5) 왕건우사원과 같은 부서원들의 사번, 사원명, 전화번호, 입사일, 부서명 조회. 왕건우 제외
select EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
from employee
join DEPARTMENT on (DEPT_CODE = DEPT_ID)
where DEPT_CODE = (select dept_code
										from employee
										where EMP_NAME = '왕건우')
	and EMP_NAME != '왕건우';

-- GROUP BY
-- 6) 부서별 급여 합계가 가장 큰 부서의 부서코드, 급여합 조회
-- 6.1 부서별 급여합 중에서 가장 큰 값 하나만 조회
/*   안됨
select DEPT_CODE, MAX(SUM(SALARY))
from employee
group by DEPT_CODE;
*/ 

select SUM(SALARY)
from employee
group by dept_code
order by SUM(SALARY) desc
limit 1;   -- 17,700,000


-- 6.2 
select DEPT_CODE, SUM(SALARY)
from employee
group by dept_codE
having SUM(SALARY) = 17700000;


select DEPT_CODE, SUM(SALARY)
from employee
group by dept_codE
having SUM(SALARY) = (select SUM(SALARY)
												from employee
												group by dept_code
												order by SUM(SALARY) desc
												limit 1);



