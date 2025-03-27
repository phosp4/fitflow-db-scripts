select u.email, r.title from users u
    join roles r on r.id = u.role_id
where title = 'user'
order by created_at;

select roles.title 'role', max(users.credit_balance) 'max balance'
from users
    join roles on users.role_id = roles.id
group by roles.title;

select u.email, ts.title from users u
    join trainers_have_specializations ths on ths.trainer_id = u.id
    join trainer_specializations ts on ts.id = ths.specialization_id;

select u.first_name 'customer name', u_trainers.first_name "trainer name", r.note_to_trainer, ct.amount 'exercise price', rs.status_name "reservation status", ti.interval_day "day", ti.start_time, ti.end_time from reservations r
    join users u on u.id = r.customer_id
    join credit_transactions ct on ct.id = r.credit_transaction_id
    join reservation_status rs on rs.id = reservation_status_id
    join trainers_intervals ti on ti.reservation_id = r.id
    join users u_trainers on u_trainers.id = ti.trainer_id;

select u.first_name, ts.interval_day, ts.start_time, ts.end_time from trainers_intervals ts
    join users u on ts.trainer_id = u.id;

select CAST(MAX(v.check_out_time - v.check_in_time) as TIME) as "max duration"
from visits v
    join users u on u.id = v.user_id;

select count(*) "number of free time slots on date"
from trainers_intervals ti
where reservation_id IS NULL and interval_day = '2024-02-25';