select department_id from departments;

select employee_id, department_id from employees where employee_id  = 178;

-- update 테이블명 set 컬럼명 = 값 where [조건]...

update employees set department_id = 280 where employee_id = 178;

--delet from tablename where 조건...

delete from departments where department_id = 10;

-- cehck 제약 조건 : 데이터가 입력되는 시점에 일정한 값을 체크하여 조건에 해당하는 값만 입력될수 있도록 하는 제약
---------------------------------------------------------------------------------------------------------
create table employees_copy as select * from employees;

-- view : 특정 테이블의 결과셋이나 부분셋을 뷰로 생성한 후 특정 사용자에게 오픈하여 사용토록 하는 일조으이 가상 테이블
-- 이렇게 하므로써 원본 테이블의 손상을 막고 필요한 사용자에게 데이터를 오픈할 수 있는 장점이 생긴다

--생성 문법 : creat [or replace] ....

select * from EMP_DETAILS_VIEW;
drop view v_emp1
-- fistname, lastname, email, hire_data 추출
-- 사원 테이블에서 추출, 단 부서가 20번인 경우만 추출
create view v_emp1 as 
    select * from employees where department_id = 10 or department_id = 20 or department_id = 50; --in(10,20,50)

select * from v_emp1;

create sequence MYSEQ MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE ;
-- CURRVAL, NEXTVAL > 시퀀스의 현재값과 다음값을 리턴, 한 번 사용시 쿼리 오류 있어도 무효화 X;

--테스트용 가상테이블인 DUAL 테이블을 이용하여 시퀀스 테스트
SELECT 10 * 20 RESULT FROM DUAL;
SELECT MYSEQ.NEXTVAL CURRVAL FROM DUAL;
SELECT MYSEQ.CURRVAL FROM DUAL;

SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 200;
SELECT * FROM EMPLOYEES;

INSERT INTO EMPLOYEES (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, MANAGER_ID, department_id)
    VALUES (EMPLOYEES_SEQ.NEXTVAL, 'SEUNGJUN','HA', 'QWER1234@QWER.QWER', '01012341234',SYSDATE, 'AD_ASST', 4400, 101, 10);
