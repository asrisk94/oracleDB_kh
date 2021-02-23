create user kh
identified by kh
default tablespace users;

grant create session to kh;
grant connect, resource to kh;

-------------------------------------------
create user chun
identified by chun
default tablespace users;

grant create session to chun;
grant connect, resource to chun;