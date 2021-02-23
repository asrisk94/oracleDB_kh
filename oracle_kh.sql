show user;

-- kh 계정의 table 확인
-- kh 소유의 table 확인 가능
select *
from tab;

select * from employee;
select * from department;
select * from job;
select * from location;
select * from nation;
select * from sal_grade;

-- 표 table entity relation
-- data를 보관하는 객체
-- data를 생성 create/ 조회  read /  수정 update  /  삭제 delete  CRUD 처리 가능

-- 열 column field attribute
-- data가 보관되는 자료형 크기 지정

--  행 row record tuple
-- vo 객체 하나에 대한 정보를 표현

-- 도메인 domain
-- 하나의 column(attribute)가 가질 수 있는 값의 집합
-- ex) gender  ->  남 / 여    (남, 여 두가지를 도메인이라고 함)

-- 테이블 상세내역
desc employee;
-- 널 여부 : null(기본값. 값을 안줘도 된다는 뜻) or not_null(꼭 값을 넣어줘야하는 것)

-- 자료형 : 문자형, 숫자형, 날짜형, 논리형
/*

data type

1. 문자형
char 고정형 (최대 2000byte)
name char(10) : James   - 5byte 입력해도 10byte 저장(고정이라서).  Gosling(7byte)해도 10byte 저장

varchar2 가변형  (최대 4000byte)
name varchar2(10) : James - 5byte 입력하면 5byte로 저장, GOsling 7byte 저장하면 7byte로 저장.

long 가변형(최대 2gb)
clob 최대 4gb

*/

-- table 생성
create table tb_datatype (
    a char(10),
    b varchar2(10)
);

insert into tb_datatype
values ('James', 'Gosling');

-- insert into tb_datatype
-- values ('JamesJamesJames', 'Gosling'); 
-- ORA-12899: value too large for column "KH"."TB_DATATYPE"."A" (actual: 15, maximum: 10)

-- 한글 한글자당 2byte, 11g xe(공부용)에서는 3byte 할당
insert into tb_datatype
values ('홍길', '세종');

-- insert into tb_datatype
-- values ('홍길동길동', '세종');
-- ORA-12899: value too large for column "KH"."TB_DATATYPE"."A" (actual: 15, maximum: 10)

select a, lengthb(a) 길이, b, lengthb(b) from tb_datatype;

/*
 숫자형

 number[(p, s)]
 p : 전체 자릿수
 s : 소수점이하 자릿수

 1234.567
 number -> 1234.567
 number(7,1) -> 1234.6(반올림)    전체 7자리 표시, 소수 1자리 표시
 number(7)  -> 1235


 오라클은 정수, 실수 구분하지 않는다.

*/

create table tb_datatype_number (
    a number,
    b number(7,1),
    c number(7)
);

insert into tb_datatype_number
values(1234.567, 1234.567, 1234.567);

select * from tb_datatype_number;

select 10 / 3 예시
from dual;  -- dual : 가상테이블 (1행 1열짜리)

/*
3. 날짜형

date : 날짜/  시간 관리
timestamp : 날짜/시간/밀리초 지역대

날짜형은 숫자 연산이 가능하다. (1 : 하루)
sysdate - 1  : 어제 이시각
*/

select sysdate 현재날짜, 
        to_char(sysdate, 'yyyy/mm/dd hh:mi:ss'),   -- 날짜를 문자열로 변환하는 내장함수
        systimestamp,             -- sys : 날짜형에서 현재시각을 가리키는 예약어
        sysdate-1                   -- 어제 이시각
from dual;

select to_char(sysdate-1, 'yyyy/mm/dd hh:mi:ss')
from dual;

select sysdate - (sysdate-1)
from dual;

create table tb_today (
    id varchar2(15),
    password char(20),
    name varchar2(20),
    phone varchar2(11),
    ssn varchar2(13),
    mileage number,
    reg_date date
);
-- 값이 자주 변경되는 패스워드같은 것들은 고정형을 쓰는 것이 좋다.
-- 행단위로 읽어올 때 해당 열의 데이터 크기가 일정해야 좋기 때문

insert into tb_today
values ('arsenal', '0123', '한광희', '01067833090', '1234567890123', 300, '1994/09/10');

select * from tb_today;


desc employee;

select emp_no 주민번호 from employee;

/*
sql

1. DDL : Data Definition Language 데이터 정의어  (데이터베이스 객체에 대해서 create생성, alter수정, drop삭제)
 2. DML : Data Manipulation Language 데이터 조작어 (table 객체에 대해서 insert추가, select조회, update수정, delete삭제)
    -- 하위언어 DQL : select 문                  
3. DCL : Data Control Language 데이터 제어어      (user, role에 대해서 권한부여, 회수. grant, revoke)
    -- 하위언어 TCL : Tracsaction Control Language (transaction에 대해 commit, rollback, savepoint)
*/




