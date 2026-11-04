-- DEPARTMENT테이블의 구조와 데이터를 복사한 PRACTICE_DEPT테이블을 만들어 실습

/*
문제 1. PRACTICE_DEPT 테이블에 REGION_CODE 컬럼을 추가
- 자료형: VARCHAR(10)
- 기존 데이터의 REGION_CODE 값은 NULL이 되도록
*/


/*
문제 2. PRACTICE_DEPT 테이블에 COUNTRY_NAME 컬럼을 추가
- 자료형: VARCHAR(20)
- 기본값: '한국'
*/


-- 문제 3. PRACTICE_DEPT의 DEPT_TITLE 컬럼 자료형을 VARCHAR(100)으로 변경



/*
문제 4. COUNTRY_NAME 컬럼의 기본값을 '미국'으로 변경
기존에 저장된 데이터는 변경하지 않고, 앞으로 입력되는 행의 기본값만 변경
*/


-- 문제 5. PRACTICE_DEPT 테이블에서 REGION_CODE 컬럼을 삭제


/*
문제 6. PRACTICE_DEPT 테이블에 다음 제약조건을 추가
1) DEPT_ID에 PRIMARY KEY 제약조건을 추가하고 이름은 PRACTICE_DEPT_PK로 지정
2) DEPT_TITLE에 UNIQUE 제약조건을 추가하고 이름은 PRACTICE_DEPT_UQ로 지정
3) COUNTRY_NAME에 NOT NULL 제약조건을 추가
*/


/*
문제 7.
PRACTICE_DEPT 테이블에서 다음 제약조건을 삭제
1) PRACTICE_DEPT_UQ 제약조건 삭제
2) COUNTRY_NAME 컬럼의 NOT NULL 제약조건 해제
*/


-- 문제 8. PRACTICE_DEPT 테이블의 DEPT_TITLE 컬럼명을 DEPT_NAME으로 변경


-- 문제 9. PRACTICE_DEPT 테이블의 PRIMARY KEY 제약조건명을 PRACTICE_DEPT_PK를 DEPT_COPY_PK로 변경


/*
문제 10. 아래 작업을 순서대로 수행하기
1) PRACTICE_DEPT 테이블명을 PRACTICE_DEPT_FINAL로 변경
2) PRACTICE_DEPT_FINAL의 DEPT_ID를 참조하는 자식 테이블
   PRACTICE_DEPT_CHILD를 생성
   - CHILD_ID INT PRIMARY KEY
   - DEPT_ID는 PRACTICE_DEPT_FINAL(DEPT_ID)를 참조하는 FOREIGN KEY
3) 부모 테이블 PRACTICE_DEPT_FINAL을 CASCADE 옵션으로 삭제
4) 자식 테이블 PRACTICE_DEPT_CHILD도 삭제
*/