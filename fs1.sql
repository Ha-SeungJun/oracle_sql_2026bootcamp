-- CRUD  : create, record, update, delete (생성, 조회, 갱신, 삭제)를 query(쿼리)를 통해 할 수 있음

-- 테이블 생성 쿼리 : create table TableName (컬럼명1 datatype, 컬럼명2 datatype)
-- 데이터 생성 쿼리 : Insert into TableName (컬렴명1, 2 ,..) values (컬럼명 1 value, 2...) 
--                  컬럼명과 값의 수가 같아야함
-- 데이터 조회 쿼리 : select * or 컬럼명 1, 2, .... from tableName [where(조건)]...
create table chr_exam1(
    name1 char (3 byte), 
    name2 varchar2(3 byte)
);

-- 모든 부분에 값을 넣을 경우 컬럼명 생략 가능
insert into chr_exam1 values ('aa','AA');

-- select name1 nm1, name2 nm2 from chr_exam1;

select replace(name1, ' ', 'b'), replace(name2, ' ', 'B') nm2 from chr_exam1; --varchar2는 가변길이, 즉 공백 없음

insert into chr_exam1 values ('준', 'Jun');

select name1, name2 from chr_exam1;

create table chr_exam2(name1 char(3), name2 varchar2(3));

--insert into chr_exam2 values ('하승준', 'Ha_SeungJun');

-- 수치형데이터 Number : 두개를 합산한 자릿수가 결정

create table num_temp1(
    n1 number,
    n2 number(9),
    n3 number(9,2),
    n4 number(9,1),
    n5 number(10),
    n6 number(10,-2),
    n7 number(6),
    n8 number(3,5)
);

insert into num_temp1(n1,n2,n3,n4,n5,n6) values(1234567.89,1234567.89,1234567.89,1234567.89,1234567.89,1234567.89);

select * from num_temp1;

create table data_temp1(datel date);

insert into data_temp1 (date1) values(sysdate);

select * from data_temp1;

-- 테이블 생성시 컬럼에 대한 속성을 정의할 수 있는데 이를 무결성제약조건이라고함
-- 이 말은 데이터가 insert 시 무결성을 유지하도록 하는데 목적을 두고 특정 무결성 규칙을 적용해서 데이터의 오류를 미연에 방지
--
--1.null 여부 : 데이터가 반드시 존재하애한다면 not null 제약 조건을 컬럼에 선언해서 무결성을 지켜야함
--2. unique : 데이터 중복을 방지하는 제약조건
--3. pk : 위 1,2 번을 합친 제약조건. 기본적으로 모든 테이블은 pk 를 가지도록 설계하는게 좋음

insert into tel_table (name, tel) values('sj',123);

create table unique_test(
    col1 varchar2(10) unique not null,
    col2 varchar2(10) unique,
    col3 varchar2(10) not null,
    col4 varchar2(10) not null);
    
insert into unique_test VALUES ('aaa',' ','cc','dd');
--
--alter table unique_test
--    ADD CONSTRAINTS "unique_test_PK" PRIMARY KEY (col1);

create table unique_test2(
    col1 varchar2(10) primary key,
    col2 varchar2(10) unique,
    col3 varchar2(10) not null,
    col4 varchar2(10) not null);
    
-- 외래키 (FK) : 테이블간의 연관성을 나타내는 키값 

create table check_test(
    gender varchar2(10) not null
    constraint check_gender check(gender in ('male', 'female')));
    
insert into check_test values ('male');

-- default : 제약x 특정 컬럼을 명시적으로 넣지 않는 경우 자동으로 기본값을 생성

alter table check_test modIfy gender default 'male';

alter table check_test add insert_data date default sysdate;

alter table check_test add test varchar2(10) null;

select * from check_test;

insert into check_test (test) values ('aaa');

-- 테이블 복사, 조건 > 종복 x 데이터 까지 모두 복제
--create table "스키마명.테이블명" as select 컬럼 리스트, from 원본테이블명

create table tel_table_copy as select * from tel_table;

create table STAR_WARS(
    EPISODE_ID number not null,
    EPISODE_NAME VARCHAR2(50),
    OPEN_YEAR number
);

create table characters(
    character_id number(5),
    character_name varchar2(30),
    master_id number(5),
    role_id NUMBER, -- integer
    email varchar2(50)
);

update characters set master_id = 1 where character_name = '제다이';
ALTER TABLE characters 
ADD CONSTRAINT characters_pk PRIMARY KEY (character_id);

DROP TABLE casting;

create table casting(
    episode_id number,
    character_id number,
    real_name varchar2(30),

-- 기본 키 설정
    constraint pk_casting primary key (episode_id),

-- 참조 키 설정
    constraint fk_casting_character foreign key (character_id)
        references characters(character_id)
);

insert into star_wars values (4,'새로운 희망(A New Hope)',1977);
insert into star_wars values (5,'제국의 역습(The Empire Strikes Back)',1980 );
insert into star_wars values (6,'제다이의 귀환(Return of the Jedi)',1983);
insert into star_wars values (1,'보이지 않는 위험(The Phantom Menace)',1999 );
insert into star_wars values (2,'클론의 습격(Attack of the Clones) ',2002);
insert into star_wars values (3,'시스의 복수(Revenge of the Sith)', 2005);

