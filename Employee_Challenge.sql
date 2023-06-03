-- Find the number of employees retiring, by job title.
SELECT e.emp_no,
	e.first_name, 
	e.last_name, 
	ti.title, 
	ti.from_date, 
	ti.to_date	
INTO retirement_titles_1
FROM employees as e
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Removing the duplicates
SELECT DISTINCT ON (rt.emp_no) 
	rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles_1
FROM retirement_titles_1 as rt
ORDER BY rt.emp_no, rt.to_date DESC;

-- Finding job titles of those retiring
SELECT COUNT(emp_no), title
INTO retiring_titles_1
FROM unique_titles_1
GROUP BY title
ORDER BY COUNT(emp_no) DESC;


-- Find the number of employees eligible for the mentorship program
SELECT DISTINCT ON (e.emp_no)
e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date
INTO mentorship_eligibility
FROM employees as e 
INNER JOIN dept_emp as de 
ON (e.emp_no = de.emp_no)
WHERE (de.to_date = '9999-01-01') AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no