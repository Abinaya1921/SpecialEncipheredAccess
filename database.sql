CREATE DATABASE stego_db;

USE stego_db;

CREATE TABLE users(
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100),
    password VARCHAR(100),
    role VARCHAR(50)
);

CREATE TABLE reports(
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_name VARCHAR(100),
    secret_data TEXT,
    stego_text TEXT
);

SHOW TABLES;

SHOW DATABASES;

INSERT INTO users(username,password,role)
VALUES('admin','admin123','Admin');

ALTER TABLE reports
ADD file_name VARCHAR(200);

select * from reports where patient_name=Abinaya;

DROP TABLE IF EXISTS reports;

CREATE TABLE reports(
id INT PRIMARY KEY AUTO_INCREMENT,
patient_name VARCHAR(100),
secret_data TEXT,
stego_text TEXT,
file_name VARCHAR(200)
);

SET SQL_SAFE_UPDATES = 0;
DELETE FROM reports;

select stego_text from reports;

ALTER TABLE reports
MODIFY stego_text LONGTEXT;

CREATE TABLE logs(
id INT PRIMARY KEY AUTO_INCREMENT,
username VARCHAR(100),
activity VARCHAR(255),
log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE users
ADD email VARCHAR(100);

ALTER TABLE reports
ADD doctor_name VARCHAR(100);

select * from reports;

CREATE TABLE shared_reports(
id INT PRIMARY KEY AUTO_INCREMENT,
report_id INT,
sender_doctor VARCHAR(100),
receiver_doctor VARCHAR(100),
shared_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

insert into users(username,password,role,email)
values(
'admin',
'240be518fabd2724ddb6f04eeb7a3b5d5b4b9f6c6e0f4b5f2d5f9c8b6f8b6d8',
'admin',
'admin@gmail.com'
);

select * from users;