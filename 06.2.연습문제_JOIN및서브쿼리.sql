-- SUBQUERY_연습문제
-- 1. 70년대 생(1970~1979) 중 여자이면서 이씨인 사원의 
--     사원명, 주민번호, 부서명, 직급명 조회
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE SUBSTR(EMP_NO, 1, 2) >= '70' AND SUBSTR(EMP_NO, 1, 2) <= '79'
  AND SUBSTR(EMP_NO, 8, 1) IN ('2','4')
  AND EMP_NAME LIKE '이%';

-- EXTRECT() 사용
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
-- where EXTRACT(year from TO_DATE(SUBSTR(EMP_NO, 1, 2), 'YY'))
where EXTRACT(year from TO_DATE('19' || SUBSTR(EMP_NO, 1, 2), 'YYYY'))  -- 정확히 하려면
			between 1970 and 1979
  AND SUBSTR(EMP_NO, 8, 1) IN ('2','4')
  AND EMP_NAME LIKE '이%';

-- TO_CHAR() 사용
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
where TO_CHAR(TO_DATE('19' || SUBSTR(EMP_NO, 1, 2),'YYYY'), 'YYYY')::INT
			between 1970 and 1979
  AND SUBSTR(EMP_NO, 8, 1) IN ('2','4')
  AND EMP_NAME LIKE '이%';

-- 2. 나이가 가장 막내의 사번, 사원명, 나이, 부서명, 직급명 조회
select EMP_ID, EMP_NAME
, EXTRACT(year from CURRENT_DATE) - EXTRACT(year from TO_DATE(SUBSTR(EMP_NO, 1, 2), 'YY')) 나이
, DEPT_TITLE, JOB_NAME 
from employee
join DEPARTMENT on (DEPT_CODE = DEPT_ID)
join JOB USING(JOB_CODE)
order by TO_DATE(SUBSTR(EMP_NO,1,6),'YYMMDD') DESC
limit 1;

-- 3. 이름에 ‘하’가 들어가는 사원의 사번, 사원명, 직급명 조회
select EMP_ID, EMP_NAME, JOB_NAME
from employee
join JOB USING(JOB_CODE)
where EMP_NAME like '%하%';

-- 4. 부서 코드가 D5이거나 D6인 사원의 사원명, 직급명, 부서코드, 부서명 조회
select EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
from employee
join department on (DEPT_CODE = DEPT_ID)
join JOB USING(JOB_CODE)
where DEPT_ID in ('D5','D6');

-- 5. 보너스를 받는 사원의 사원명, 보너스, 부서명, 지역명 조회
select EMP_NAME, BONUS, DEPT_TITLE, LOCAL_NAME
from employee
left join DEPARTMENT on (DEPT_CODE = DEPT_ID)
left join location on (LOCATION_ID = LOCAL_CODE)
where BONUS is not null;

-- 6. 모든 사원의 사원명, 직급명, 부서명, 지역명 조회
select EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
from employee
left join DEPARTMENT on (DEPT_CODE = DEPT_ID)
left join JOB USING(JOB_CODE)
left join location on (LOCATION_ID = LOCAL_CODE);

-- 7. 한국이나 일본에서 근무 중인 사원의 사원명, 부서명, 지역명, 국가명 조회 
select EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
from employee
join DEPARTMENT on (DEPT_CODE = DEPT_ID)
join location on (LOCATION_ID = LOCAL_CODE)
join national USING(NATIONAL_CODE)
where NATIONAL_NAME in ('한국', '일본');

-- 8. 하정연 사원과 같은 부서에서 일하는 사원의 사원명, 부서코드 조회
select EMP_NAME, DEPT_CODE
from employee
where DEPT_CODE = (select dept_code
										from employee
										where EMP_NAME = '하정연');

-- 9. 보너스가 없고 직급 코드가 J4이거나 J7인 사원의 사원명, 직급명, 급여 조회
select EMP_NAME, JOB_NAME, SALARY
from employee
join JOB using (JOB_CODE)
where BONUS is null
  and JOB_CODE in ('J4','J7');

-- 10. 퇴사 하지 않은 사람과 퇴사한 사람의 수 조회
select ENT_YN, COUNT(*)
from employee
group by ENT_YN;

-- 11. 보너스 포함한 연봉이 높은 5명의 사번, 사원명, 부서명, 직급명, 입사일, 순위 조회
select *
from (select EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE,
					  ROW_NUMBER() OVER(order by (SALARY + (SALARY * coalesce(BONUS, 0)) * 12) DESC) as 연봉
				from EMPLOYEE
				join DEPARTMENT D on (DEPT_CODE = DEPT_ID)
				join JOB USING(JOB_CODE)
			)
limit 5;

-- 12. 부서 별 급여 합계가 전체 급여 총 합의 20%보다 많은 부서의 부서명, 부서별 급여 합계 조회
--	12-1. JOIN과 HAVING 사용                
--	12-2. 인라인 뷰 사용      
--	12-3. WITH 사용

-- 13. 부서명별 급여 합계 조회(NULL도 조회되도록)

-- 14. WITH를 이용하여 급여합과 급여평균 조회
