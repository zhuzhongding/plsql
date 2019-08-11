PL/SQL Developer Test script 3.0
73
-- Created on 2019/8/8 by ZZD19 
--1.打印个人信息：姓名、薪水、地址
--2.判断表中的数据量，大于20，10-20，或小于20
--使用游标，类似于JAVA中ResultSet存储查询的一个结果集
declare 
  --声明游标
  --cursor c_emp is select ename, sal from emp; 
  --声明带参数的游标
  cursor c_emp(v_deptno emp.deptno%type) is select ename, sal from emp where deptno = v_deptno; 
  v_ename emp.ename%type;
  v_sal emp.sal%type;
  -- Local variables here
  -- String vname ='张三'
  --普通变量
  --v_name varchar2(20) := '张三';
  --v_sal NUMBER;
  --v_addr varchar2(200);
  --引用型变量 
  --v_name emp.ename%type;
  --v_sal emp.sal%type;
  --记录型变量
  --v_emp emp%rowtype;
  --v_count number;
  --v_num number :=1;
  
begin
  --打开游标
  --open c_emp;
  --打开带参游标
  open c_emp(10);
  --循环
  loop
    --获取右边中的值
    fetch c_emp into v_ename,v_sal;
    exit when c_emp%notfound;
    dbms_output.put_line('v_ename:'||v_ename||',v_sal:'||v_sal);
    --exit when c_emp%notfound;
  end loop;
  --关闭游标
  close c_emp;
  
  -- Test statements here
  --直接赋值
  --v_sal := 1000;
  --语句赋值
  --select '传智播客' into v_addr from dual;
  --select ename,sal into v_name,v_sal from emp where empno = '7369';
  --select * into v_emp from emp where empno = '7499';
  --select count(1)  into v_count from emp;
  
  --条件分支
  --if v_count>20 then
  --   dbms_output.put_line('表中数据大于20条：'||v_count);
  --   elsif v_count>=10 then
  --        dbms_output.put_line('表中数据在10-20之间：'||v_count);
  --   else
  --         dbms_output.put_line('表中数据小于10条：'||v_count);
  -- end if;
  
  --循环
  --loop
  --exit when v_num >10;
  --dbms_output.put_line(v_num);
  --v_num := v_num+1;
  --end loop;
  
  
  --打印输出system.out.println()
  --dbms_output.put_line('姓名：'||v_emp.ename||',薪资：'||v_emp.sal);
  --dbms_output.put_line('姓名：'||v_name||',薪资：'||v_sal||',地址：'||v_addr);
  --dbms_output.put_line('hello world');

end;
0
0
