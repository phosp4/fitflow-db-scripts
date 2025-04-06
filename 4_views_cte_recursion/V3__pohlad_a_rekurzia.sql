------------------------------ create new database version
-- USE master;
-- ALTER DATABASE dobrik2 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
-- ALTER DATABASE dobrik2 MODIFY NAME = dobrik3;
-- ALTER DATABASE dobrik3 SET MULTI_USER;
-- USE dobrik3

-- add this for demo purposes
update users set created_at = '2019-01-01', updated_at = '2019-01-01' where id = 5;
alter table users add referrer_id INT;
update users set referrer_id = 3 where id>8;
update users set referrer_id = 1 where id = 3;

------------------------------ VIEWS

-- create a view
if object_id('users_safe_view','V') is not null drop view users_safe_view;
go

create view users_safe_view as
select u.id, r.title "role", u.email, u.first_name, u.last_name, u.credit_balance, u.active, u.created_at, u.updated_at, u.referrer_id from users u
    join roles r on r.id = u.role_id
go

-- check if it works
select * from users_safe_view;

-- make some changes
update users_safe_view set active = 0 where updated_at < '2020-01-01'
go

alter view users_safe_view as
select u.id, r.title "role", u.email, u.first_name, u.last_name, u.active, u.created_at, u.updated_at, u.referrer_id from users u -- no credit balance
    join roles r on r.id = u.role_id
go

-- check how it changed
select * from users;
select * from users_safe_view;

-- with this we can check the current definition
EXEC sp_helptext 'users_safe_view';

-- delete it if you want
-- drop view users_safe_view;

------------------------------ CTEs with recursion

-- no hierarchy column (simpler to understand)
with referrer_hierarchy as (
    select id, last_name, referrer_id, 0 as "level" from users where referrer_id is NULL
    union all
    select u.id, u.last_name, u.referrer_id, level + 1 from users u
    join referrer_hierarchy rh on u.referrer_id = rh.id
)
select * from referrer_hierarchy;

-- with hier column
with referrer_hierarchy_2 as (
    select id, last_name, referrer_id, 0 as "level", CAST(last_name AS VARCHAR(MAX)) as "hier" from users where referrer_id is NULL
    union all
    select u.id, u.last_name, u.referrer_id, level + 1, CAST(rh.hier + '->' + u.last_name AS VARCHAR(MAX)) as "hier" from users u
    join referrer_hierarchy_2 rh on u.referrer_id = rh.id
)
select * from referrer_hierarchy_2;