/*
DQL1

테이블의 데이터를 검색하기 위한 명령어
명렁어의 조회결과를 ResultSet(결과집합)이라고 함.
select * from employee; 이거의 결과.

resultset은 0개 이상의 행으로 구성된다. (0개일 수도 있다)
특정컬럼, 특정 행을 조회 가능.  정렬도 가능.



select (5) 조회하고자 하는 컬럼 나열 (전체는 *)

from (1) 조회 대상이 될 테이블 작성

where (2) 특정 행을 선택할 기준 조건절 (true = 결과집합 포함, false = 결과집합 미포함)

group by (3) 그루핑 조건

having (4)

order by (6) 정렬기준

() 번호 순으로 작성한다. 암기.

*/

select *
from employee
where dept_code = 'D9';

select *
from employee
where salary >= 3000000;

select *
from employee
where dept_code = 'D9'
order by salary desc;


/*
select

존재하는 컬럼 뿐만 아니라 산술연산처리, literal 또한 가능
*/
select emp_name, salary, salary*12, '원'
from employee;

/*
null
null과 산술연산을 하면 처리결과는 무조건 null이다.

null 처리함수 : nvl(col, null일 때 value)

nvl2(col, value1, value2)
널이 아니면 value1
널이면 value2
*/

select emp_name, salary, bonus, salary + (salary* nvl(bonus, 0))
from employee;

select emp_name, nvl2(bonus, '유', '무') "보너스 유무"
from employee;

select distinct dept_code, job_code
from employee;

select emp_name || '(' || emp_no || ')' as "사원명(사번)"
from employee;

select emp_name, dept_code, salary
from employee
where dept_code = 'D6' and salary > 2000000;

select emp_name, dept_code
from employee
where dept_code != 'D9';

select distinct sal_level
from employee
where job_code != 'J1';

select *
from employee;

select emp_name, phone
from employee
where phone not like '010%';

select emp_name, dept_code, hire_date, email
from employee
where (email like '__#_%' escape '#') and
      (hire_date < '2001/12/31') and
      (dept_code = 'D6' or dept_code = 'D9');
      
select emp_name, dept_code
from employee
where dept_code is not null;

select emp_name, dept_code, salary, hire_date
from employee
order by dept_code asc, salary desc;

select instr('kh정보교육원 국가정보원 정보문화사', '정보'),
        instr('kh정보교육원 국가정보원 정보문화사', '정보', 5),
        instr('kh정보교육원 국가정보원 정보문화사', '정보', 1, 2),
        instr('kh정보교육원 국가정보원 정보문화사', '정보', -1),
        instr('kh정보교육원 국가정보원 정보문화사', '이거')
from dual;

select emp_name, email, instr(email, '@')
from employee;

select substr('showmethemoney', 5, 2),
	substr('showmethemoney', 1, 6),
	substr('showmethemoney', 10)
from dual;

select substr(email, 1, instr(email, '@')-1)
from employee;

select lpad(email, 20, '#')
from employee;


-- 사번, 주민번호(뒤 6자리는 *)

desc employee;

select emp_id, emp_name, rpad(substr(emp_no, 1, instr(emp_no, '-')+1), 14, '*') as num
from employee;

-- 여자사원만 조회
select emp_name, emp_no
from employee
where mod(substr(emp_no, 8, 1), 2) = 0;

select ceil(123.456 * 100) /100, floor(345.678)
from dual;

-- 정식사원이 된 날짜 조회

select emp_name, hire_date, add_months(hire_date, 3)
from employee;

select months_between(sysdate, '2020/10/28')
from dual;

select emp_name, floor(months_between(sysdate, hire_date)) as "근무개월수",
        floor(months_between(sysdate, hire_date)/12) || '년 ' || 
        mod(floor(months_between(sysdate, hire_date)), 12) || '월' as "근속연수"
from employee;

select extract(year from sysdate) as year,
	extract(month from sysdate) as month,
	extract(day from sysdate) as day,
	extract(hour from cast(systimestamp as timestamp))
from dual;

select emp_name, hire_date
from employee
where extract(year from hire_date) = 2010;

select to_char(sysdate, 'yyyy-mm-dd(day) hh24:mi:ss'),
        to_char(sysdate, 'yyyy"년" mm"월" dd"일"'),

from dual;

select to_char(1234567, '999,999,999'),
        to_char(1234567, '000,000,000'),
        
        to_char(1234567, 'L000,000,000'),
        to_char(1234567, 'L999,999,999'),
        
        to_char(1234567, 'FM000,000,000'),
        to_char(1234567, 'FM999,999,999'),
        
        to_char(1234567, 'FML000,000,000'),
        to_char(1234567, 'FML999,999,999')
from dual;


-- 사원명, 급여(원화, 세자리마다 콤마) 조회

select emp_name, to_char(salary, 'L999,999,999')
from employee;


-- to_number(character, format)

select to_number('￦1,234,567', 'L9,999,999') + 123
from dual;  -- 뒤 123으로 숫자연산 되는걸 확인(넘버라는 것이 입증)
-- 기존형식을 알아야 숫자형으로 변환할 수 있기 때문에 투넘버의 포맷은 필수

select '100' + '10'
from dual;  -- sql에서는 산술연산한다. 문자열합산은 ||이기 때문



