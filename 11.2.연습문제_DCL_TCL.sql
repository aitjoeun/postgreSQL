
/*
문제 1.
다음 조건에 맞는 로그인 Role을 생성
- Role 이름: practice_dcl_user
- 비밀번호: test1234
- 로그인 가능하도록 설정
*/
CREATE ROLE practice_dcl_user LOGIN PASSWORD 'test1234';

-- 문제 2. practice_dcl_user에게 tjoeun 데이터베이스에 접속할 수 있는 CONNECT 권한을 부여
GRANT CONNECT ON DATABASE tjoeun TO practice_dcl_user;

-- 문제 3. practice_dcl_user에게 public 스키마를 사용할 수 있는 USAGE 권한을 부여
GRANT USAGE ON SCHEMA public TO practice_dcl_user;

-- 문제 4. practice_dcl_user에게 EMPLOYEE 테이블을 조회할 수 있는 SELECT 권한만 부여하세요.
GRANT SELECT ON TABLE EMPLOYEE TO practice_dcl_user;

/*
문제 5.
다음 작업을 순서대로 수행
1) practice_dcl_user에게 EMPLOYEE 테이블의 INSERT, UPDATE, DELETE 권한을 부여
2) 부여한 권한 중 INSERT 권한만 회수
3) practice_dcl_user가 EMPLOYEE 테이블에 보유한 권한을 확인하는 SELECT문을 작성
*/
-- 1)
GRANT INSERT, UPDATE, DELETE ON TABLE EMPLOYEE TO practice_dcl_user;
-- 2)
REVOKE INSERT ON TABLE EMPLOYEE TO practice_dcl_user;
-- 3)
SELECT *
FROM INFORMATION_SCHEMA.ROLE_TABLE_GRANTS
WHERE GRANTEE = 'practice_dcl_user'
 AND TABLE_NAME = 'employee';

-- ===========================================================================
-- 현재 접속 세션에서만 사용 접속을 종료하면 자동 삭제되는 테이블을 생성 후 문제풀기
CREATE TEMP TABLE practice_emp AS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE;
-- ===========================================================================

/*
문제 6. 다음 작업을 수행하기
1) 트랜잭션을 시작
2) 사번이 200인 사원의 급여를 1000000 증가시키기
3) 변경된 급여를 SELECT로 확인
4) ROLLBACK으로 변경사항을 취소
5) 다시 조회하여 원래 급여로 돌아왔는지 확인
*/
BEGIN;

UPDATE practice_emp
SET SALARY = SALARY + 1000000
WHERE EMP_ID = '200';

SELECT EMP_ID, SALARY
FROM practice_emp
WHERE EMP_ID = '200';

ROLLBACK;

SELECT EMP_ID, SALARY
FROM practice_emp
WHERE EMP_ID = '200';

/*
문제 7. 다음 작업을 순서대로 수행하기.
1) 트랜잭션을 시작
2) 사번이 201인 사원의 급여를 500000 증가시키기
3) COMMIT으로 변경사항을 확정
4) 다시 조회하여 변경된 급여가 유지되는지 확인
*/
BEGIN;

UPDATE practice_emp
SET SALARY = SALARY + 500000
WHERE EMP_ID = '201';

COMMIT;

SELECT EMP_ID, SALARY
FROM practice_emp
WHERE EMP_ID = '201';


/*
문제 8. 다음 작업을 순서대로 수행
1) 트랜잭션을 시작
2) 사번이 202인 사원의 급여를 300000 증가시키기
3) SAVEPOINT SP1을 생성
4) 사번이 203인 사원의 급여를 400000 증가
5) ROLLBACK TO SP1을 실행
6) 사번 202와 203의 급여를 각각 조회
7) COMMIT하기

※ SP1 이전의 변경은 유지되고, SP1 이후의 변경은 취소되어야 함
*/
BEGIN;

UPDATE practice_emp
SET SALARY = SALARY + 300000
WHERE EMP_ID = '202';

SAVEPOINT SP1;

UPDATE practice_emp
SET SALARY = SALARY + 400000
WHERE EMP_ID = '203';

ROLLBACK TO SP1;

SELECT EMP_ID, SALARY
FROM practice_emp
WHERE EMP_ID IN ('202','203');

COMMIT;
/*
문제 9. 다음 작업을 순서대로 수행
1) 트랜잭션을 시작하기
2) 사번 204의 급여를 100000 증가시키기
3) SAVEPOINT SP_A를 생성하기
4) 사번 205의 급여를 200000 증가시키기
5) SAVEPOINT SP_B를 생성하기.
6) 사번 206의 급여를 300000 증가시키기
7) ROLLBACK TO SP_A를 실행하기
8) 사번 204, 205, 206의 급여를 조회하기
9) COMMIT하기.

※ SP_A 이전 변경만 남고, SP_A 이후 변경은 모두 취소되어야 함
*/
BEGIN;

UPDATE practice_emp
SET SALARY = SALARY + 100000
WHERE EMP_ID = '204';

SAVEPOINT SP_A;

UPDATE practice_emp
SET SALARY = SALARY + 200000
WHERE EMP_ID = '205';

SAVEPOINT SP_B;

UPDATE practice_emp
SET SALARY = SALARY + 300000
WHERE EMP_ID = '206';

ROLLBACK TO SP_A;

SELECT EMP_ID, SALARY
FROM practice_emp
WHERE EMP_ID IN ('204','205', '206');

COMMIT;
/*
문제 10. 다음 작업을 순서대로 수행
1) 트랜잭션을 시작하기
2) 임시 테이블에 다음 데이터를 INSERT하기
   - 사번: 900
   - 이름: 연습사원
   - 부서코드: D1
   - 급여: 2500000
3) 사번이 200인 사원을 DELETE하기
4) SELECT로 사번 900과 200의 존재 여부를 확인하기.
5) ROLLBACK으로 모든 변경사항을 취소하기
6) 다시 조회하여 사번 900은 없고, 사번 200은 복구되었는지 확인하기
*/
BEGIN;

INSERT INTO practice_emp VALUES('900','연습사원','D1', 2500000);

DELETE FROM practice_emp WHERE EMP_ID = '200';

SELECT *
FROM practice_emp
WHERE EMP_ID IN ('900','200');

ROLLBACK;

SELECT *
FROM practice_emp
WHERE EMP_ID IN ('900','200');

-- 문제 11. 문제1~5까지 주었던 모든 권한 삭제
REVOKE ALL PRIVLEGES ON TABLE EMPLOYEE FROM practice_emp;
REVOKE USAGE ON SCHEMA PUBLIC FROM practice_emp;
REVOKE CONNECT ON DATABASE TJOEUN FROM practice_emp;