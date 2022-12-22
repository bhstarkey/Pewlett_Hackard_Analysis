-- Deliverable 1
	-- Get count of retiring employees by their title
SELECT * 
FROM employees;

SELECT
	e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees AS e
	INNER JOIN titles AS t
	  ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no
;

SELECT *
FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title

--INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC
;

SELECT
	COUNT(emp_no), title
--INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(emp_no)DESC
;

--Deliverable 2
SELECT DISTINCT ON(e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
-- INTO mentorship_eligibility
FROM employees AS e
	INNER JOIN dept_emp AS de
	  ON (e.emp_no = de.emp_no)
	INNER JOIN titles as t
	  ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no
;

SELECT DISTINCT ON(e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title,
	d.dept_name
INTO dept_retirees
FROM employees AS e
	INNER JOIN dept_emp AS de
	  ON (e.emp_no = de.emp_no)
	INNER JOIN titles AS t
	  ON (e.emp_no = t.emp_no)
	INNER JOIN departments AS d
	  ON (de.dept_no = d.dept_no)
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no
;

SELECT
	COUNT(emp_no), 
	dept_name
INTO dept_retiring
FROM dept_retirees
GROUP BY dept_name
ORDER BY COUNT(emp_no)DESC
;

SELECT * 
FROM salaries
;

SELECT DISTINCT ON(e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	s.salary
INTO retiree_salaries
FROM employees AS e
	INNER JOIN dept_emp AS de
	  ON (e.emp_no = de.emp_no)
	INNER JOIN salaries AS s
	  ON (e.emp_no = s.emp_no)
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no
;
