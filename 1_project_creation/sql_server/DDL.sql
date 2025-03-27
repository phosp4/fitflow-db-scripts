USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'fitflow')
BEGIN
    ALTER DATABASE fitflow SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE fitflow;
END
GO

CREATE DATABASE fitflow;
GO

USE fitflow;
GO

CREATE TABLE roles
(
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(45) UNIQUE NOT NULL
);
GO

CREATE TABLE users
(
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    role_id INT NOT NULL FOREIGN KEY REFERENCES roles(id),
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    credit_balance MONEY NOT NULL DEFAULT 0,
    active BIT NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT SYSDATETIME(),
    updated_at DATETIME NOT NULL DEFAULT SYSDATETIME()
);
GO

CREATE TABLE transaction_types
(
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(45) UNIQUE NOT NULL
)
;
GO

CREATE TABLE credit_transactions
(
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL FOREIGN KEY REFERENCES users(id),
    amount MONEY NOT NULL,
    transaction_type_id INT NOT NULL FOREIGN KEY REFERENCES transaction_types(id),
    created_at DATETIME DEFAULT SYSDATETIME()
)
;
GO

CREATE TABLE visits
(
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL FOREIGN KEY REFERENCES users(id),
    check_in_time DATETIME NOT NULL,
    check_out_time DATETIME,
    visit_secret VARCHAR(45),
    credit_transaction_id INT FOREIGN KEY REFERENCES credit_transactions(id)
);
GO

CREATE TABLE reservation_status
(
    id INT PRIMARY KEY IDENTITY(1,1),
    status_name VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE reservations
(
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL FOREIGN KEY REFERENCES users(id) ON DELETE CASCADE,
    reservation_status_id INT NOT NULL FOREIGN KEY REFERENCES reservation_status(id),
    note_to_trainer VARCHAR(300),
    created_at DATETIME NOT NULL DEFAULT SYSDATETIME(),
    updated_at DATETIME NOT NULL DEFAULT SYSDATETIME(),
    credit_transaction_id INT NOT NULL FOREIGN KEY REFERENCES credit_transactions(id)
);
GO

CREATE TABLE trainers_intervals
(
    id INT PRIMARY KEY IDENTITY(1,1),
    trainer_id INT NOT NULL FOREIGN KEY REFERENCES users(id) ON DELETE CASCADE,
    interval_day DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    reservation_id INT FOREIGN KEY REFERENCES reservations(id)
);
GO

CREATE TABLE trainer_specializations
(
    id INT PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(45) NOT NULL UNIQUE
);
GO

CREATE TABLE trainers_have_specializations
(
    trainer_id INT NOT NULL,
    specialization_id INT NOT NULL,
    PRIMARY KEY (trainer_id, specialization_id),
    FOREIGN KEY (trainer_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (specialization_id) REFERENCES trainer_specializations(id)
);
GO