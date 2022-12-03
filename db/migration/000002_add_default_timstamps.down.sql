do $$
declare
    selectrow record;
begin
for selectrow in
    select 
      'ALTER TABLE '|| T.mytable || ' DROP COLUMN   created_at' as created_at_script , 
      'ALTER TABLE '|| T.mytable || ' DROP COLUMN   deleted_at' as deleted_at_script 
      
   from 
      ( 
        select tablename as mytable from  pg_tables where schemaname  ='public' AND tablename NOT IN ('lookup' , 'roles' , 'permissions' , 'program_plan' , 'menu_page' , 'role_permission')  --your schema name here
      ) t
loop
execute selectrow.script;
end loop;
end;
$$;