-- to_date(character[, format])

select to_date('1993-03-03', 'yyyy-mm-dd'),
      to_date('1993-03-03'),
      '1993-03-03'
from dual;

-- 2018년 2월 8일 12시 23분 50초, 3시간 후 동일형식

select '2018년 2월 8일 12시 23분 50초',
to_char(to_date('2018년 2월 8일 12시 23분 50초', 'yyyy"년" mm"월" dd"일" hh24"시" mi"분" ss"초"') + 3/24, 'yyyy"년" mm"월" dd"일" hh24"시" mi"분" ss"초"') result
from dual; -- 포맷에서 한글은 오류 가능성 높음. ""로 감싸주면 좋다.

-- 현재시각으로부터 1일 2시간 3분 4초 뒤를 출력
select to_char(sysdate, 'yyyy-mm-dd(day) hh24:mi:ss'),
        to_char(sysdate + 1 + (2/24) + (3/24/60) + (4/24/60/60),'yyyy-mm-dd(day) hh24:mi:ss') result
from dual;

select emp_name, 
        emp_no,
        decode(substr(emp_no, 8, 1), 1, '남', 2, '여', 3, '남', 4, '여') as "성별"
	decode(substr(emp_no, 8, 1), 1, '남', 3, '남', '여') as "성별"
from employee;

select emp_name,
        case substr(emp_no, 8, 1)
            when '1' then '남'
            when '3' then '남'
            else '여'
        end "성별"
from employee;

select emp_name,
    case
        when substr(emp_no, 8, 1) = '1' then '남'
        when substr(emp_no, 8, 1) = '3' then '남'
        else '여'
    end "성별"
from employee;

select emp_name,
    case
        when substr(emp_no, 8, 1) in ('1', '3') then '남'
        else '여'
    end "성별"
from employee;


select emp_id, emp_name, emp_no,
    extract(year from sysdate) - 
    (case substr(emp_no, 1, 1)
        when '0' then substr(emp_no, 1, 2) + 2000
        else substr(emp_no, 1, 2) + 1900
    end) + 1 as "나이"
from employee;

select emp_no,
	extract(year from to_date(substr(emp_no, 1, 2), 'yy')) yyyy,
	extract(year from to_date(substr(emp_no, 1, 2), 'rr')) rrrr
from employee;

select sum(salary)
from employee
where substr(emp_no, 8, 1) in ('1', '3');

select sum(salary)
from employee;

-- 부서코드가 D5인 사원들의 급여 총합 조호

select sum(salary)
from employee
where dept_code like 'D5';

select sum((salary * nvl(bonus,0)))
from employee
where dept_code like 'D5';

select sum(salary*bonus)
from employee
where dept_code like 'D5' and bonus is not null;

select count(*)
from employee;

select count(*)
from employee
where bonus is not null;

select count(bonus)
from employee;

select count(nvl2(bonus, null, 1))
from employee;

select count(*)
from employee
where bonus is null;

select max(salary), min(salary)
from employee;

select max(hire_date), min(hire_date),
        max(emp_name), min(emp_name)
from employee;

select *
from employee;

-- 1. 부서에 속한 사원 조회

select count(dept_code)
from employee;

-- 2. 인턴사원 조회
select count(*)
from employee
where dept_code is null;

-- 3. 남자사원 수, 여자사원 수 (where 절 없이)

select count(decode(substr(emp_no, 8, 1), '1', '남', '3', '남')) "남자 사원 수",
	count(decode(substr(emp_no, 8, 1), '2', '여', '4', '여')) "여자 사원 수"
from employee;

select count(case
                when substr(emp_no, 8 ,1) in ('1', '3') then 1
            end) "남자 사원 수",
        count(case
                when substr(emp_no, 8 ,1) in ('2', '4') then 1
            end) "여자 사원 수"
from employee;


select dept_code, trunc(avg(salary))
from employee
group by dept_code;


-- J1 직급을 제외하고 직그별 사원수, 평균 급여 조회

select * from employee;

select job_code, count(*) 사원수, trunc(avg(salary)) 평균급여
from employee
where job_code != 'J1'
group by job_code;

-- 입사년도별 사원수 조회

select extract(year from hire_date) 입사년, count(*)
from employee
group by extract(year from hire_date)
order by 입사년;

select decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여') 성별,
        count(*) 사원수
from employee
group by decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여')
order by 성별;

select dept_code, job_code, count(*)
from employee
group by dept_code, job_code
order by 1, 2;

-- 부서별 성별 인원수 조회

select nvl(dept_code, '인턴') 부서,
        decode(substr(emp_no, instr(emp_no, '-')+1, 1), '1', '남', '3', '남', '여') 성별,
        count(*) 사원수
from employee
group by dept_code, decode(substr(emp_no, instr(emp_no, '-')+1, 1), '1', '남', '3', '남', '여')
order by 부서;

-- 부서별 급여평균이 300만원 이상인 부서 조회

select dept_code, trunc(avg(salary)) "급여 평균"
from employee
group by dept_code
having avg(salary) >= 3000000;

