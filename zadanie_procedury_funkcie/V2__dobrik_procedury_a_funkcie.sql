USE master;
ALTER DATABASE dobrik SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
ALTER DATABASE dobrik MODIFY NAME = dobrik2;
ALTER DATABASE dobrik2 SET MULTI_USER;
USE dobrik2;

-- procedure
IF OBJECT_ID('DeactivateUser', 'P') IS NOT NULL DROP PROC DeactivateUser
GO
CREATE PROCEDURE DeactivateUser @user_id INT
AS
BEGIN
    update users set active = 0, credit_balance = 0 where id=@user_id;
END
GO
EXEC DeactivateUser 5;

-- inline function - without declared columns - teda ako parametrizovany view
IF OBJECT_ID('SelectActiveTrainers', 'IF') IS NOT NULL DROP FUNCTION SelectActiveTrainers
GO
CREATE FUNCTION SelectActiveTrainers() RETURNS Table AS
RETURN (
    select u.*, r.title as asdfdasfda from users u
    join roles r on r.id = u.role_id
    where active=1 and r.title='trainer'
)
GO
select * from SelectActiveTrainers();

-- table valued function - with declared columns
IF OBJECT_ID('SelectVisitsAndPrice', 'TF') IS NOT NULL DROP FUNCTION SelectVisitsAndPrice
GO
CREATE FUNCTION SelectVisitsAndPrice() RETURNS @TimesAndPrice Table (
    check_in_time DATETIME,
    check_out_time DATETIME,
    price MONEY
) AS
BEGIN
    insert into @TimesAndPrice
        select  check_in_time, check_out_time, ct.amount "price"
        from visits v join credit_transactions ct on v.credit_transaction_id=ct.id
    RETURN;
END
GO
select * from SelectVisitsAndPrice();

-- scalar function
IF OBJECT_ID('GetVisitsEarningsPerDay', 'FN') IS NOT NULL DROP FUNCTION GetVisitsEarningsPerDay
GO
CREATE FUNCTION GetVisitsEarningsPerDay(@date DATE) RETURNS MONEY AS
BEGIN
    DECLARE @sum MONEY;
    select @sum = sum(price) from SelectVisitsAndPrice() where cast(check_in_time as DATE)=@date
    return @sum
END
GO
select dbo.GetVisitsEarningsPerDay('2025-02-15');