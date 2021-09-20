--Deliverable 1

SELECT emp_no, first_name, last_name FROM employees

SELECT title, from_date, to_date FROM titles

SELECT employees.emp_no, first_name, last_name, title, from_date, to_date 
INTO retirement_titles
FROM employees
JOIN titles ON employees.emp_no = titles.emp_no
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) 
	emp_no,
	first_name,
	last_name,
	title

INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

SELECT COUNT(unique_titles.title), unique_titles.title
INTO retiring_titles
FROM unique_titles
GROUP BY unique_titles.title
ORDER BY unique_titles.count DESC;

--Deliverable 2
SELECT DISTINCT ON (emp_no) employees.emp_no, first_name, last_name, birth_date, dept_emp.from_date, dept_emp.to_date, title
INTO mentorship_eligibility
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN titles ON employees.emp_no = titles.emp_no
WHERE dept_emp.to_date = '9999-01-01' AND birth_date BETWEEN '1965-01-01' AND '1965-12-31' 
ORDER BY employees.emp_no ASC;

--Additional Query
SELECT DISTINCT ON (emp_no) employees.emp_no, first_name, last_name, birth_date, dept_emp.from_date, dept_emp.to_date, title
INTO not_retiring
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN titles ON employees.emp_no = titles.emp_no
WHERE dept_emp.to_date = '9999-01-01' AND birth_date <= '1965-01-01' 
ORDER BY employees.emp_no ASC;

--Additional Query
SELECT COUNT(not_retiring.title), not_retiring.title
INTO not_retiring_titles
FROM not_retiring
GROUP BY not_retiring.title
ORDER BY not_retiring.count DESC;
