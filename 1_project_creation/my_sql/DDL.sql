DROP DATABASE IF EXISTS fitflow;
CREATE DATABASE IF NOT EXISTS fitflow;
USE fitflow;

CREATE TABLE roles
(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(45) UNIQUE NOT NULL
);

CREATE TABLE users
(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    role_id INT NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    credit_balance DECIMAL(10,2) NOT NULL DEFAULT 0,
    active BIT(1) NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_users_roles FOREIGN KEY (role_id) REFERENCES roles(id)
);

CREATE TABLE transaction_types
(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45) UNIQUE NOT NULL
);

CREATE TABLE credit_transactions
(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    transaction_type_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_credit_transactions_users FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_credit_transactions_types FOREIGN KEY (transaction_type_id) REFERENCES transaction_types(id)
);

CREATE TABLE visits
(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    check_in_time DATETIME NOT NULL,
    check_out_time DATETIME,
    visit_secret VARCHAR(45),
    credit_transaction_id INT,
    CONSTRAINT fk_visits_users FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_visits_credit_transactions FOREIGN KEY (credit_transaction_id) REFERENCES credit_transactions(id)
);

CREATE TABLE reservation_status
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE reservations
(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    reservation_status_id INT NOT NULL,
    note_to_trainer VARCHAR(300),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    credit_transaction_id INT NOT NULL,
    CONSTRAINT fk_reservations_users FOREIGN KEY (customer_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_reservations_status FOREIGN KEY (reservation_status_id) REFERENCES reservation_status(id),
    CONSTRAINT fk_reservations_credit_transactions FOREIGN KEY (credit_transaction_id) REFERENCES credit_transactions(id)
);

CREATE TABLE trainers_intervals
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    trainer_id INT NOT NULL,
    interval_day DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    reservation_id INT,
    CONSTRAINT fk_trainers_intervals_users FOREIGN KEY (trainer_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_trainers_intervals_reservations FOREIGN KEY (reservation_id) REFERENCES reservations(id)
);

CREATE TABLE trainer_specializations
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(45) NOT NULL UNIQUE
);

CREATE TABLE trainers_have_specializations
(
    trainer_id INT NOT NULL,
    specialization_id INT NOT NULL,
    PRIMARY KEY (trainer_id, specialization_id),
    CONSTRAINT fk_trainers_specializations_trainer FOREIGN KEY (trainer_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_trainers_specializations_specialization FOREIGN KEY (specialization_id) REFERENCES trainer_specializations(id)
);