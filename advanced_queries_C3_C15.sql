USE library_management;

-- C3
SELECT category, COUNT(*) AS titles,
SUM(total_copies) AS copies
FROM books GROUP BY category;

-- C4
SELECT b.title, COUNT(*) AS borrowed
FROM books b JOIN loans l ON b.book_id=l.book_id
GROUP BY b.book_id,b.title
ORDER BY borrowed DESC LIMIT 5;

-- C5
SELECT m.full_name FROM members m
LEFT JOIN loans l ON m.member_id=l.member_id
WHERE l.loan_id IS NULL;

-- C6
SELECT m.full_name,b.title,l.due_date
FROM loans l
JOIN members m ON l.member_id=m.member_id
JOIN books b ON l.book_id=b.book_id
WHERE l.return_date IS NULL;

-- C7
SELECT DATEDIFF(return_date,due_date) AS days_late,
DATEDIFF(return_date,due_date)*2 AS fine
FROM loans
WHERE return_date>due_date;

-- C8
SELECT member_id,
SUM(DATEDIFF(return_date,due_date)*2) AS total_fine
FROM loans
WHERE return_date>due_date
GROUP BY member_id HAVING total_fine>0;

-- C9
SELECT m.member_type,COUNT(l.loan_id) AS borrowed
FROM members m LEFT JOIN loans l
ON m.member_id=l.member_id
GROUP BY m.member_type;

-- C10
SELECT m.full_name,COUNT(l.loan_id) AS borrowed,
RANK() OVER(ORDER BY COUNT(l.loan_id) DESC) AS ranking
FROM members m LEFT JOIN loans l
ON m.member_id=l.member_id
GROUP BY m.member_id,m.full_name;

-- C11
SELECT b.category,COUNT(l.loan_id) AS issues
FROM books b JOIN loans l ON b.book_id=l.book_id
GROUP BY b.category ORDER BY issues DESC;

-- C12
SELECT title FROM books
WHERE available_copies=0
AND book_id IN (
SELECT book_id FROM loans WHERE return_date IS NULL
);

-- C13
DELIMITER //
CREATE PROCEDURE member_history(IN p_id INT)
BEGIN
SELECT b.title,l.issue_date,l.due_date,l.return_date
FROM loans l JOIN books b ON l.book_id=b.book_id
WHERE l.member_id=p_id;
END //
DELIMITER ;

CALL member_history(1);

-- C14
DELIMITER //
CREATE TRIGGER after_loan_insert
AFTER INSERT ON loans
FOR EACH ROW
BEGIN
UPDATE books
SET available_copies=available_copies-1
WHERE book_id=NEW.book_id
AND available_copies>0;
END //
DELIMITER ;

-- C15: Popular books
SELECT b.title,COUNT(l.loan_id) AS borrowed,
b.available_copies
FROM books b LEFT JOIN loans l ON b.book_id=l.book_id
GROUP BY b.book_id,b.title,b.available_copies
ORDER BY borrowed DESC LIMIT 5;

-- Overdue reminders
SELECT m.full_name,b.title,l.due_date
FROM loans l
JOIN members m ON l.member_id=m.member_id
JOIN books b ON l.book_id=b.book_id
WHERE l.return_date IS NULL AND l.due_date<CURDATE();