
--1
CREATE TABLE "lookup" (
    "lookup_key" character varying(50) PRIMARY KEY,
    "group" character varying(50) NOT NULL DEFAULT 'default',
    "value" character varying(50) NOT NULL
);

--2
CREATE TABLE "roles" (
    "role_id" bigserial PRIMARY KEY,
    "title" character varying(50) NOT NULL

);


--3
CREATE TABLE "permissions" (
    "permission_id" bigserial PRIMARY KEY,
    "title" character varying(50) NOT NULL

);



--2
CREATE TABLE "tags" (
    "tag_id" bigserial PRIMARY KEY,
    "title" character varying(50) NOT NULL

);

--3
CREATE TABLE "cities" (
    "city_id" bigserial PRIMARY KEY,
    "name" character varying(50) NOT NULL
);

--4
CREATE TABLE "cats" (
    "cat_id" bigserial PRIMARY KEY,
    "lookup_key" character varying(50) NOT NULL, --relation with lookup table
    "name" character varying(50) NOT NULL
);

--5
CREATE TABLE "menus" (
    "menu_id" bigserial PRIMARY KEY,
    "title" character varying(10) NOT NULL
);



--5
CREATE TABLE "pages" (
    "page_id" bigserial PRIMARY KEY,
    "title" character ,
    "breif" TEXT,
    "link" character varying(50) NOT NULL,
    "menu_name" character varying(50) NOT NULL
);

--5
CREATE TABLE "static_content" (
    "static_content_id" bigserial PRIMARY KEY,
    "title" character varying(50) NOT NULL,
    "content" TEXT,
    "img"  character varying(200),
    "url"  character varying(200),
    "icon"  character varying(200),
    "lookup_key" character varying(50) NOT NULL --relation with lookup table

);

--6
CREATE TABLE "testemonials" (
    "testemonial_id" bigserial PRIMARY KEY,
    "name" character varying(50) NOT NULL,
    "img" character varying(200) NOT NULL,
    "content" character varying(200) NOT NULL
);
--7
CREATE TABLE "consultunts" (
    "consultunt_id" bigserial PRIMARY KEY,
    "name" character varying(50) NOT NULL,
    "img" character varying(200) NOT NULL,
    "title" character varying(50) NOT NULL
);

--8
CREATE TABLE "users" (
    "user_id" bigserial PRIMARY KEY,
    "name" character varying(50) NOT NULL,
    "emial" character varying(50) NOT NULL,
    "phone" character varying(50) NOT NULL,
    "job" character varying(50),
    "company" character varying(50),
    "device_uuid" character varying(50)
    
);


--8
CREATE TABLE "admins" (
    "admin_id" bigserial PRIMARY KEY,
    "role_id" bigserial NOT NULL,
    "username" character varying(50) NOT NULL, -- UNIQUE
    "password" character varying(200) NOT NULL
);

--10
CREATE TABLE "services" (
    "service_id" bigserial PRIMARY KEY,
    "cat_id" bigserial NOT NULL,
    "title" character varying(100) NOT NULL,
    "img" character varying(200) NOT NULL,
    "breif" text NOT NULL
);




--13
CREATE TABLE "articles" (
    "article_id" bigserial PRIMARY KEY,
    "cat_id" bigserial NOT NULL,
    "title" character varying(100) NOT NULL,
    "img" character varying(200) NOT NULL,
    "breif" text NOT NULL
);




--14
CREATE TABLE "programs" (
    "program_id" bigserial PRIMARY KEY,
    "cat_id" bigserial NOT NULL,
    "consultunt_id" bigserial NOT NULL,
    "title" character varying(100) NOT NULL,
    "img" character varying(200) NOT NULL,
    "breif" text NOT NULL,
    "content" text NOT NULL,
    "goals" text NOT NULL,
    "location" text NOT NULL,
    "location_note" text,
    "whta_to_learn" text NOT NULL,
    "hours" int NOT NULL,
    "date" date NOT NULL
);



--15
CREATE TABLE "projects" (
    "project_id" bigserial PRIMARY KEY,
    "cat_id" bigserial NOT NULL,
    "title" character varying(100) NOT NULL,
    "img" character varying(200) NOT NULL,
    "date" date
);





--17
CREATE TABLE "program_plan" (
    "program_plan_id" bigserial PRIMARY KEY,
    "program_id" bigserial NOT NULL,
    "text"  character varying(100) NOT NULL,
    "breif"  character varying(100) NOT NULL
);




--18
CREATE TABLE "menu_page" (
    "menu_page_id" bigserial PRIMARY KEY,
    "menu_id" bigserial NOT NULL,
    "page_id" bigserial NOT NULL
);



--19
CREATE TABLE "role_permission" (
    "role_permission_id" bigserial PRIMARY KEY,
    "role_id" bigserial NOT NULL,
    "permission_id" bigserial NOT NULL
);




--21
CREATE TABLE "article_tag" (
    "article_tag_id" bigserial PRIMARY KEY,
    "article_id" bigserial NOT NULL,
    "tag_id" bigserial NOT NULL
);



--tables

ALTER TABLE "cats" ADD FOREIGN KEY ("lookup_key") REFERENCES "lookup" ("lookup_key");
ALTER TABLE "static_content" ADD FOREIGN KEY ("lookup_key") REFERENCES "lookup" ("lookup_key");
ALTER TABLE "admins" ADD FOREIGN KEY ("role_id") REFERENCES "roles" ("role_id");
ALTER TABLE "services" ADD FOREIGN KEY ("cat_id") REFERENCES "cats" ("cat_id");
ALTER TABLE "programs" ADD FOREIGN KEY ("cat_id") REFERENCES "cats" ("cat_id");
ALTER TABLE "projects" ADD FOREIGN KEY ("cat_id") REFERENCES "cats" ("cat_id");
ALTER TABLE "programs" ADD FOREIGN KEY ("consultunt_id") REFERENCES "consultunts" ("consultunt_id");


-- pivot tables

ALTER TABLE "program_plan" ADD FOREIGN KEY ("program_id") REFERENCES "programs" ("program_id");


ALTER TABLE "menu_page" ADD FOREIGN KEY ("menu_id") REFERENCES "menus" ("menu_id");
ALTER TABLE "menu_page" ADD FOREIGN KEY ("page_id") REFERENCES "pages" ("page_id");


ALTER TABLE "role_permission" ADD FOREIGN KEY ("role_id") REFERENCES "roles" ("role_id");
ALTER TABLE "role_permission" ADD FOREIGN KEY ("permission_id") REFERENCES "permissions" ("permission_id");



ALTER TABLE "article_tag" ADD FOREIGN KEY ("article_id") REFERENCES "articles" ("article_id");
ALTER TABLE "article_tag" ADD FOREIGN KEY ("tag_id") REFERENCES "tags" ("tag_id");


-- unique

ALTER TABLE "admins" ADD CONSTRAINT admins_username_uniq UNIQUE (username);