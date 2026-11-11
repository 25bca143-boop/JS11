USE library_management;

INSERT INTO members
(full_name,email,phone,joined_on,member_type)
VALUES
('Rahul','rahul@gmail.com','9876543210','2026-01-10','Student'),
('Priya','priya@gmail.com','9876543211','2026-01-12','Faculty'),
('Arun','arun@gmail.com','9876543212','2026-02-01','Student');

INSERT INTO books
(title,author,category,total_copies,available_copies)
VALUES
('Python','Guido','Programming',5,4),
('Java','James','Programming',4,4),
('Data Science','John','Education',3,3),
('AI','Stuart','Technology',6,6),
('DBMS','Raghu','Database',2,2);

INSERT INTO loans
(member_id,book_id,issue_date,due_date,status)
VALUES
(1,1,'2026-11-01','2026-11-15','Issued'),
(2,2,'2026-11-02','2026-11-16','Issued'),
(3,3,'2026-10-01','2026-10-15','Returned');

UPDATE loans SET return_date='2026-10-12'
WHERE loan_id=3;