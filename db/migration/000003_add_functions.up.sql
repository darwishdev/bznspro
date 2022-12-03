
CREATE OR REPLACE FUNCTION role_insert(title CHARACTER varying(50) , permissions INT[] ) RETURNS VOID
    LANGUAGE plpgsql
    AS $$
	DECLARE x int;
    r_id integer;
BEGIN    
    INSERT INTO roles (title) VALUES ($1) RETURNING role_id INTO r_id;
	FOREACH x IN ARRAY $2
	LOOP
	INSERT INTO role_permission (role_id , permission_id) VALUES (r_id , x);
	END LOOP;


    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
END;
$$;
