-- demonštrujete úspešné a neúspešné pridanie 5 záznamov pod transakciou (buď sa pridá 5 záznamov alebo žiaden) (0.5 bodov)
-- demonštrujete prácu s kurzorom (1 bod)
-- demonštrujete prácu s pivot (kontingenčnou) tabuľkou (0,5 bodov)

------------------------------ nova verzia databazy
-- USE master;
-- ALTER DATABASE dobrik3 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
-- ALTER DATABASE dobrik3 MODIFY NAME = dobrik4;
-- ALTER DATABASE dobrik4 SET MULTI_USER;
-- USE dobrik4

------------------------------ tranzakcie

select * from credit_transactions
select * from transaction_types
select * from users

--- chybna tranzakcia
begin transaction;
begin try
    update users set credit_balance += 100 where id between 5 and 9;
    insert into credit_transactions(user_id, amount, transaction_type_id) values
        (5, 100, 4),
        (6, 100, 4),
        (7, 100, 4),
        (8, 100, 4),
        (9, 100, 40); -- tu je chyba, preto tranzakcia nezbehne
    commit;
end try
begin catch
    rollback;
    print 'Chyba: ' + ERROR_MESSAGE();
end catch

select * from users
select * from credit_transactions

-- fungujuca tranzakcia
begin transaction;
begin try
    update users set credit_balance += 100 where id between 5 and 9;
    insert into credit_transactions(user_id, amount, transaction_type_id) values
        (5, 100, 4),
        (6, 100, 4),
        (7, 100, 4),
        (8, 100, 4),
        (9, 100, 4); -- chyba opravena
    commit;
end try
begin catch
    rollback;
    print 'Chyba: ' + ERROR_MESSAGE();
end catch

select * from users
select * from credit_transactions

------------------------------ kurzory

select * from users

declare @userId INT
declare @balance MONEY

declare balanceCursor cursor for
select id, credit_balance from users;

open balanceCursor
fetch next from balanceCursor into @userId, @balance

while @@fetch_status = 0
begin
    update users set credit_balance = @balance + (@balance * 0.1) where id = @userId
    fetch next from balanceCursor into @userId, @balance
end

close balanceCursor
deallocate balanceCursor

select * from users

------------------------------ pivot tabulka

select
    email,
    isnull([purchase],0),
    isnull([withdrawal],0),
    isnull([refund],0),
    isnull([reward],0)
from (
    select u.email, amount, tt.name "transaction_name" from credit_transactions ct
        join transaction_types tt on tt.id = ct.transaction_type_id
        join users u on ct.user_id = u.id
) as source
pivot (
    sum(amount)
    for transaction_name in ([purchase], [withdrawal], [refund], [reward])
) as pivot_table;