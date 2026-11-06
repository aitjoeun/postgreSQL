/*
	<TRIGGER>
	특정 테이블에 INSERT, UPDATE, DELETE등의 DML문에 의해 이벤트(변경사항) 발생시 자동으로 실행되는 객체
	자동으로 매번 실행할 내용을 미리 정의해 둘 수 있는 객체
	
	EX)
	회원 탈퇴시 탈퇴 회원 테이블에 자동으로 데이터 보관
	상품 입고시 재고수량 자동 증가
	상품 출고시 재고수량 자동 감소
	신고 횟수가 일정 기준을 넘으면 블랙리스트에 등로
	
	* 트리거 종류
		- 실행 시기에 따른 분류
		  > BEFORE TRIGGER : 명시한 테이블에 이벤트가 발생되기 전에 트리거 실행
		  > AFTER TRIGGER : 명시한 테이블에 이벤트가 발생한 후에 트리거 실행
		  > INSTEAD OF TRIGGER : 원래 작업 대신 트리거 실행(주로 VIEW)
		  
		- 실행 단위에 따른 분류
			> STATEMENT TRIGGER(문장 트리거) : 이벤트가 발생한 SQL문에 하나당 한번 실행
			> ROW TRIGGER(행 트리거) : 영향을 받는 각 행마다 한번 실행
															 (FOR EACH ROW 옵션 기술해야됨)
				 * old와 new											 
					 이벤트				old								new
					---------------------------------------
					insert	사용불가				새로 삽입되는 데이터
					update	변경전 데이터		변경후 데이터
					delete	삭제되는 데이터		사용불가	  
		  
	* 트리거 생성 방식
		1. 트리거 실행 함수 생성
			CREATE [OR REPLACE] FUNCTION 함수명()
			RETURN TRIGGER AS $$
			BEGIN
				실행내용
				RETURN NEW;
			[EXCEPTION]
			END;
			$$ LANGUAGE plpgsql;
			
		2. 트리거 생성
			CREATE [OR REPLACE] TRIGGER 트리거명
			BEFORE|AFTER  INSERT|UPDATE|DELETE ON 테이블명
			[FOR EACH ROW]
			EXECUTE FUNCTION 함수명();		  
		  
	* 트리거 삭제
	  DROP TRIGGER 트리거명 ON 테이블명;		  
*/	  
		  
		  
		  
		  
		  
		  
