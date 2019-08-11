create or replace procedure testProcedure(v_empno in emp.empno%type,v_sal out emp.sal%type) is
begin
  select sal into v_sal from emp where empno = v_empno;
  
end testProcedure;
/
