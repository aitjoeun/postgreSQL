
/*
문제 1. VW_PRACTICE_COUNTRY 뷰를 생성
조회할 컬럼:
- 사번(EMP_ID)
- 사원명(EMP_NAME)
- 부서명(DEPT_TITLE)
- 급여(SALARY)
- 국가명(NATIONAL_NAME)
*/


/*
문제 2. 문제 1에서 만든 VW_PRACTICE_COUNTRY 뷰를 이용하여 다음 국가에서 근무하는 사원의 모든 정보를 각각 조회
1) 한국
2) 러시아
3) 일본
*/



/*
문제 3. VW_PRACTICE_EMP_JOB 뷰를 생성
조회할 컬럼:
- 사번
- 사원명
- 직급명
- 성별
- 근무년수
*/



/*
문제 4. VW_PRACTICE_EMP_JOB 뷰를 CREATE OR REPLACE VIEW로 다시 정의하기
이번에는 CREATE VIEW 뒤에 컬럼 별칭 목록을 작성하여 다음 이름으로 조회되도록 하기
> 사번, 이름, 직급명, 성별, 근무년수
*/



/*
문제 5. VW_PRACTICE_EMP_SAL 뷰를 생성
조회할 컬럼:
- 사번
- 사원명
- 급여
- 연봉(급여 * 12) 별칭지정

연봉이 40,000,000 이상인 사원을 조회
*/


/*
문제 6.
JOB 복사 테이블에서 JOB_CODE와 JOB_NAME만 조회하는 VW_PRACTICE_JOB 뷰 생성

그다음 트랜잭션 안에서 다음 작업을 순서대로 수행
1) 직급코드 J8, 직급명 '인턴' INSERT
2) J8의 직급명을 '아르바이트'로 UPDATE
3) J8 데이터 DELETE
4) ROLLBACK하여 원본 JOB 테이블을 원래 상태로 복구
*/


/*
문제 7. JOB 테이블에서 JOB_CODE만 조회하는 VW_PRACTICE_JOB_NAME 뷰 생성

그다음 아래 작업이 왜 불가능한지 확인
- 뷰에 없는 JOB_NAME 컬럼을 INSERT 대상으로 지정
- 뷰에 없는 JOB_NAME 컬럼을 UPDATE
*/


/*
문제 8. 다음 4개의 뷰를 각각 생성

1) VW_PRACTICE_DEPT_SAL
   - EMPLOYEE에서 부서코드별 급여 합계와 평균 급여 조회
   - GROUP BY 사용

2) VW_PRACTICE_DISTINCT
   - EMPLOYEE에서 중복을 제거한 JOB_CODE 조회
   - DISTINCT 사용

3) VW_PRACTICE_JOIN
   - EMPLOYEE와 DEPARTMENT를 JOIN하여
     사번, 사원명, 부서명 조회

4) 위 뷰들을 조회
*/

/*
문제 9. VW_PRACTICE_CHECK 뷰를 생성
조건: SALARY >= 3000000

그다음 트랜잭션 안에서 사번 200의 급여를 2000000으로 변경하고,
EMPLOYEE와 VW_PRACTICE_CHECK를 각각 조회.

마지막에는 ROLLBACK하여 원본 데이터를 복구.
*/


/*
문제 10. VW_PRACTICE_CHECK 뷰를 CREATE OR REPLACE VIEW로 다시 정의
조건은 SALARY >= 3000000이며 WITH CHECK OPTION을 지정

그다음 다음 작업을 수행
1) 사번 200의 급여를 4000000으로 변경하는 UPDATE 실행
2) 변경 결과를 조회
3) ROLLBACK하여 원본 데이터 복구
*/

-- 문제 11. 지금까지 만든 모든 view들을 삭제