-- 부서별 인원수가 3명 이상인 부서 조회 (부서명, 인원수)

select dept_code 부서명, count(*) 인원수
from employee
group by dept_code
having count(*) >= 3
order by 부서명;

-- 관리하는 사원이 2명 이사인 매니저의 사원아이디와 관리하는 사원수 조회

select manager_id, count(*)
from employee
group by manager_id
having manager_id is not null and count(*) >= 2
order by 1;

select dept_code, count(*)
from employee
group by rollup(dept_code)
order by 1;

select dept_code, job_code, count(*)
from employee
group by rollup(dept_code, job_code)
order by 1;

select decode(grouping(dept_code), 0, nvl(dept_code, '인턴'), '총계') 부서,
	decode(grouping(job_code), 0, job_code, '소계') 직급,
	count(*)
from employee
group by cube(dept_code, job_code)
order by 1,2;

select D.dept_title
from employee E join department D
	on E.dept_code = D.dept_id
where E.emp_name like '송종기';

select * from department;

select *
from employee e join department d
	on e.dept_code = d.dept_id;

select * from job;

select *
from employee e join job j
    on e.job_code = j.job_code;

-- location nation 테이블 조인해서 출력

select *
from location;

select *
from nation;

select *
from location l join nation n
    on l.national_code = n.national_code
order by 1;

select *
from location l join nation n
	using(national_code);
    
select *
from employee e inner join department d
	on e.dept_code = d.dept_id
order by 1;

select *
from employee e left outer join department d
	on e.dept_code = d.dept_id
order by 1;

select *
from employee e right outer join department d
	on e.dept_code = d.dept_id
order by 1;

select *
from employee e full outer join department d
	on e.dept_code = d.dept_id
order by 1;

select *
from employee e cross join department d;


select e.emp_name, e.salary, a.avg, e.salary - a.avg as diff
from employee E
	cross join (select trunc(avg(salary)) as avg
		from employee) as A;


select A.emp_name, a.emp_id, a.manager_id, b.emp_name
from employee A inner join employee B
	on A.manager_id = B.emp_id;

select E.*,
        D.dept_title,
        L.local_name,
        N.national_name
from employee E 
	left join department D 
		on E.dept_code = D.dept_id
	left join location L
		on D.location_id = L.local_code
	left join nation N
		using(national_code)
where L.local_name = 'ASIA2'
order by E.emp_id;

select *
from employee E, department D
where E.dept_code = D.dept_id;

select *
from employee E, department D
where E.dept_code = D.dept_id;

select A.emp_id,
        A.emp_name,
        A.manager_id,
        B.emp_name
from employee A, employee B
where A.manager_id = B.emp_id;


select *
from employee E, department D, location L, nation N
where E.dept_code = D.dept_id(+)
	and D.location_id = L.local_code(+)
	and L.national_code = N.national_code(+);



--직급이 대리이면서, ASIA 지역에 근무하는 직원 조회
--사번, 이름 ,직급명, 부서명, 근무지역명, 급여

select * from department;
select * from job;
select national_code, national_name from nation;
select local_code, national_code, local_name from location;
select * from employee;


select E.emp_id 사번, E.emp_name 이름, J.job_name 직급명, 
        D.dept_title 부서명, N.national_name 근무지역명, E.salary 급여
from employee E, department D, location L, nation N, job J
where E.dept_code = D.dept_id(+)
    and D.location_id = L.local_code(+)
    and L.national_code = N.national_code(+)
    and E.job_code = J.job_code(+)
    and J.job_name = '대리'
    and L.local_name like 'ASIA%';

select E.emp_id 사번, E.emp_name 이름, J.job_name 직급명, 
        D.dept_title 부서명, N.national_name 근무지역명, E.salary 급여
from employee E left join department D
                    on E.dept_code = D.dept_id
                left join location L
                    on D.location_id = L.local_code
                left join nation N
                    on L.national_code = N.national_code
                left join job J
                    on E.job_code = J.job_code
where J.job_name = '대리'
        and L.local_name like 'ASIA%';
        
select *
from sal_grade;
--employee.salary between sal_grade.min_sal and sal_grade.max_sal

select emp_name, salary, SG.sal_level, SG.min_sal, SG.max_sal
from employee E
        join sal_grade SG
            on E.salary between SG.min_sal and SG.max_sal;

select emp_id, emp_name, dept_code, salary
from employee
where dept_code = 'D5'
union					-- 중복제거 합집합 하고 있다.
select emp_id, emp_name, dept_code, salary
from employee
where salary >= 3000000
order by 4;

select emp_id, emp_name, dept_code, salary
from employee
where dept_code = 'D5'
union all				-- 그냥 합집합 하고 있다.
select emp_id, emp_name, dept_code, salary
from employee
where salary >= 3000000
order by 4;

select A.emp_name, A.manager_id, B.emp_name
from employee A join employee B
	on A.manager_id = B.emp_id
where A.emp_name = '노옹철';



select emp_name
from employee
where emp_id = (select manager_id
		from employee
		where emp_name = '노옹철');
  
  
        
