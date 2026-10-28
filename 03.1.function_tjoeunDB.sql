/*
	<함수 FUNCTION>
	전달된 컬럼값을 읽어들여 함수를 실행한 결과 반환
	
	- 단일행 함수 : N개의 값을 읽어들여 N개의 결과값 반환(매 행마다 함수 실행)
	- 그룹 함수 : N개의 값을 읽어들여 1개의 결과값 반환(그룹별로 함수 실행)
	
	>> SELECT절에 단행함수와 그룹함수를 함께 사용할 수 없음
	>> 함수식을 기술할 수 있는 위치 : SELECT절, WHERE절, ORDER BY절, HAVING절
*/

------------------------------ 단일행 함수 ----------------------------------

--=========================================================================
--													<문자 처리 함수>
--=========================================================================
/*
	* LENGTH / OCTET_LENGTH => INTEGER로 반환
		
		LENGTH(컬럼명 | '문자열') : 해당 글자수 반환
		OCTET_LENGTH(컬럼명 | '문자열') : 해당 문자열의 BYTE수 반환
			- 한글 : 1글자당 3byte  /  영문, 숫자, 공백 : 1글자당 1byte
 */
select LENGTH('데이터베이스'), OCTET_LENGTH('데이터베이스');

select LENGTH('postgreSQL'), OCTET_LENGTH('postgreSQL');

select emp_name, length(emp_name), octet_length(emp_name)
			,email, length(email), octet_length(email)
from employee;

-------------------------------------------------------------------------------
/*
	* LEFT / RIGHT('문자열', 글자수) : 왼쪽/오른쪽 끝에서 부터 지정한 개수만큼 문자열 반환
		> 글자수에 음수를 넣으면 맨 뒤/앞의 글자수만큼 제외하고 나머지 전부
*/

select LEFT('databaseprostgresql', 4);
select RIGHT('databaseprostgresql', 3);
select RIGHT('서울특별시', 3);

select LEFT('DATABASESQL', -3);	-- 맨 뒤의 글자 3개를 제외하고
select RIGHT('DATABASEPostgreSQL', -8);		-- 맨 앞의 글자 8개를 제외하고

select RIGHT('DATA', 100);		-- 커도 상관없음
select RIGHT('DATA', 0);		-- 빈 문자열 반환

-------------------------------------------------------------------------------
/*
	* POSITION / STRPOS : 문자열로부터 특정 문자의 시작위치(INDEX)를 찾아서 반환(1부터 시작, 없으면 0)
*/

select POSITION('A' in 'DATABASE');
select STRPOS('DATABASE', 'A');		-- 결과동일
select POSITION('A' in REVERSE('DATABASE'));	-- 결과 3  : ESABATAD 에서 A의 위치 -> 3

select EMAIL
			,POSITION('_' in EMAIL) as "_위치"
			,POSITION('@' in EMAIL) as "@위치"
from EMPLOYEE;

-------------------------------------------------------------------------------
/*
	* SUBSTR / SUBSTRING : 문자열에서 특정 문자열을 추출
	
	- SUBSTR('문자열', POSITION, [LENGTH])
		> POSITION : 문자열을 추출할 시작위치 INDEX
		> LENGTH : 추출할 문자 갯수(생략시 맨 끝까지 추출)
	- SUBSTRING('문자열', from POSITION [for LENGTH])
*/

select SUBSTR('DATABASESQL', 5);
select SUBSTRING('DATABASESQL' from 5);

select SUBSTR('DATABASESQL', 5, 4);
select SUBSTRING('DATABASESQL' from 5 for 4);

select SUBSTR('DATABASESQL', 3, 6);
select SUBSTRING('DATABASESQL' from 3 for 6);

-- EMPLOYEE테이블에서 주민번호에 성별만 추출하여 주민번호, 사원명, 성별 조회
select EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) 성별
from EMPLOYEE;

select EMP_NAME, EMP_NO, SUBSTRING(EMP_NO from 8 for 1) 성별
from EMPLOYEE;

-- EMPLOYEE테이블에서 여자 사원들만 사번, 사원명, 성별(1~4중 하나) 조회
select emp_id, EMP_NAME, SUBSTRING(EMP_NO from 8 for 1) 성별
from EMPLOYEE
where SUBSTRING(EMP_NO from 8 for 1) = '2' or SUBSTRING(EMP_NO from 8 for 1) = '4';

-- EMPLOYEE테이블에서 남자 사원들만 사번, 사원명, 성별(1~4중 하나) 조회
select EMP_ID, EMP_NAME, SUBSTR(EMP_NO, 8, 1) 성별
from EMPLOYEE
where SUBSTR(EMP_NO, 8, 1) in ('1', '3');