insert into characters(CHARACTER_ID,CHARACTER_NAME,EMAIL) values (1, '루크 스카이워커','luke@jedai.com ');
insert into characters(CHARACTER_ID,CHARACTER_NAME,EMAIL) values (2, '한 솔로','solo@alliance.com');
insert into characters(CHARACTER_ID,CHARACTER_NAME,EMAIL) values (3, '레이아 공주   ','leia@alliance.com');
insert into characters(CHARACTER_ID,CHARACTER_NAME,EMAIL) values (4, '오비완 케노비','Obi-Wan@jedai.com ');
insert into characters(CHARACTER_ID,CHARACTER_NAME,EMAIL) values (5, '다쓰 베이더','vader@sith.com');
insert into characters(CHARACTER_ID,CHARACTER_NAME,EMAIL) values (6, '다쓰 베이더(목소리)','Chewbacca@alliance.com');
insert into characters(CHARACTER_ID,CHARACTER_NAME,EMAIL) values (7, 'C-3PO','c3po@alliance.com ');
insert into characters(CHARACTER_ID,CHARACTER_NAME,EMAIL) values (8, 'R2-D2','r2d2@alliance.com ');
INSERT INTO CHARACTERS ( CHARACTER_ID, CHARACTER_NAME, EMAIL)
VALUES ( 9, '츄바카', 'Chewbacca@alliance.com');

INSERT INTO CHARACTERS ( CHARACTER_ID, CHARACTER_NAME, EMAIL)
VALUES ( 10, '랜도 칼리시안', 'Chewbacca@alliance.com');

INSERT INTO CHARACTERS ( CHARACTER_ID, CHARACTER_NAME, EMAIL)
VALUES ( 11, '요다(목소리)', 'yoda@jedai.com');

INSERT INTO CHARACTERS ( CHARACTER_ID, CHARACTER_NAME, EMAIL)
VALUES ( 12, '다스 시디어스', NULL);

INSERT INTO CHARACTERS ( CHARACTER_ID, CHARACTER_NAME, EMAIL)
VALUES ( 13, '아나킨 스카이워커', 'Anakin@jedai.com');

INSERT INTO CHARACTERS ( CHARACTER_ID, CHARACTER_NAME, EMAIL)
VALUES ( 14, '콰이곤 진', NULL);

INSERT INTO CHARACTERS ( CHARACTER_ID, CHARACTER_NAME, EMAIL)
VALUES ( 15, '아미달라 여왕', NULL);

INSERT INTO CHARACTERS ( CHARACTER_ID, CHARACTER_NAME, EMAIL)
VALUES ( 16, '아나킨 어머니', NULL);

INSERT INTO CHARACTERS ( CHARACTER_ID, CHARACTER_NAME, EMAIL)
VALUES ( 17, '자자빙크스(목소리)', 'jaja@jedai.com');

INSERT INTO CHARACTERS ( CHARACTER_ID, CHARACTER_NAME, EMAIL)
VALUES ( 18, '다스 몰', NULL);

INSERT INTO CHARACTERS ( CHARACTER_ID, CHARACTER_NAME, EMAIL)
VALUES ( 19, '장고 펫', NULL);

INSERT INTO CHARACTERS ( CHARACTER_ID, CHARACTER_NAME, EMAIL)
VALUES ( 20, '마스터 윈두', 'windu@jedai.com');

INSERT INTO CHARACTERS ( CHARACTER_ID, CHARACTER_NAME, EMAIL)
VALUES ( 21, '듀크 백작', 'dooku@jedai.com');

COMMIT;

create table roles(
    role_id number(5) unique not null,
    role_name varchar2(50)
);
ALTER TABLE roles 
ADD CONSTRAINT roles_pk PRIMARY KEY (role_id);

insert into roles values (1001, '제다이');
insert into roles values (1002, '시스');
insert into roles values (1003, '반란군');

ALTER table characters
    add constraint characters_fk FOREIGN KEY (role_id)
    references roles(role_id)
    
   UPDATE CHARACTERS
   SET ROLE_ID = 1001
 WHERE CHARACTER_ID IN ( 1, 4, 11, 13, 14, 20, 21);
 
UPDATE CHARACTERS
   SET ROLE_ID = 1002
 WHERE CHARACTER_ID IN ( 5, 6, 12, 18 );
 
UPDATE CHARACTERS
   SET ROLE_ID = 1003
 WHERE CHARACTER_ID IN (2, 3, 7, 8, 9); 
 
COMMIT; 

select * from characters;

update characters set master_id = (select character_id FROM characters where character_name = '오비완 케노비') where character_name = '아나킨 스카이워커'; 
update characters set master_id = (select character_id FROM characters where character_name = '오비완 케노비') where character_name = '루크 스카이워크';
update characters set master_id = (select character_id FROM characters where character_name = '요다') where character_name = '마스터 윈두';
update characters set master_id = (select character_id FROM characters where character_name = '요다') where character_name = '듀크 백작';
update characters set master_id = (select character_id FROM characters where character_name = '다쓰 시디어스') where character_name = '다쓰 베이더';
update characters set master_id = (select character_id FROM characters where character_name = '다쓰 시디어스') where character_name = '다쓰 몰 ';
update characters set master_id = (select character_id FROM characters where character_name = '콰이곤 진') where character_name = '오비완 캐노비';
update characters set master_id = (select character_id FROM characters where character_name = '듀크 백작') where character_name = '콰이곤 진 ';

COMMIT;

select * from CHARACTERS where character_name like '%다스%' or character_name like '%다쓰%';

-- 다중 like
select * from CHARACTERS where REGEXP_LIKE(character_name,'다스|다쓰');


SELECT * from casting;
select * from CHARACTERS;
select * from star_wars;

select cha.character_name, rol.role_name, cha.email 
    from characters cha inner join roles rol
on cha.role_id = rol.role_id;


select cha.character_name, rol.role_name, cha.email from characters cha left outer join roles rol on cha.role_id = rol.role_id;


