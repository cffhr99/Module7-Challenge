-- Create tables
-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

-- Creating Employees table
CREATE TABLE Employees (
	emp_no int NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(40) NOT NULL,
	last_name VARCHAR(40) NOT NULL,
	gender VARCHAR(6) NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
    dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);


CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

DROP TABLE dept_Emp;
CREATE TABLE dept_Emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
);


DROP TABLE Title;
CREATE TABLE Title (
	emp_no INT NOT NULL,
	title VARCHAR(40) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
);

-------------------------------------------------------------------

-- Deliverable 1:
-- Select and create retirement_title
SELECT es.emp_no,
       es.first_name,
	   es.last_name,
	   ti.title,
	   ti.from_date,
	   ti.to_date
INTO retirement_title
From Title AS ti
INNER JOIN Employees AS es
   ON (es.emp_no = ti.emp_no)
WHERE (es.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY es.emp_no;

-- review table
SELECT * FROM retirement_title LIMIT 10;

-------------------------------------------------------------------

-- select distinct emp_no
DROP TABLE unique_title;
SELECT DISTINCT ON (rt.emp_no)
       rt.emp_no,
       rt.first_name,
	   rt.last_name,
	   rt.title
INTO unique_title
From retirement_title as rt
ORDER BY rt.emp_no, rt.to_date DESC

-- review table
SELECT * FROM unique_title LIMIT 10;

-------------------------------------------------------------------

-- retrieve the number of employees by their most recent job title 
DROP TABLE retiring_title;
SELECT COUNT(ut.title),
       ut.title
INTO retiring_title
FROM Unique_title AS ut
GROUP BY ut.title
ORDER BY ut.count DESC

-- review table
SELECT * FROM retiring_title;

-------------------------------------------------------------------

-- Deliverable 2:
-- Mentorship Eligibility table
SELECT DISTINCT ON(es.emp_no)
       es.emp_no,
       es.first_name,
	   es.last_name,
	   es.birth_date,
	   de.from_date,
	   de.to_date,
	   ti.title
INTO mentorship_eligibilty
FROM employees AS es
INNER JOIN dept_emp AS de 
ON (es.emp_no = de.emp_no)
INNER JOIN title as ti
ON (es.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01') 
AND (es.birth_date BETWEEN '1965-01-01' and '1965-12-31')
ORDER BY es.emp_no

-- review table
SELECT * FROM mentorship_eligibilty
LIMIT 10;

