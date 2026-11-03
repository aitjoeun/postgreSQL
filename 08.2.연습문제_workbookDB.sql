-- 1.
create table TB_CLASS_TYPE(
	no VARCHAR(5) primary key,
	NAME VARCHAR(10)
);

insert into TB_CLASS_TYPE VALUES('01','전공필수');
insert into TB_CLASS_TYPE VALUES('02','전공선택');
insert into TB_CLASS_TYPE VALUES('03','교양필수');
insert into TB_CLASS_TYPE VALUES('04','교양선택');
insert into TB_CLASS_TYPE VALUES('05','논문지도');

-- 2.
create table TB_학생일반정보(학번, 학생이름, 주소)
as select STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
	from TB_STUDENT;

-- 3. 
create table TB_국어국문학과(학번, 학생이름, 출생년도, 교수이름)
as select S.STUDENT_NO, S.STUDENT_NAME
				, EXTRACT(year from TO_DATE(SUBSTR(S.STUDENT_SSN, 1, 2),'YY'))
				, P.PROFESSOR_NAME
	from TB_STUDENT S
	left join TB_PROFESSOR P on (P.PROFESSOR_NO = S.COACH_PROFESSOR_NO)
	left join TB_DEPARTMENT D on (D.DEPARTMENT_NO = S.DEPARTMENT_NO)
	where D.DEPARTMENT_NAME = '국어국문학과';

-- 4.
update tb_department
set CAPACITY = ROUND(CAPACITY * 1.1);

-- 5.
update TB_STUDENT
set STUDENT_ADDRESS = '서울시 종로구 숭인동 181-21'
where STUDENT_NO = 'A413042';

-- 6.
update tb_student
set STUDENT_SSN = SUBSTR(STUDENT_SSN, 1, 6);

-- 7.
TB_STUDENT      DEPARTMENT_NO		STUDNET_NO
TB_DEPARTMENT   DEPARTMENT_NO 
TB_CLASS				DEPARTMENT_NO
TB_GRADE												STUDENT_NO

select STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME, point, CLASS_NAME
from tb_student
join TB_DEPARTMENT USING(DEPARTMENT_NO)
join TB_CLASS USING(DEPARTMENT_NO)
join TB_GRADE USING(STUDENT_NO)
where STUDENT_NAME = '김명훈'
  and DEPARTMENT_NAME = '의학과'
  and CLASS_NAME = '피부생리학'
  and TERM_NO = '200501';

update tb_grade
set POINT = 3.5
where STUDENT_NO = (select STUDENT_NO
											from tb_student
										join TB_DEPARTMENT USING(DEPARTMENT_NO)
										where STUDENT_NAME = '김명훈'
										and DEPARTMENT_NAME = '의학과')
	and TERM_NO = '200501'
	and CLASS_NO = (select CLASS_NO
										from TB_CLASS
									 where CLASS_NAME = '피부생리학');

-- 8.
delete from tb_grade
where student_no in (select student_no 
												from tb_student
											where absence_yn = 'Y');

select count(*)
from tb_student
join tb_grade using(student_no)
group by absence_yn
having absence_yn = 'Y';