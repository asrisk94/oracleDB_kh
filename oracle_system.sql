column username format a20;         -- 유저네임 컬럼의 너비 20 지정
column account_status format a20;   -- 마찬가지로 컬럼너비 20
select username, account_status from dba_users;  -- 디비에이 유저로부터 유저네임과 어카운트 스테이터스 선택해서 가져옴 (출력)

-- 일반사용자 계정 생성
-- username kh
-- password kh
-- default tablespace 실제 데이터가 저장될 공간 system / users

create user kh
identified by kh
default tablespace users;

-- 사용자 조회
select username, account_status
from dba_users;
-- kh가 오픈되었으나, 접속권한은 없어서 접속 안됨

-- 권한부여 : create session 권한 부여
grant create session to kh;     -- 데이터베이스 접근 권한
-- 좌상단 플러스버튼 누르고 kh 접속 테스트해보면 성공 나온다.

-- connect : 접속 관련 권한 묶음 (create session)
-- resource : create table 객체 생성 권한 묶음
grant connect, resource to kh;

-- chun 계정

create user chun
identified by chun
default tablespace users;

-- 권한부여
grant connect, resource to chun;

-------------------------------
-- grant
-------------------------------

-- qwerty 계정 생성

create user qwerty
identified by qwerty
default tablespace users;

grant create session to qwerty;

grant create table to qwerty;

alter user qwerty quota unlimited on users;

select *
from dba_sys_privs
where grantee in ('CONNECT', 'RESOURCE')
order by 1;

grant create view to kh;

grant create view to chun;