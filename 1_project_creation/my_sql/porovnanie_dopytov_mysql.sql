select * from visits
order by check_in_time desc
limit 3;

select * from users
where not (id > 5);

select * from trainers_intervals ti
    left join reservations r on r.id = ti.reservation_id
union
select * from trainers_intervals ti
    right join reservations r on r.id = ti.reservation_id;
    
select concat(first_name, " ", last_name)
from users;

select *
from trainers_intervals where interval_day = curdate();

select first_name, pow(credit_balance, 2)
from users;

select *
from visits where time(check_in_time) >= time(curtime());

select max(length(note_to_trainer))
from reservations;

select *
from users
order by rand();

select ifnull(note_to_trainer, 'empty note') 'note for trainer'
from reservations;

