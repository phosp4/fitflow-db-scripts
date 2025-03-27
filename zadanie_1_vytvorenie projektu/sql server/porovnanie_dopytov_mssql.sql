select top 3 * from visits
order by check_in_time desc;

select * from users
where id !> 5;

select * from trainers_intervals ti
    full outer join reservations r on r.id = ti.reservation_id;

select first_name + ' ' + last_name
from users;

select *
from trainers_intervals
where interval_day = getdate();

select first_name, power(credit_balance, 2)
from users;

select *
from visits
where cast(check_in_time as TIME) >= cast(sysdatetime() as TIME);

select max(len(note_to_trainer))
from reservations;

select *
from users
order by NEWID();

select isnull(note_to_trainer, 'empty note') 'note for trainer'
from reservations;