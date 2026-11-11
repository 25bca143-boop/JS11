CREATE DATABASE library_management;
USE library_management;

CREATE TABLE members (
 member_id INT AUTO_INCREMENT PRIMARY KEY,
 full_name VARCHAR(100),
 email VARCHAR(120),
 phone VARCHAR(20),
 joined_on DATE,
 member_type ENUM('Student','Faculty')
);

CREATE TABLE books (
 book_id INT AUTO_INCREMENT PRIMARY KEY,
 title VARCHAR(150),
 author VARCHAR(100),
 category VARCHAR(60),
 total_copies INT,
 available_copies INT
);

CREATE TABLE loans (
 loan_id INT AUTO_INCREMENT PRIMARY KEY,
 member_id INT,
 book_id INT,
 issue_date DATE,
 due_date DATE,
 return_date DATE,
 status VARCHAR(20),
 FOREIGN KEY (member_id) REFERENCES members(member_id),
 FOREIGN KEY (book_id) REFERENCES books(book_id)
);

CREATE TABLE staff (
 staff_id INT AUTO_INCREMENT PRIMARY KEY,
 full_name VARCHAR(100),
 username VARCHAR(50),
 email VARCHAR(120)
);