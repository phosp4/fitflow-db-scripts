-- poradove
select amount,
    row_number() over (order by id) "poradove cislo",
    ntile(2) over (order by id) "rozdel do casti"
from credit_transactions
where amount > 20;

select amount,
    (select count(*)
        from credit_transactions
        where ct_current.id >= id and amount > 20) "poradove cislo",
    case
        when (select count(*) 
                from credit_transactions
                where ct_current.id >= id and amount > 20) < (select count(*) from credit_transactions where amount > 20)/2 then 1
        else 2
    end "rozdel do casti"
from credit_transactions ct_current where amount > 20;

-- aggregacne
select amount, transaction_type_id as "type",
    count(amount) over (partition by amount) "pocet",
    sum(amount) over (partition by amount) "sucet"
from credit_transactions
where amount > 50
order by amount;

select amount, transaction_type_id "type",
    (select count(*) from credit_transactions where amount=ct_current.amount and amount>50) "pocet",
    (select sum(amount) from credit_transactions where amount=ct_current.amount and amount>50) "sucet"
from credit_transactions ct_current
where amount > 50
order by amount;

-- analyticke
select amount, transaction_type_id as "type",
    first_value(amount) over (partition by transaction_type_id order by amount) "first val"
from credit_transactions
where amount > 70
order by transaction_type_id;

select amount, transaction_type_id as "type",
    (select top 1 amount from credit_transactions where transaction_type_id = ct_cur.transaction_type_id and amount>70 order by amount) "first val"
from credit_transactions ct_cur
where amount > 70
order by transaction_type_id;