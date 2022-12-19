SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
	AND ( hire_date BETWEEN '1985-01-01' AND '1988-12-31')
;

SELECT COUNT (first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
	AND ( hire_date BETWEEN '1985-01-01' AND '1988-12-31')
;

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
	AND ( hire_date BETWEEN '1985-01-01' AND '1988-12-31')
;

SELECT *
FROM retirement_info;

DROP TABLE retirement_info

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
	AND ( hire_date BETWEEN '1985-01-01' AND '1988-12-31')
;
-- Check the table
SELECT * FROM retirement_info

-- Joining departments and dept_manager tables
SELECT 
	d.dept_name, 
	dm.emp_no,
	dm.from_date,
	dm.to_date
FROM departments AS d
INNER JOIN dept_manager AS dm
ON d.dept_no = dm.dept_no
;

SELECT 
	ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de
ON ri.emp_no = de.emp_no
;

SELECT 
	ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01')
;

-- Employee count by department
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp AS ce
LEFT JOIN dept_emp AS de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no
;

-- 1) emp_info
SELECT * 
FROM dept_emp
;

SELECT
	e.emp_no,
	e.last_name,
	e.first_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees AS e
INNER JOIN salaries AS s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
	AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no
;

-- 2) manager_info
SELECT
	d.dept_name,
	dm.dept_no,
	dm.emp_no,
	dm.from_date,
	dm.to_date,
	ce.first_name,
	ce.last_name
INTO manager_info
FROM departments AS d
	INNER JOIN dept_manager AS dm
	  ON (d.dept_no = dm.dept_no)
	INNER JOIN current_emp as ce
	  ON (ce.emp_no = dm.emp_no)
;

-- 3) dept_retirees
SELECT
	ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp AS ce
INNER JOIN dept_emp AS de
ON ce.emp_no = de.emp_no
INNER JOIN departments AS d
ON de.dept_no = d.dept_no
;