select emp_name, salary
from employee
where salary > (select avg(salary)
		from employee);



select E.emp_name, E.salary, A.avg
from employee E
	cross join (select trunc(avg(salary)) avg
			from employee) A
where salary > (select avg(salary)
		from employee)
order by salary;



select emp_id, emp_name, salary
from employee
where salary = (select salary
		from employee
		where emp_name = '윤은해');

select emp_id, emp_name
from employee
where job_code = (select job_code
			from job
			where job_name = '대리');
            
select E.emp_id, E.emp_name
from employee E join job J
		using(job_code)
where J.job_name = '대리';


select emp_name, dept_code
from employee
where dept_code in (select dept_code
			from employee
			where emp_name in ('송종기', '하이유'));

-- 차태연, 박나라, 이오리 사원과 같은 직급의 사원조회 (사원명, 직급명)

select E.emp_name, J.job_name
from employee E join job J
                using(job_code)
where job_code in (select job_code
                    from employee
                    where emp_name in ('차태연', '박나라', '이오리'))
order by job_code;

-- 직급이 대표, 부사장이 아닌 사원 조회(사원명, 직급코드)

select emp_name, job_code
from employee E 
        join job J  using(job_code)
where J.job_name not in (select job_name
                            from job
                            where job_name in ('대표', '부사장'));

-- ASIA1 지역에 근무하는 사원 조회 (사번, 사원명)

select emp_id, emp_name, dept_code
from employee
where dept_code in (select dept_id
                        from department
                        where location_id =
                        (select local_code
                            from location
                            where local_name = 'ASIA1'));

select dept_code, emp_name
from employee
where (dept_code, job_code) = (select dept_code, job_code 
                                    from employee 
                                    where quit_yn = 'Y');

-- 직급별 최소급여를 받는 사원 조회(사번, 사원명, 직급코드, 급여)

select emp_name, job_code, salary
from employee
where (job_code, salary) in (select job_code, min(salary)
                                    from employee
                                    group by job_code);

-- 부서별로 최대급여를 받는 사원 조회(사원명, 부서명, 급여)

select E.emp_name, D.dept_title, E.salary
from employee E
        join department D   on E.dept_code = D.dept_id
where (dept_code, salary) in (select dept_code, max(salary)
                                from employee
                                group by dept_code);

-- 부서별로 최대급여, 최소급여 받는 사원 조회(사원명, 부서명, 급여)

select E.emp_name, D.dept_title, E.salary
from employee E
        join department D   on E.dept_code = D.dept_id
where (dept_code, salary) in (select dept_code, max(salary)
                                from employee
                                group by dept_code) 
    or (dept_code, salary) in (select dept_code, min(salary)
                                    from employee
                                    group by dept_code)
order by dept_code, salary asc;

select E.emp_name, E.salary, nvl(D.dept_title, '인턴')
from employee E 
	left join department D	on nvl(E.dept_code, '인턴') = nvl(D.dept_id, '인턴')
where (nvl(E.dept_code, '인턴'), E.salary) in (select nvl(dept_code, '인턴'), max(salary)
                                         	from employee
                                         	group by dept_code)
    or (nvl(E.dept_code, '인턴'), E.salary) in (select nvl(dept_code, '인턴'), min(salary)
                                         	from employee
                                         	group by dept_code)
order by nvl(dept_code, '인턴');

select emp_name, job_code, salary
from employee E
where salary > (select avg(salary)
		from employee
		where job_code = E.job_code);
        
select nvl(E.dept_code, '인턴'), E.emp_name, E.salary
from employee E
where salary > (select avg(salary)
		from employee
		where nvl(dept_code, '인턴') = nvl(E.dept_code, '인턴'))
order by nvl(dept_code, '인턴'), salary;

select *
from employee
where exists (select * 
		from employee
		where dept_code = 'D10');

-- 부서테이블에서 부서원이 존재하는 부서 조회(부서코드, 부서명)

select D.dept_id, D.dept_title
from department D
where exists (select *
                from employee E
                where E.dept_code = D.dept_id);

select emp_id, emp_name, manager_id,
	(select emp_name from employee where emp_id = E.manager_id) manager_name
from employee E;

-- 사원, 부서코드, 급여, 부서별 평균급여 조회
-- join없이. 부서별 평균급여는 scala sub-query 사용

select emp_name, nvl(dept_code, '인턴'), salary,
        (select trunc(avg(salary), 1) 
        from employee 
        where nvl(dept_code, '인턴') = nvl(E.dept_code, '인턴')) "부서별 평균급여"
from employee E
order by dept_code, salary;

select emp_name, salary, 
        (select round(avg(salary))
            from employee) 전체평균급여, 
        (salary - (select round(avg(salary))
            from employee)) 급여차이
from employee;

select E.*,
	decode(substr(emp_no, instr(emp_no, '-')+1, 1), '1', '남', '3', '남', '여') gender
from employee E
where decode(substr(emp_no, instr(emp_no, '-')+1, 1), '1', '남', '3', '남', '여') = '여';


