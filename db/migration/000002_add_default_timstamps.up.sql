do $$
declare
    selectrow record;
begin
for selectrow in
    select 
      'ALTER TABLE '|| T.mytable || ' ADD COLUMN   created_at timestamptz NOT NULL DEFAULT (now())' as created_at_script , 
      'ALTER TABLE '|| T.mytable || ' ADD COLUMN   deleted_at timestamptz NULL' as deleted_at_script 
      
   from 
      ( 
        select tablename as mytable from  pg_tables where schemaname  ='public' AND tablename NOT IN ('lookup' , 'roles' , 'permissions' , 'program_plan' , 'menu_page' , 'role_permission')  --your schema name here
      ) t
loop
execute selectrow.created_at_script;
execute selectrow.deleted_at_script;
end loop;
end;
$$;
