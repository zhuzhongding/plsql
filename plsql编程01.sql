select * from student;
select * from grade;
/*
1.SQL指定主要分为3类，数据操作语言（DML）、数据定义语言（DDL）、以及数据控制语言（DCL）。
2.查询和更新指定构成了SQL的DML部分，主要包括：INSERT、DELETE、UPDATE、SELECT等。
3.DDL用于创建、修改或删除数据库对象，如：TABLE、VIEW、INDEX、FUNCTION、TRIGGER等。常用操作有：
CREATE、ALTER、DROP、TRUNCATE等。
4.DCL是数据库控制功能，用来授予或回收访问数据库的某种特权，并控制数据库操纵事务发生的时间及
效果，对数据库实行监视，常用操作有GRANT、REVOKE、COMMIT、ROLLBACK等。
5.SQL查询：语法顺序与执行顺序
SQL语句的语法顺序：
SELECT[DISTINCT] FROM WHERE GROUP BY HAVING UNION ORDER BY
SQL语句执行顺序：
FROM WHERE GROUP BY HAVING  SELECT[DISTINCT] UNION ORDER BY
*/
--表的连接
--内连（交集）
select * from student inner join grade on student.id = grade.id; 
select * from student,grade where student.id =grade.id;
--左外联（左边表的全部记录）
select * from student left join grade on student.id = grade.id;
select * from student,grade where student.id = grade.id(+);
--右外联（右边表的全部记录）
select * from student right join grade on student.id = grade.id;
--全外联（并集）
select * from student,grade;

--分页查询
--startNo=(P_NO-1)*pageSize+1 endNo=P_NO*pageSize
--rownum不能使用大于匹配
select * from (select STUDENT.*,ROWNUM RN from student where rownum <=4) A WHERE RN>=1
select * from (select STUDENT.*,ROWNUM RN from student where rownum >1) A WHERE RN<=4 --查不出数据
select * from (select STUDENT.*,ROWNUM RN from student) A where RN >2

----优化注意事项1

--查找所有的性别项，去掉重复值=
--使用distinct
SELECT DISTINCT sex from STUDENT;
--使用group by代替distinct
SELECT SEX FROM STUDENT GROUP BY SEX;
--distinct会便利所有的数据，效率低；可以用group by代替

--查询所有语文成绩及格的学生的姓名
select name from student where id in(select id from grade where language >60);
--exists性能稍好
select name from student where exists (select id from grade where language >60 and grade.id =student.id);
--使用外连接代替exists和in，性能最好
select name from student,grade where student.id=grade.id(+) and language >60;

--使用nulls last/first 解决null值排序的问题
select * from grade order by grade.language desc nulls last;
select * from grade order by grade.language asc nulls first;
select * from grade order by nvl(grade.language,0) desc;
select nvl(grade.language,0) from grade order by nvl(grade.language,0) desc;

--distinct可以指定单个字段不重复、几个字段组合结果不重复
select distinct sex from student;
select distinct sex,name from student;
select distinct(sex),name from student;
select name,distinct sex from student; --报错，distinct只能放在首位，对所有字段生效

--优化注意事项2
/*
多表关联时，把单个表的结果集尽量最小化；
尽量统一SQL书写格式，可减少分析sql的时间，而且可以减少共享内存重复的信息；
select子句中尽量避免使用*；
where条件的顺序：ORACLE采用 自下而上 的顺序解析where子句，那些可以过滤掉最大数据记录的条件必须写在where子句的末尾；
采用函数处理的字段不能利用索引；
*防SQL注入攻击：不要用拼接字符串的方式形成SQL，用？和set值；
*/

--习惯：执行计划

/*
两个用户在操作同一张表时，只有当一个用户提交之后，这个锁才会释放；对同一张表的操作语句最好放在同一个dao里面，否则由于不同dao里面的不同的执行顺序，
可能会造成死锁
语句1.
update A set A.num=A.num+1 where id =1;
update B set B.num=B.num+1 where id =1;
commit;
语句2.
update B set B.num=B.num+1 where id =1;
update A set A.num=A.num+1 where id =1;
commit;
两个用户在同时执行语句1和语句2时，会造成死锁的现象
select * from A for update 可以锁住整张表，此时该表不能增、删、改
*/
--查找加锁的对象
select STUDENT.OBJECT_ID,
       GRADE.OBJECT_NAME,
       STUDENT.LOCKED_MODE,
       STUDENT.SESSION_ID,
       STUDENT.OS_USER_NAME,
       STUDENT.PROCESS
  FROM V$LOCKED_OBJECT STUDENT, ALL_OBJECTS GRADE
 WHERE STUDENT.OBJECT_ID = GRADE.OBJECT_ID
 ORDER BY GRADE.OBJECT_NAME;
--解锁：commit或rollback加锁所在的事务；

--索引
/*
在RANDOM_STRING字段上创建一般索引
create index IDX_D_RANDOMSTRING on D(random_string);
索引最好建在经常作为查询条件的重复率不高的字段上面
*/

--事务
/*
一个数据事务的一般过程：
1.以第一个DML语句的执行作为开始
2.一般事务的正常结束操作：
commit,rollback
3.其他出发事务结束的操作有：
DDL或DCL语句（自动提交）
用于会话正常结束（自动提交）
异常异常终止（自动回滚）
系统崩溃（自动回滚）
*/
--事务自治：AUTONOMOUS TRANSACTION(简称：AT)

--SEQUENCES的使用
create sequence seq_grade minvalue 1001
start by 1001
increment by 1
cache 10  
select seq_grade.nextval from dual;
select seq_grade.currval from dual;

--CASE WHEN
SELECT V.TYPE, COUNT(1) AS AMOUNT
  FROM (SELECT ID,
               (CASE
                 WHEN D.TYPE >= 'A' AND D.TYPE < 'F' THEN
                  1
                 WHEN D.TYPE < 'K' THEN
                  2
                 WHEN D.TYPE <= 'Z' THEN
                  3
                 ELSE
                  4
               END) AS TYPE
          FROM D) V
 GROUP BY V.TYPE
--DECODE
SELECT DECODE(D.TYPE,'A',1,0) AS T1 FROM D;

--空值替换测试
select grade.language,
nvl(grade.language,0) as A,
decode(grade.language,null,0,grade.language) as B,
(case when grade.language is null then 0 else grade.language end) as C
from grade;