select emp_name, gender
from (select E.*,
	decode(substr(emp_no, instr(emp_no, '-')+1, 1), '1', '남', '3', '남', '여') gender
from employee E)
where gender = '여';

-- 30, 40대 여자사원 조회 (사번, 사원명, 성별, 나이)
-- 나이, 성별 컬럼이 포함된 inline-view 활용

select emp_id, emp_name, gender, age
from (select E.*,
            decode(substr(emp_no, instr(emp_no, '-')+1, 1), '1', '남', '3', '남', '여') gender,
            extract(year from sysdate) - (decode(substr(emp_no, instr(emp_no, '-')+1, 1), 1, 1900, 2, 1900, 2000) + substr(emp_no, 1, 2)) + 1 age
        from employee E)
where gender = '여'
    and age between 30 and 49
order by age;

select rownum, rowid, E.*
from employee E;

select rownum, E.*
from (select rownum old, emp_name, salary
	from employee E
	order by salary desc) E;

-- 직급이 대리인 사원중에서 급여 상위 3명 조회

select emp_name, salary
from (select emp_name, salary
        from employee
        where job_code in (select job_code
                    from job
                    where job_name = '대리')
        order by salary desc)
where rownum <= 3;

-- 부서별 급여평균 top-3 조회 (부서명, 평균급여)

select nvl(E.부서명, '인턴'), E.평균급여
from (select dept_code 부서명, round(avg(salary)) 평균급여
        from employee
        group by dept_code
        order by avg(salary) desc) E
where rownum < 4;


select rnum, E2.부서명, E2.평균급여
from 
	(select rownum rnum, nvl(E.부서명, '인턴') 부서명, E.평균급여 평균급여
	from (select dept_code 부서명, round(avg(salary)) 평균급여
	        from employee
	       	group by dept_code
	        order by avg(salary) desc) E) E2
where rnum between 4 and 6;


select E.*
from
(select emp_name, salary,
	rank() over(order by salary asc) rank,
    dense_rank() over(order by salary desc) dense_rank
from employee) E
where rank between 6 and 10;

-- 입사일이 빠른 10명의 사원 조회

select *
from (select 
        rank() over(order by hire_date asc) hire_rank,
        E.*
        from employee E)
where hire_rank <= 10;

select *
from (select 
	dept_code, emp_name, salary,
	rank() over(partition by dept_code order by salary desc) rank
	from employee)
where rank <= 3;

select *
from (select 
	job_code, emp_name, salary,
	rank() over(partition by job_code order by salary desc) rank
	from employee)
where rank <= 3
order by job_code, rank;

select emp_name, salary,
	(select sum(salary) from employee) sum,
    sum(salary) over() 전체급여합계,
    sum(salary) over(order by salary) 전체급여누계,
    dept_code,
    sum(salary) over(partition by dept_code order by salary) 부서별급여누계
from employee
order by dept_code;

select emp_name, dept_code,
    trunc(avg(salary) over(partition by dept_code)) dept_avg,
	trunc(avg(salary) over()) avg,
    trunc(avg(salary) over(order by salary)) 급여누계평균
from employee;


-----------------------------------------------------------------------
-- DML

-- employee 카피 테이블 생성

create table emp_copy
as
select *
from employee;

select * from emp_copy;

alter table emp_copy
add constraint pk_emp_copy primary key(emp_id)
modify quit_yn default 'N'
modify hire_date default sysdate;

insert into emp_copy
values('301', '함지민', '780808-2123456', 'ham@kh.or.kr', '01012341234', 
	'D1', 'J4', 'S3', 4300000, 0.2, 
    '200', sysdate, null, 'N');

desc emp_copy;

insert into emp_copy
(emp_id, emp_name, emp_no, job_code, sal_level)
values('302', '구술기', '900909-2345678', 'J5', 'S4');

-- 실제 db서버에 적용
commit;

-- emp_copy에 사원 2명 추가

insert into emp_copy
values('303', '이아람', '930827-2345679', 'aram@kh.or.kr', '01012341234', 
        'D2', 'J6', 'S4', 2700000, null,
        '200', sysdate, null, 'N');
insert into emp_copy
(emp_id, emp_name, emp_no, job_code, sal_level)
values('304', '김시정', '960316-1234567', 'J6', 'S4');

commit;

delete from emp_copy;

select * from emp_copy;

rollback;

insert into emp_copy(
    select *
    from employee
);


create table emp_dept_9
as
select * 
from emp_copy
where 1 = 0;

select * from emp_dept_9;

create table emp_dept_2
as
select *
from emp_copy
where 1 = 0;

select * from emp_dept_2;


-- emp_copy  ->  emp_dept_2 | emp_dept_2

insert all
when dept_code = 'D2' then
into emp_dept_2 values(emp_id, emp_name, emp_no, email, phone, dept_code, job_code, sal_level, salary, bonus, manager_id, hire_date, quit_date, quit_yn)
when dept_code = 'D9' then
into emp_dept_9 values(emp_id, emp_name, emp_no, email, phone, dept_code, job_code, sal_level, salary, bonus, manager_id, hire_date, quit_date, quit_yn)
select *
from employee;

