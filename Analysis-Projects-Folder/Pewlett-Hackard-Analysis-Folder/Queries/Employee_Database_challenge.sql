-- Deliverable 1: The Number of Retiring Employees by Title

-- Retrieve the emp_no, first_name, and last_name columns from the Employees table. 
-- And title, from_date and to_date from titles table.
-- For employees born between 1952 and 1955.
-- Then, order by the employee number.

SELECT e.emp_no, e.first_name, e.last_name,
       t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- SELECT ALL from retirement_titles table, for display.
SELECT * FROM retirement_titles;

-- Use Dictinct with Order by to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date ='9999-01-01'
ORDER BY emp_no, title DESC;

-- Another query to retrieve the number of employees by 
-- their most recent job titlewho are about to retire.

-- First, retrieve the number of titles from the Unique Titles table.
SELECT COUNT(title) FROM unique_titles;

-- Create the retiring_table
SELECT COUNT(ut.title), title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title
ORDER BY count DESC;


-- Deliverable 2: The Employees Eligible for the Mentorship Program

-- Create the Mentorship Eligibility table.

SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,
	   de.from_date, de.to_date,
	   t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (t.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

SELECT * FROM mentorship_eligibility;