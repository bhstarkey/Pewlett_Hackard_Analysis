-- Deliverable 1
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title

INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC
;

SELECT
	COUNT(emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(emp_no)DESC
;