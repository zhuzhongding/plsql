select * from student;
select * from grade;
/*
1.SQLָ����Ҫ��Ϊ3�࣬���ݲ������ԣ�DML�������ݶ������ԣ�DDL�����Լ����ݿ������ԣ�DCL����
2.��ѯ�͸���ָ��������SQL��DML���֣���Ҫ������INSERT��DELETE��UPDATE��SELECT�ȡ�
3.DDL���ڴ������޸Ļ�ɾ�����ݿ�����磺TABLE��VIEW��INDEX��FUNCTION��TRIGGER�ȡ����ò����У�
CREATE��ALTER��DROP��TRUNCATE�ȡ�
4.DCL�����ݿ���ƹ��ܣ������������շ������ݿ��ĳ����Ȩ�����������ݿ������������ʱ�估
Ч���������ݿ�ʵ�м��ӣ����ò�����GRANT��REVOKE��COMMIT��ROLLBACK�ȡ�
5.SQL��ѯ���﷨˳����ִ��˳��
SQL�����﷨˳��
SELECT[DISTINCT] FROM WHERE GROUP BY HAVING UNION ORDER BY
SQL���ִ��˳��
FROM WHERE GROUP BY HAVING  SELECT[DISTINCT] UNION ORDER BY
*/
--�������
--������������
select * from student inner join grade on student.id = grade.id; 
select * from student,grade where student.id =grade.id;
--����������߱��ȫ����¼��
select * from student left join grade on student.id = grade.id;
select * from student,grade where student.id = grade.id(+);
--���������ұ߱��ȫ����¼��
select * from student right join grade on student.id = grade.id;
--ȫ������������
select * from student,grade;

--��ҳ��ѯ
--startNo=(P_NO-1)*pageSize+1 endNo=P_NO*pageSize
--rownum����ʹ�ô���ƥ��
select * from (select STUDENT.*,ROWNUM RN from student where rownum <=4) A WHERE RN>=1
select * from (select STUDENT.*,ROWNUM RN from student where rownum >1) A WHERE RN<=4 --�鲻������
select * from (select STUDENT.*,ROWNUM RN from student) A where RN >2

----�Ż�ע������1

--�������е��Ա��ȥ���ظ�ֵ=
--ʹ��distinct
SELECT DISTINCT sex from STUDENT;
--ʹ��group by����distinct
SELECT SEX FROM STUDENT GROUP BY SEX;
--distinct��������е����ݣ�Ч�ʵͣ�������group by����

--��ѯ�������ĳɼ������ѧ��������
select name from student where id in(select id from grade where language >60);
--exists�����Ժ�
select name from student where exists (select id from grade where language >60 and grade.id =student.id);
--ʹ�������Ӵ���exists��in���������
select name from student,grade where student.id=grade.id(+) and language >60;

--ʹ��nulls last/first ���nullֵ���������
select * from grade order by grade.language desc nulls last;
select * from grade order by grade.language asc nulls first;
select * from grade order by nvl(grade.language,0) desc;
select nvl(grade.language,0) from grade order by nvl(grade.language,0) desc;

--distinct����ָ�������ֶβ��ظ��������ֶ���Ͻ�����ظ�
select distinct sex from student;
select distinct sex,name from student;
select distinct(sex),name from student;
select name,distinct sex from student; --����distinctֻ�ܷ�����λ���������ֶ���Ч

--�Ż�ע������2
/*
������ʱ���ѵ�����Ľ����������С����
����ͳһSQL��д��ʽ���ɼ��ٷ���sql��ʱ�䣬���ҿ��Լ��ٹ����ڴ��ظ�����Ϣ��
select�Ӿ��о�������ʹ��*��
where������˳��ORACLE���� ���¶��� ��˳�����where�Ӿ䣬��Щ���Թ��˵�������ݼ�¼����������д��where�Ӿ��ĩβ��
���ú���������ֶβ�������������
*��SQLע�빥������Ҫ��ƴ���ַ����ķ�ʽ�γ�SQL���ã���setֵ��
*/

--ϰ�ߣ�ִ�мƻ�

/*
�����û��ڲ���ͬһ�ű�ʱ��ֻ�е�һ���û��ύ֮��������Ż��ͷţ���ͬһ�ű�Ĳ��������÷���ͬһ��dao���棬�������ڲ�ͬdao����Ĳ�ͬ��ִ��˳��
���ܻ��������
���1.
update A set A.num=A.num+1 where id =1;
update B set B.num=B.num+1 where id =1;
commit;
���2.
update B set B.num=B.num+1 where id =1;
update A set A.num=A.num+1 where id =1;
commit;
�����û���ͬʱִ�����1�����2ʱ�����������������
select * from A for update ������ס���ű���ʱ�ñ�������ɾ����
*/
--���Ҽ����Ķ���
select STUDENT.OBJECT_ID,
       GRADE.OBJECT_NAME,
       STUDENT.LOCKED_MODE,
       STUDENT.SESSION_ID,
       STUDENT.OS_USER_NAME,
       STUDENT.PROCESS
  FROM V$LOCKED_OBJECT STUDENT, ALL_OBJECTS GRADE
 WHERE STUDENT.OBJECT_ID = GRADE.OBJECT_ID
 ORDER BY GRADE.OBJECT_NAME;
--������commit��rollback�������ڵ�����

--����
/*
��RANDOM_STRING�ֶ��ϴ���һ������
create index IDX_D_RANDOMSTRING on D(random_string);
������ý��ھ�����Ϊ��ѯ�������ظ��ʲ��ߵ��ֶ�����
*/

--����
/*
һ�����������һ����̣�
1.�Ե�һ��DML����ִ����Ϊ��ʼ
2.һ���������������������
commit,rollback
3.����������������Ĳ����У�
DDL��DCL��䣨�Զ��ύ��
���ڻỰ�����������Զ��ύ��
�쳣�쳣��ֹ���Զ��ع���
ϵͳ�������Զ��ع���
*/
--�������Σ�AUTONOMOUS TRANSACTION(��ƣ�AT)

--SEQUENCES��ʹ��
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

--��ֵ�滻����
select grade.language,
nvl(grade.language,0) as A,
decode(grade.language,null,0,grade.language) as B,
(case when grade.language is null then 0 else grade.language end) as C
from grade;
