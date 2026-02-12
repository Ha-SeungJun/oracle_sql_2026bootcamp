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

-- start with, connet by, having

select first_name, last_name from employees where employee_id = 207;

-- concat 연산자 || 하나 이상의 컬럼을 합쳐서 표현 / as 공백 사용시 ""
select first_name || last_name full_name from employees where employee_id = 207;

select first_name || last_name 서명, salary 월급, department_id 부서번호 from employees where salary < 10000 and department_id = 30;

select hire_date from employees where hire_date > '1996-01-01';

select first_name || last_name 서명, salary 월급, department_id 부서번호 from employees
where (department_id = 10 and salary < 10000) or  (department_id = 60 and salary > 5000);

-- 컬럼 between value1 and value2 : 값 사이 조회

select employee_id 사번, first_name || last_name 서명, salary 월급, department_id 부서번호 from employees
where not(employee_id BETWEEN 110 and 120);

select * from employees
where department_id in (30,60,90);

-- exists : 서브쿼리만을 이용해서 결과를 조건에 매핑하는 연산자
select employee_id 사번, first_name || last_name 서명, salary 월급, department_id 부서번호 from employees emp where exists
(select department_id from departments dept where department_id in (30,60,90) and emp.department_id = dept.department_id);

-- like 연산자 : 특정 패턴을 준비해서 해당 패턴에 데이터가 존재하는지를  검증해서 결과를 도출하도록 하는 연산자
-- ex > where full_name like '%동' --동으로 끝나는 문자열이 존재하는지 검증, '%동%' > 동이 들어가있는 문자열을 검증 

select * from employees emp 
where phone_number not like '%42%';

select email from employees where email like '%S_I%';

select * from departments;

select * from locations where state_province is null;

select * from jobs;
SELECT * from employees;
SELECT * from departments;
SELECT * FROM locations;

select first_name, last_name, dept.department_id, dept.department_name from employees emp, departments dept, jobs jobs 
where emp.department_id = dept.department_id and emp.job_id = jobs.job_id;

select first_name, last_name, dept.department_id, dept.department_name, location.city from employees emp, departments dept, locations location
where emp.department_id = dept.department_id and dept.location_id = location.location_id and location.state_province = 'California';

select * from employees;

select emp.employee_id, emp.first_name || emp.last_name 사원이름, emp.manager_id, emp2.first_name || emp2.last_name 매니저이름 from employees emp, employees emp2
where emp.manager_id = emp2.employee_id;


select emp.* from employees emp, departments dept, locations location
where emp.department_id = dept.department_id and dept.location_id = location.location_id and location.city != 'Bombay';


select emp.employee_id, first_name || last_name 이름, dept.department_id 부서코드, dept.department_name 부서명, location.city from employees emp, departments dept,locations location
where emp.department_id = dept.department_id(+) and dept.location_id = location.location_id(+) order by emp.employee_id asc;

-- select -- count(*) from -- GROUP BY employee_id HAVING count(*) > 1;

select emp.* from employees emp, job_history jh, count(*) GROUP BY emp.employee_id;

select emp.* from employees emp, job_history jb where emp.employee_id = jb.employee_id(+);

--Ansi Join : 국제표준 조인 방식 
--inner join : 공통되는 컬럼을 기준으로 조인
--문법2가지
Select *
    from employees emp, departments dept 
where emp.department_id = dept.department_id;

Select *
    from employees emp inner join departments dept
on emp.department_id = dept.department_id;

select * from employees emp inner join departments dept using (department_id);

select * from  employees emp, job_history job where emp.employee_id = job.employee_id(+) order by job.employee_id;

select job.employee_id, emp.first_name from employees emp left outer join job_history job on emp.employee_id = job.employee_id order by job.employee_id;

-- function
select concat('a','b') from dual;
select initcap('abcde') from dual;
select lower('AAAA') from dual;
select lpad('abc',7) from dual;
select lpad('abc',7,'#') from dual;

select * from jobs;
SELECT * from employees;
SELECT * from departments;
SELECT * FROM locations;

create table caseex(
    C_ID varchar2(20),
    C_NAME VARCHAR2(20),
    GENDER VARCHAR2(20)
)

