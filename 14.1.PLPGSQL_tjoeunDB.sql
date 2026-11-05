/*
	<PL/pgSQL>
	Procedural Language / PostgreSQL
	: PostgreSQL에서 사용한는 절차적 프로그래밍 언어
	  일반 sql문에 프로그래밍의 기능을 추가한 언어
	  
	* 주요 기능
	  1) 변수선언
	  2) 조건문(IF, CASE)
	  3) 반복문(LOOP, WHILE, FOR)
	  4) 예외처리(EXCEPTION)
	  5) 함수 및 프로시저 작성
	  
	 * PL/pgSQL 기본 구조
	   
	   DO $$   -- DO는 익명 블록을 즉시 실행할 때 사용
	   [DECLARE]
	   		-- 변수 선언 영역
	   BEGIN
	   		-- 실행할 SQL 및 PL/pgSQL 구문
	   [EXCEPTION]
	   		-- 예외 처리 영역			            
	   END $$;
	   
	  * 실행방법 1 : 익명블록(일회성 작업 적합)
	    DO $$
	    BEGIN
	   		-- 실행할 SQL 및 PL/pgSQL 구문		            
	    END $$;
	    
	   * 실행방법 2 : FUNCTION 또는 PROCEDURE생성
	     >> FUNCTION 생성 및 실행
		     CREATE [OR REPLACE] FUNCTION 함수명()
		     RETURN VOID
		     AS $$
		     BEGIN
		     		-- 실행할 SQL 및 PL/pgSQL 구문
		     END;
		     $$ LANGUAGE plpgsql;
		     
		     실행시 : select 함수명();
		     
		   >>  PROCEDURE생성 및 실행(RETURN 불필요)
		      CREATE [OR REPLACE] PROCEDURE 프로시저명()
		      AS $$
		      BEGIN
		     		-- 실행할 SQL 및 PL/pgSQL 구문
			    END;
			    $$ LANGUAGE plpgsql;
			    
			    실행시 : CALL 프로시저명();	                                                                                                                                       		                                                                                                                                       		                                                                                                                                       		                                                                                                                                       	                                                                                                                                       		                                                                                                                                       		                                                                                                                                       		                                                                                                                                       
*/
do $$
begin
	raise notice 'HELLO POSTGRESQL';
end;
$$

/*
	1. DECLARE 선언부
	   변수 및 상수 선언하는 공간(선언과 동시에 초기화도 가능)
	   일반타입 변수, 레퍼런스타입 변수, ROW타입 변수
	   
	   1.1) 일반타입 변수 선언및 초기화
	   		[표현식]
	   		변수명 [CONSTANT] 자료형 [:= 값];  
 */
do $$
declare
	EID numeric;
	ENAME VARCHAR(20);
	PI CONSTANT numeric := 3.14;
begin
	EID := 800;
	ENAME := '박영호';
	raise notice 'EID : %', EID;
	raise notice 'ENAME : %', ENAME;
	raise notice 'PI : %', PI;
end;
$$

-- 사용자로 부터 입력받기
-- SETTING 부터 하고 실행하기
do $$
declare
	EID numeric := ${사번};
	ENAME VARCHAR(20) := ${이름};
	PI CONSTANT numeric := 3.14;
begin
	raise notice 'EID : %', EID;
	raise notice 'ENAME : %', ENAME;
	raise notice 'PI : %', PI;
end;
$$;

/*
	1.2) 레퍼런스 타입 변수 선언 및 초기화
			 : 어떤 테이블의 어떤 컬럼의 데이터타입을 참조	하여 그 타입으로 지정
			 
			[표현식]		
			변수명 테이블명.컬럼명%TYPE;
*/

do $$
declare
	EID EMPLOYEE.EMP_ID%type;
	ENAME EMPLOYEE.EMP_NAME%type;
	SAL EMPLOYEE.SALARY%type;
begin
	EID := '300';
	ENAME := '유재석';
	SAL := 3000000;
	raise notice '% % %', EID, ENAME, SAL;
end;
$$


-- 사번이 200번인 사원의 사번, 사원명, 급여를 조회하여 각 변수에 대입
do $$
declare
	EID EMPLOYEE.EMP_ID%type;
	ENAME EMPLOYEE.EMP_NAME%type;
	SAL EMPLOYEE.SALARY%type;
begin
	select EMP_ID, EMP_NAME, SALARY
		into EID, ENAME, SAL
		from EMPLOYEE
	 -- where EMP_ID = '200';
	 WHERE EMP_ID = ${사번};

	raise notice '사번 : %', EID;
	raise notice '사원명 : %', ENAME;
	raise notice '급여 : %', SAL;
end;
$$

---------------------- 문제
/*
	레퍼런스타입변수로 EID, ENAME, JCODE, SAL, DTITLE을 선언하고
	각 자료형에 EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE(DEPARTMENT)
	
	사용자가 입력한 사번의 사번, 사원명, 직급코드, 급여, 부서명을 출력
 */