-- EMPLOYEE테이블에서 EMAIL의 아이디만 추출하여 사원명, 이메일, 아이디 조회
select EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, position('@' in EMAIL)-1) 아이디
from EMPLOYEE;

select EMP_NAME, EMAIL, SUBSTRING(EMAIL from 1 FOR position('@' in EMAIL)-1) 아이디
from EMPLOYEE;

-------------------------------------------------------------------------------
/*
	* LPAD / RPAD : 문자열 조회할 때 길이를 맞춰 통일감있게 조회하고자 할 때
	
		LPAD/RPAD('문자열', 최종반환할 문자의 길이, [덧붙이고자하는 문자])
*/
-- 25길이에 맞춰 EMAIL을 오른쪽 정렬하고 앞부분은 공백으로 채워서 출력
select EMP_NAME, LPAD(EMAIL, 25)  -- 덧붙이고자하는 문자 생략시 기본값 공백
from EMPLOYEE;

select EMP_NAME, LPAD(EMAIL, 25, '#')
from EMPLOYEE;

select EMP_NAME, RPAD(EMAIL, 25, '#')
from EMPLOYEE;

-- EMPLOYEE테이블에서 사번, 사원명, 주민번호 출력(주민번호는 123456-1****** 의 형식으로)
select EMP_ID, EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') as 주민번호
from EMPLOYEE;

select EMP_ID, EMP_NAME, SUBSTR(EMP_NO, 1, 8) || '******' as 주민번호
from EMPLOYEE;

-------------------------------------------------------------------------------
/*
	* LTRIM / RTRIM : 문자열에서 특정 문자를 제거하고 반환
	* TRIM : 문자의 앞/뒤 양쪽에 있는 특정 문자들을 제거한 나머지 반환
	
		LTRIM / RTRIM('문자열', [제거하고자하는 문자]) -> 제거하고자하는 문자를 생략시 공백제거
		TRIM([LEADING|TRAILING|BOTH]제거하고자하는 문자 FROM '문자열')
*/
select LTRIM('     TJOEUN      ') || '컴퓨터아카데미';
select RTRIM('     TJOEUN      ') || '컴퓨터아카데미';

select LTRIM('DATADATABASE', 'DATA');
select LTRIM('BACABAADEIASDJ', 'ABC');
select LTRIM('3724KSJDIF37284', '0123456789');

select RTRIM('3724KSJDIF37284', '0123456789');

select TRIM('      TJOEUN      ') || '컴퓨터아카데미';  -- 기본값 양쪽 제거

-- 방향 지정
select TRIM(leading 'A' from 'AAAAABKD2871ADKA');
select TRIM(trailing 'A' from 'AAADKWO384AAAA');
select TRIM(both 'A' from 'AAADKWO384AAAA');		-- 기본값
select TRIM('A' from 'AAADKWO384AAAA');

-------------------------------------------------------------------------------
/*
	* LOWER / UPPER / INITCAP : 문자열을 대소문자로 변환 및 단어의 앞글자만 대문자로 변환
	  LOWER('문자열')
*/

select LOWER('DATABASE PostgreSQL');
select upper('DATABASE PostgreSQL');
select initcap('database postgreSQL');

-------------------------------------------------------------------------------
/*
	* CONCAT : 문자열 두개를 하나로 합친 결과 반환
	
	  CONCAT('문자열','문자열',...) 
 */

select CONCAT('SQL', '포스트그레');
select CONCAT('PostgreSQL', '데이터베이스', '02-1234-3456');

select 'SQL' || '포스트그레';

-------------------------------------------------------------------------------
/*
	* REPLACE : 기존문자열을 새로운 문자열로 변경
	
	  [표현법]
	  REPLACE('문자열', '기존문자열', '바꿀문자열')
 */
select EMP_NAME, EMAIL, REPLACE(EMAIL, 'google.com', 'naver.com')
from employee;

--=========================================================================
--													<숫자 처리 함수>
--=========================================================================
/*
	* ABS : 숫자의 절대값을 구해주는 함수
		ABS(NUMBER)
*/
select ABS(-19);
select ABS(-13.67);

-------------------------------------------------------------------------------
/*
	* MOD / % : 나머지 값 반환
*/
select MOD(10, 3);
select 10 % 3;		-- postgreSQL에서만 사용

-------------------------------------------------------------------------------
/*
	* ROUND : 반올림한 결과 반환
 
	  [표현법]
	  ROUND(NUMBER, [위치])
*/

select ROUND(1234.56);
select ROUND(12.34);

select ROUND(1234.5678, 2);
select ROUND(1234.56, 4);

select ROUND(1277.56, -2);

-------------------------------------------------------------------------------
/*
	* CEIL : 올림한 결과 반환
	* FLOOR : 내림한 결과 반환
*/
select CEIL(123.234);
select CEIL(-123.234);