insert into caseex values ('b','bbb','f');
insert into caseex values ('c','ccc','f');
insert into caseex values ('d','ddd','m');
insert into caseex values ('e','eee','f');
insert into caseex values ('f','Fff','m');

select * from caseex;

select c_id, c_name, decode(gender, 'm', '남성','f','여성','중성') decode, case gender when 'm' then '남성' when 'f' then '여성' else '중성' end case from caseex;

--nvl(컬럼, 대체값)
SELECT salary, employee_id, first_name, salary * nvl(commission_pct,0) from employees where salary * nvl(commission_pct,0) < 1000;

--nvl2(표현식1, 2, 3) : 표현식이 널이면 표현식 3을 아니면 2를 반환 
select employee_id, first_name, salary, salary + salary * commission_pct total_salary, nvl2(commission_pct, salary+(salary*commission_pct),salary)total_salary2 from employees;

-- 조건함수 decode : decode(표현식, search1, result1, search2, result2...)  ------------ max35, default_result

select sysdate from dual;

select employee_id, first_name || ' '|| last_name 이름, decode(ROUND((sysdate - hire_date) / 365),20,'20 year',ROUND((sysdate - hire_date) / 365)) 근속년도 from employees;

-- case 대상값 when 비교값 then 처리1, when 비교값 then 처리2, ... else default

--distinct 중복제거

select distinct department_id from employees; 

select all department_id from employees;

-- count(*)
select count(*) from employees;

select count(distinct employee_id), count(distinct first_name) from employees;

select count(department_id), count(distinct department_id) from employees;

--
select sum(salary) from employees;

select sum(distinct salary) from employees;

select count(*) from employees;


select salary, count(*), sum(salary) from employees GROUP BY salary HAVING count(*) > 1;

select employee_id , first_name || last_name, salary from employees where salary = max(salary) or salary = min(salary);

select ROUND(sum(salary)/count(salary)) from employees; -- avg
select avg(salary) from employees;

select department_id from employees group by department_id;

select department_id, round(avg(salary),2) 평균급여 ,count(*) 사원수 from employees group by department_id, salary;

select * from employees;

select department_id, job_id, round(avg(salary),2) 평균급여 ,count(*) 사원수 from employees group by department_id, job_id order by department_id, job_id;

--select -- from -- where -- group by -- orderby
select max(salary) from employees;
select department_id ,sum(salary), avg(salary) from employees where department_id = 90 group by department_id;

select decode(department_id,null,'부서없음',department_id) 부서_아이디, count(*) from employees group by department_id order by department_id;
-- where department_id is not null 

select department_id , count(*) from employees where department_id is not null group by department_id having count(*) < 5 order by department_id;

-- sub query 
select first_name || last_name 이름, salary from employees where salary < (select avg(salary) from employees) ; 

select * from locations where state_province is null;

select * from departments dept, locations loc where dept.location_id = loc.location_id and state_province is null;
-- 위 아래 동일한 쿼리
select * from departments where location_id in(select location_id from locations where state_province is null); 

select * from jobs;
select * from employees, jobs where salary = (select max(salary) from employees) and employees.job_id = jobs.job_id ;

select * from locations;
select * from departments;
select * from employees;

select first_name || last_name 이름, salary from employees emp, departments dept where 
    salary > (select avg(salary) from employees) and emp.department_id = dept.department_id 
    and dept.location_id in(select location_id from locations where country_id = 'US');

select salary from employees where department_id = 30;

--any , all
select salary from employees where department_id = 30;
select employee_id, first_name || last_name 이름, salary from employees where salary > any(select salary from employees where department_id = 30); -- 만족 값이 하나 이상
select employee_id, first_name || last_name 이름, salary from employees where salary > all(select salary from employees where department_id = 30); -- 전부 만족

select first_name || last_name 이름, salary from employees 
    where salary > (select avg(salary) from employees) and salary < (select max(salary) from employees)
order by salary;

select * from employees a, (select avg(salary) avgs, max(salary) maxs from employees) b where a.salary between b.avgs and b.maxs order by salary;

--
select * from (select * from employees order by salary desc) where rownum < 11;