commit;

select * from emp_copy;

update emp_copy
set emp_name = '고둘밋', phone = '01033334444'	-- 수정사항
where emp_id = '223';	-- 조건에 맞는 행 찾음

commit;

update emp_copy
set salary = salary + 500000
where dept_code = 'D9';

delete from emp_copy
where emp_id = '223';

select * from emp_copy;

truncate table emp_copy; 

-- emp_copy의 데이터를 employee로부터 채우고,
--  임시환 사원의 직급을 과장, 부서를 해외영업 3부로 변경
--  방명수 사원을 삭제하세요.

select * from emp_copy;

update emp_copy
set job_code = (select job_code from job where job_name = '과장'),
    dept_code = (select dept_code from department where dept_title = '해외영업3부')
where emp_name = '임시환';

delete emp_copy
where emp_name = '방명수';


create table member (
	id varchar2(20) not null,
	password varchar2(25) not null,
	name varchar2(50) default '홍길동',
	reg_date date default sysdate
);

drop table member;

comment on table member is '회원관리 테이블';
select *
from user_tab_comments
where table_name = 'MEMBER';

select *
from user_col_comments
where table_name = 'MEMBER';

comment on column member.id is '회원아이디';
comment on column member.password is '비밀번호';
comment on column member.name is '회원이름';
comment on column member.reg_date is '회원가입일';

select *
from user_constraints
where table_name = 'EMPLOYEE';

select *
from user_cons_columns
where table_name = 'EMPLOYEE';

-- 조인해서 사용

select UC.table_name, UCC.column_name, UC.constraint_name, 
        UC.constraint_type, UC.search_condition
from user_constraints UC
        join user_cons_columns UCC  on UC.constraint_name = UCC.constraint_name
where UC.table_name = 'EMPLOYEE';

-- drop table member;
create table member (
	id varchar2(20) not null,
	password varchar2(20) not null,
	name varchar2(50) not null,
	email varchar2(100) constraint uq_member_email unique,
	phone char(11) not null
);



-- 행 삽입시

insert into member
values('honggd', '1234', null, 'honggd@naver.com', '01012341234');

-- name에 not null이 들어가있기 때문에 null을 줄 수 없어 오류가 난다.



insert into member
values('honggd', '1234', '홍길동', 'honggd@naver.com', '01012341234');

select * from member;

-- drop table member;
create table member (
	id varchar2(20) not null,
	password varchar2(20) not null,
	name varchar2(50) not null,
	email varchar2(100),
	phone char(11) not null,
	constraint pk_member_id primary key(id),
	constraint uq_member_email unique(email)
);

insert into member
values('honggd', '1234', '홍길동', 'honggd@naver.com', '01012341234');

create table shop_member (
	id varchar2(20),
	name varchar2(50) not null,
	constraint ph_shop_member_id primary key(id)
);

insert into shop_member values('honggd', '홍길동');
insert into shop_member values('sinsa', '신사임당');
insert into shop_member values('sejong', '세종');

select * from shop_member;

commit;

create table shop_buy (
	no number,
	member_id varchar2(20),
	product_name varchar2(100),
	constraint pk_shop_buy_no primary key(no),
	constraint fk_shop_buy_member_id foreign key(member_id)
					references shop_member(id)
);

insert into shop_buy 
values(1, 'honggd', '축구화');		-- 참조컬럼에 'honggd'가 있기 때문에 가능.

insert into shop_buy
values(2, 'aaabbbccc', '축구화');	-- aaabbbccc는 참조컬럼에 없는 값이기 때문에 행추가 불가능.

insert into shop_buy
values(2, 'sinsa', '족구화');		-- 아이디가 있어서 행추가 가능

insert into shop_buy
values(3, 'sinsa', '농구화');

insert into shop_buy
values(4, 'sejong', '배구화');

insert into shop_buy
values(5, null, '배구화');

select * from shop_buy;

delete from shop_member
where id = 'honggd';


-- drop table shop_buy;
create table shop_buy (
	no number,
	member_id varchar2(20),
	product_name varchar2(100) not null,
	constraint pk_shop_buy_no primary key(no),
	constraint fk_shop_buy_member_id foreign key(member_id)		-- 외래키 등록
					references shop_member(id)	-- 참조컬럼 지정
					on delete set null
);

select * from shop_buy;
select * from shop_member;

delete from shop_member
where id = 'sinsa';


--drop table member;
create table member (
	id varchar2(20) not null,
	password varchar2(20) not null,
	name varchar2(50) not null,
	email varchar2(100) not null,
	phone char(11) not null,
	gender char(1),
	point number,
	constraint pk_member_id primary key(id),
	constraint uq_member_email unique(email),
	constraint ck_member_gender check(gender in ('M', 'F')),
	constraint ck_member_point check(point between 0 and 100)
);

select *
from user_constraints
where table_name = 'MEMBER';

insert into member
values('honggd', '1234', '홍길동', 'hgd@naver.com', '01012341234', 
	'M', 90);

insert into member
values('sinsa', '1234', '홍길동', 'sinsa@naver.com', '01012341234', 
	'M', 190);
    
