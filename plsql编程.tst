PL/SQL Developer Test script 3.0
73
-- Created on 2019/8/8 by ZZD19 
--1.��ӡ������Ϣ��������нˮ����ַ
--2.�жϱ��е�������������20��10-20����С��20
--ʹ���α꣬������JAVA��ResultSet�洢��ѯ��һ�������
declare 
  --�����α�
  --cursor c_emp is select ename, sal from emp; 
  --�������������α�
  cursor c_emp(v_deptno emp.deptno%type) is select ename, sal from emp where deptno = v_deptno; 
  v_ename emp.ename%type;
  v_sal emp.sal%type;
  -- Local variables here
  -- String vname ='����'
  --��ͨ����
  --v_name varchar2(20) := '����';
  --v_sal NUMBER;
  --v_addr varchar2(200);
  --�����ͱ��� 
  --v_name emp.ename%type;
  --v_sal emp.sal%type;
  --��¼�ͱ���
  --v_emp emp%rowtype;
  --v_count number;
  --v_num number :=1;
  
begin
  --���α�
  --open c_emp;
  --�򿪴����α�
  open c_emp(10);
  --ѭ��
  loop
    --��ȡ�ұ��е�ֵ
    fetch c_emp into v_ename,v_sal;
    exit when c_emp%notfound;
    dbms_output.put_line('v_ename:'||v_ename||',v_sal:'||v_sal);
    --exit when c_emp%notfound;
  end loop;
  --�ر��α�
  close c_emp;
  
  -- Test statements here
  --ֱ�Ӹ�ֵ
  --v_sal := 1000;
  --��丳ֵ
  --select '���ǲ���' into v_addr from dual;
  --select ename,sal into v_name,v_sal from emp where empno = '7369';
  --select * into v_emp from emp where empno = '7499';
  --select count(1)  into v_count from emp;
  
  --������֧
  --if v_count>20 then
  --   dbms_output.put_line('�������ݴ���20����'||v_count);
  --   elsif v_count>=10 then
  --        dbms_output.put_line('����������10-20֮�䣺'||v_count);
  --   else
  --         dbms_output.put_line('��������С��10����'||v_count);
  -- end if;
  
  --ѭ��
  --loop
  --exit when v_num >10;
  --dbms_output.put_line(v_num);
  --v_num := v_num+1;
  --end loop;
  
  
  --��ӡ���system.out.println()
  --dbms_output.put_line('������'||v_emp.ename||',н�ʣ�'||v_emp.sal);
  --dbms_output.put_line('������'||v_name||',н�ʣ�'||v_sal||',��ַ��'||v_addr);
  --dbms_output.put_line('hello world');

end;
0
0
