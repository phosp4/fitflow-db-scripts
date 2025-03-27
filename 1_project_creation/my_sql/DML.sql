INSERT INTO roles (title) values
    ('user'),
    ('trainer'),
    ('admin');

INSERT INTO users(role_id, email, password_hash, first_name, last_name, credit_balance) VALUES
    (1, 'samueldobrik@gmail.com', '3425u4390j4i3oj534435oji', 'Samuel', 'Dobrik', 10),
    (1, 'janedoe@example.com', 'ajfkdlfj23904jfdf', 'Jane', 'Doe', 2),
    (1, 'johndoe@example.com', '89hjsdf823jhd8', 'John', 'Doe', 30),
    (1, 'emilyrose@example.com', 'dfskj8943jfsd', 'Emily', 'Rose', 50),
    (1, 'michael.scott@dundermifflin.com', 'kfjds89sdjfsd', 'Michael', 'Scott', 40),
    (1, 'pambeesly@dundermifflin.com', 'sdfjks839jfjds', 'Pam', 'Beesly', 25),
    (2, 'fitnessguru@example.com', 'fjds89fsd8fjsd', 'Chris', 'Trainer', 60), -- Trainer
    (2, 'strengthmaster@example.com', 'sfjksd839jfds', 'Jordan', 'Fit', 70), -- Trainer
    (2, 'yogawithamy@example.com', 'sdfkjsd823jfd', 'Amy', 'Wellness', 65), -- Trainer
        (3, 'adminone@example.com', '4543534508089ifg', 'Alex', 'Smith', 0), -- Admin
    (3, 'admintwo@example.com', ' 43jk53jh5kj34h', 'Taylor', 'Johnson', 0); -- Admin

INSERT INTO transaction_types (name) values
    ('purchase'),
    ('withdrawal'),
    ('refund'),
    ('reward');

INSERT INTO credit_transactions (user_id, amount, transaction_type_id) VALUES
    (1, 34, 1),
    (2, 50, 1),
    (3, 20, 1),
    (4, 75, 1),
    (5, 100, 1),
    (6, 30, 1),
    (7, 15, 1),
    (8, 50, 1),
    (9, 120, 1),
    (10, 25, 1),
    (1, 60, 3),
    (2, 90, 4),
    (3, 45, 1),
    (6, 80, 1),
    (7, 55, 2),
    (8, 30, 3),
    (9, 95, 4),
    (10, 40, 1),
    (1, 70, 2),
    (2, 25, 3),
    (3, 85, 2),
    (4, 60, 1),
    (5, 50, 2);

INSERT INTO visits (user_id, check_in_time, check_out_time, visit_secret, credit_transaction_id) VALUES
    (1, '2025-02-22 08:00:00', '2025-02-22 10:00:00', 'abc123', 1),
    (2, '2025-02-15 09:30:00', '2025-02-15 11:00:00', 'def456', 2),
    (3, '2025-01-30 10:15:00', '2025-01-30 12:00:00', 'ghi789', 3),
    (4, '2025-01-20 11:00:00', '2025-01-20 13:30:00', 'jkl012', 4),
    (5, '2024-12-25 12:00:00', '2024-12-25 14:00:00', 'mno345', 5),
    (6, '2024-11-10 13:30:00', '2024-11-10 15:30:00', 'pqr678', 6),
    (7, '2024-10-05 14:45:00', '2024-10-05 16:45:00', 'stu901', 7),
    (8, '2023-09-18 15:00:00', '2023-09-18 17:00:00', 'vwx234', 8),
    (9, '2023-08-22 16:15:00', '2023-08-22 18:15:00', 'yz5678', 9),
    (10, '2023-07-10 17:30:00', '2023-07-10 19:30:00', 'opq678', 10);

INSERT INTO reservation_status (status_name) VALUES
    ('pending'),
    ('confirmed'),
    ('cancelled');

INSERT INTO reservations (customer_id, reservation_status_id, note_to_trainer, credit_transaction_id) VALUES
    (1, 2, NULL, 13),
    (2, 2, 'First time booking, need guidance.', 14),
    (3, 2, 'Want to focus on strength training.', 15),
    (4, 3, NULL, 16);

INSERT INTO trainers_intervals (trainer_id, interval_day, start_time, end_time, reservation_id) VALUES
    (7, '2024-02-25', '08:00:00', '09:00:00', NULL),
    (7, '2024-02-27', '14:00:00', '15:00:00', NULL),
    (7, '2024-03-01', '09:00:00', '10:00:00', NULL),
    (8, '2024-02-26', '10:00:00', '11:00:00', NULL),
    (8, '2024-02-29', '15:00:00', '16:00:00', 1),
    (8, '2024-03-02', '13:00:00', '14:00:00', 2),
    (9, '2024-02-28', '16:00:00', '17:00:00', 3),
    (9, '2024-03-04', '08:00:00', '09:00:00', NULL),
    (9, '2024-03-06', '12:00:00', '13:00:00', NULL),
    (9, '2024-03-08', '09:00:00', '10:00:00', NULL);

INSERT INTO trainer_specializations (title) VALUES
    ('muscle'),
    ('strength training'),
    ('cardio fitness'),
    ('weight loss'),
    ('bodybuilding'),
    ('flexibility & mobility'),
    ('injury rehabilitation'),
    ('endurance training'),
    ('functional fitness'),
    ('sports performance'),
    ('yoga & mindfulness'),
    ('high-intensity interval training (HIIT)'),
    ('nutrition coaching'),
    ('powerlifting'),
    ('cross-training');

INSERT INTO trainers_have_specializations (trainer_id, specialization_id) VALUES
    (7, 1),
    (7, 2),
    (7, 5),
    (7, 10),
    (8, 3),
    (8, 4),
    (8, 6),
    (8, 12),
    (9, 7),
    (9, 8),
    (9, 9),
    (9, 14);