select * from member;

-- drop table shop_nickname;
create table shop_nickname (
	member_id varchar2(20),
	nickname varchar2(100),
	constraint pk_shop_nickname_member_id primary key(member_id),
	constraint fk_shop_nickname_member_id foreign key(member_id)
                                references shop_member(id)
                                on delete cascade
);

insert into shop_nickname
values('honggd', '홍드래곤');

select * from shop_nickname;

select * from shop_member;


create table tb_product(
	no number,
	name varchar2(50)	
);

-- alter add

alter table tb_product add price number default 0;

desc tb_product;

alter table tb_product add constraint pk_product_no primary key(no);

select UC.table_name, UCC.column_name, UC.constraint_name, 
        UC.constraint_type, UC.search_condition
from user_constraints UC
        join user_cons_columns UCC  on UC.constraint_name = UCC.constraint_name
where UC.table_name = 'TB_PRODUCT';

alter table tb_product modify name varchar2(1000);

desc tb_product;

alter table tb_product
rename column no to product_no;

alter table tb_product
rename column name to product_name;

alter table tb_product
modify product_name not null;

alter table tb_product 
rename constraint SYS_C007202 to nn_product_name;

alter table tb_product
drop column price;

desc tb_product;

alter table tb_product
drop constraint pk_product_no;

alter table tb_product
drop constraint nn_product_name;

------------------------------------

create table tb_coffee(
	name varchar2(50),
	price number not null,
	brand varchar2(50) not null,
	constraint pk_tb_coffee_name primary key(name)
);

insert into tb_coffee values('맥심', 3000, '동서식품');
insert into tb_coffee values('카누', 4000, '동서식품');
insert into tb_coffee values('네스카페', 3500, '네슬레');

select * from tb_coffee;

commit;

grant select on kh.tb_coffee to qwerty;
grant insert, update, delete on kh.tb_coffee to qwerty;

revoke insert, update, delete on kh.tb_coffee from qwerty;

select * from all_objects;

select distinct object_type from all_objects;

select * from dict order by 1;
select * from user_tables;
select * from user_constraints;
select * from user_indexes;

select * from all_tables;


create view view_emp
as
select emp_id, emp_name, 
	substr(emp_no, 1, 8) || '******' emp_no,
	decode(substr(emp_no, 8, 1), 1, '남', 3, '남', '여') gender
from employee;

select * from view_emp;

select *
from user_views
where view_name = 'VIEW_EMP';

grant select on view_emp to qwerty;

-- 사번 사원명 직급명 부서명 (null은 인턴 처리)
-- view_emp_read 생성한 후에 qwerty에게 조회할 수 있도록 권한부여

create view view_emp_read
as
select E.emp_id 사번,
        E.emp_name 사원명,
        J.job_name 직급명,
        D.dept_title 부서명
from employee E
        join job J  using(job_code)
        join department D   on E.dept_code = D.dept_id;
        
select * from view_emp_read;
grant select on view_emp_read to qwerty;



create table tb_user(
	no number,              -- 회원 고유번호
	user_id varchar2(50),   -- 회원 아이디
    constraint pk_tb_user_no primary key(no)
);

create sequence seq_tb_user_no
start with 1
increment by 1
nominvalue
nomaxvalue
nocycle
cache 20;

insert into tb_user
values(SEQ_TB_USER_NO.nextval, 'honggd');

insert into tb_user
values(SEQ_TB_USER_NO.nextval, 'sinsa');

insert into tb_user
values(SEQ_TB_USER_NO.nextval, 'sejong');

select * from tb_user;

select * from user_sequences;

select  seq_tb_user_no.nextval,
        seq_tb_user_no.currval
from dual;

-- 주문 전표 생성
-- kh=210104-1234

-- drop table tb_order;
create table tb_order (
    order_no varchar2(100),
    user_id varchar2(50) not null,
    product_id varchar2(100) not null,
    cnt number default 1 not null,
    order_date date default sysdate,
    constraint pk_tb_order_no primary key(order_no)
);

--drop sequence seq_tb_order_no;
create sequence seq_tb_order_no
nocache;


insert into tb_order
values(
    'kh-' || to_char(sysdate, 'yymmdd') || '-' || to_char(seq_tb_order_no.nextval, 'fm0000'),
    'honggd',
    '아이폰12',
    2,
    default
);

select * from tb_order;

select * from user_sequences;

select * from user_indexes;

select * 
from employee 
where emp_name = '송종기';

select * from employee where emp_id = '201';

create index idx_employee_emp_name
on employee(emp_name);

select * from user_indexes
where table_name = 'EMPLOYEE';

desc employee;

--------

--------------------------------------------
-- 계층형 쿼리
--------------------------------------------
-- employee 테이블 조직도 조회
-- manager_id ---> emp_id
-- 부모행은 n행 이상일 수 있다.

select lpad(' ', (level-1)*5) || emp_name as 조직도,
        level,
        E.*
from employee E
where quit_yn = 'N'
start with job_code = 'J1'
connect by manager_id = prior emp_id;
