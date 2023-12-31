Active: 1691244961599 @@ 127.0.0.1 @ 5432 @ test1
DROP DATABASE
    university_management;

CREATE DATABASE test ALTER DATABASE test RENAME TO test1;

-- ## Create Table

CREATE TABLE
    student(
        student_id INT,
        first_name VARCHAR(50),
        last_name VARCHAR(50),
        cgpa NUMERIC(1, 2)
    );

-- ## Rename a table name

ALTER TABLE student RENAME TO learners;

-- ## Delete table

DROP TABLE learners;

-- ## Crate a table with constraints

CREATE TABLE
    "user2" (
        user_id SERIAL PRIMARY KEY,
        username VARCHAR(255) UNIQUE NOT NULL,
        email VARCHAR(255) UNIQUE NOT NULL,
        age INT DEFAULT 18
    );

CREATE TABLE
    "user1" (
        user_id SERIAL,
        username VARCHAR(255) NOT NULL,
        email VARCHAR(255) NOT NULL,
        PRIMARY KEY(user_id, username),
        UNIQUE(username, email)
    );

-- ## Inset Data

INSERT INTO
    user2(user_id, username, email, age)
VALUES (1, 'mahabub', 'mah@bub.com', 20);

INSERT INTO
    user2 (username, email)
VALUES ('mah1', 'mah1@pg.com'), ('mah2', 'mah2@gmail.com'), ('mah3', 'mah3@gmail.com');

-- ## Delete table data

TRUNCATE TABLE user2;

-- ## Alter table

-- 1. add a column, drop a column, change data type for column

-- 2. rename a column, set default value

-- 3. add constraint to a column, drop constraint, table rename

ALTER TABLE user2
ADD
    COLUMN password VARCHAR(255) DEFAULT 'admin123' NOT NULL;

ALTER TABLE user2 DROP COLUMN age;

ALTER TABLE user2 ADD COLUMN demo INT;

ALTER TABLE user2 ALTER demo TYPE TEXT;

ALTER TABLE user2 ALTER COLUMN country SET DEFAULT 'bangladesh';

ALTER TABLE user2 ALTER COLUMN country DROP DEFAULT;

INSERT INTO user2 VALUES(4,'meyu4', 'meu4@dma.com');

ALTER TABLE user2 RENAME COLUMN demo TO country;

ALTER TABLE user2 ALTER COLUMN country set NOT NULL;

ALTER TABLE user2 ALTER COLUMN country DROP NOT NULL;

ALTER TABLE user2 ADD CONSTRAINT unique_email UNIQUE(email);

ALTER TABLE user2 DROP CONSTRAINT unique_email UNIQUE(email);

SELECT * FROM user2;

-- ## Department Table

CREATE TABLE
    Department (
        deptID SERIAL PRIMARY KEY,
        deptName VARCHAR(50)
    );

INSERT INTO Department VALUES(1, 'IT');

DELETE FROM Department WHERE deptID = 1;

SELECT * FROM Department;

-- ## Employ Table

CREATE TABLE
    Employee(
        empID SERIAL PRIMARY KEY,
        empName VARCHAR(50) NOT NULL,
        departmentID INT,
        CONSTRAINT fk_constraint_dept FOREIGN KEY (departmentID) REFERENCES Department(deptID)
    );

INSERT INTO Employee VALUES(1, 'Mahabub', 1) ;

DELETE FROM Employee WHERE empID = 1;

SELECT * FROM Employee;

-- ## Update and Deletion

CREATE TABLE
    courses (
        course_id SERIAL PRIMARY KEY,
        course_name VARCHAR(255) NOT NULL,
        description VARCHAR(255),
        published_date DATE
    );

INSERT INTO
    courses(
        course_name,
        description,
        published_date
    )
VALUES (
        'POSTGRESQL for developers',
        'a complete postgres for developers',
        '2020-07-13'
    ), (
        'POSTGRESQL for programmes',
        'a complete postgres for DBA',
        NULL
    ), (
        'POSTGRESQL high performance',
        NULL,
        NULL
    ), (
        'POSTGRESQL Bootcamp',
        'learners postgres for bootcamp',
        '2023-05-13'
    ), (
        'Mastaring POSTGRESQL',
        'mastering postgres for 21 day',
        '2011-02-17'
    );

-- Update database table row

UPDATE courses
SET
    course_name = 'postgres',
    description = 'Dummy Text'
WHERE
    course_id > 1
    OR course_id < 5;

-- Deleted database table row

DELETE FROM courses WHERE course_id = 1;

SELECT * FROM courses;

-- ## Select Basic

CREATE TABLE
    IF NOT EXISTS department (
        deptID SERIAL PRIMARY KEY,
        name TEXT NOT NULL
    );

CREATE TABLE
    IF NOT EXISTS employee(
        empID SERIAL PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        salary INTEGER NOT NULL,
        joining_date DATE NOT NULL,
        deptID INTEGER NOT NULL,
        CONSTRAINT fk_deptID FOREIGN KEY(deptID) REFERENCES department(deptID)
    );

-- Select all rows

SELECT * FROM department;

SELECT * FROM employee;

-- Select some column

SELECT name, email FROM employee;

-- Not duplicate value

SELECT DISTINCT name FROM employee;

-- Select Filter

SELECT * FROM employee WHERE salary < 90000;

SELECT * FROM employee WHERE salary < 10000 AND salary > 90000 ;

SELECT * FROM employee WHERE joining_date > "2020-01-01";

SELECT * FROM employee WHERE joining_date <> "2020-01-01" ;

-- Sort in name

SELECT * FROM employee ORDER BY name ASC ;

SELECT * FROM employee ORDER BY name ASC LIMIT 10 OFFSET 1 ;

SELECT * FROM employee ORDER BY salary DESC LIMIT 1;

SELECT * FROM employee ORDER BY salary DESC LIMIT 1 OFFSET 2;

-- ## IN, NOT IN, BETWEEN, LIKE

SELECT * FROM employee WHERE empid IN(2,3, 5);

SELECT * FROM employee WHERE empid NOT IN(2,3, 5);

SELECT * FROM employee WHERE salary BETWEEN 10000 AND 50000;

-- LIKE

SELECT * FROM employee WHERE name = 'A';

SELECT * FROM employee WHERE name LIKE 'A%';

SELECT * FROM employee WHERE name LIKE '%a';

SELECT * FROM employee WHERE name LIKE '%a%';

-- Specific Position

SELECT * FROM employee WHERE name LIKE '__r%';

SELECT * FROM employee WHERE name LIKE '__r__';

SELECT * FROM employee WHERE name LIKE 'a%o';

SELECT * FROM employee WHERE name LIKE 'a%o';

SELECT * FROM employee WHERE name IS NULL;

-- ## Joining

CREATE TABLE
    department (
        department_id INT PRIMARY KEY,
        department_name VARCHAR(100)
    );

SELECT * from department;

CREATE TABLE
    employee(
        employee_id INT PRIMARY KEY,
        full_name VARCHAR(100),
        department_id INT,
        job_role VARCHAR(100),
        manager_id INT,
        FOREIGN KEY (department_id) REFERENCES department(department_id)
    );

SELECT * FROM employee;

-- Inner Join

SELECT
    employee.full_name,
    employee.job_role,
    department.department_name
FROM employee
    INNER JOIN department ON department.department_id = employee.department_id;

SELECT *
FROM employee
    INNER JOIN department ON department.department_id = employee.department_id;

-- Left Join

SELECT *
FROM employee
    LEFT JOIN department ON department.department_id = employee.department_id;

-- Right Join

SELECT *
FROM employee
    RIGHT JOIN department ON department.department_id = employee.department_id;

-- Full Join

SELECT *
FROM employee
    FULL JOIN department ON department.department_id = employee.department_id;

-- Natural Join

SELECT * FROM employee NATURAL JOIN department;

-- Cross Join

SELECT * FROM employee CROSS JOIN department;

-- ## Aggregate Functions

SELECT * FROM employee;

SELECT AVG(salary) FROM employee;

SELECT AVG(salary) AS averageSalary FROM employee;

SELECT MIN(salary) AS averageSalary FROM employee;

SELECT MAX(salary) AS averageSalary FROM employee;

SELECT SUM(salary) AS averageSalary FROM employee;

SELECT deptid, AVG(salary) FROM employee GROUP BY deptid;

SELECT
    d.name,
    AVG(e.salary),
    SUM(e.salary),
    MAX(e.salary),
    MIN(e.salary),
    COUNT(*)
FROM employee e
    FULL JOIN department d ON e.deptid = d.deptid
GROUP BY d.name;

SELECT
    d.name,
    AVG(e.salary),
    SUM(e.salary),
    MAX(e.salary),
    MIN(e.salary),
    COUNT(*)
FROM employee e
    FULL JOIN department d ON e.deptid = d.deptid
GROUP BY d.name
HAVING AVG(e.salary) > 65000;

-- ## Sub Queries

SELECT *
FROM employee
WHERE salary = (
        SELECT max(salary)
        FROM employee
    );

SELECT *
FROM employee
WHERE salary IN (
        SELECT salary
        FROM employee
        WHERE name LIKE '%a%'
    );

SELECT *
FROM employee
WHERE salary > (
        SELECT avg(salary)
        FROM employee
    );

SELECT email, (
        SELECT avg(salary)
        FROM employee
    )
FROM employee;

SELECT deptid, avg_salary
FROM (
        SELECT
            deptid,
            avg(salary) as avg_salary
        FROM employee
        GROUP BY
            deptid
    ) as tempTable;

JOIN department d ON d.dept_id = deptID;

-- ## Views

CREATE VIEW view_name AS SELECT name FROM employee;

SELECT * FROM view_name;

-- ## Stored Procedures and Functions

CREATE PROCEDURE DEACTIVATE_UNPAID_ACCOUNT() LANGUAGE 
SQL AS 
$$ 
    UPDATE UPDATE accounts SET account = FALSE WHERE balance = 0 
$$;

CALL DEACTIVATE_UNPAID_ACCOUNT();

CREATE FUNCTION ACCOUNT_TYPE_COUNT(ACCOUNT_TYPE TEXT
) RETURNS INT 
LANGUAGE plpgsql AS 
$$
    DECLARE account_count INT;
    BEGIN
        SELECT count(*) INTO account_count FROM accounts WHERE account.account_type = $1;
        RETURN account_count;
    END;
$$;


-- ## Triggers 
CREATE TABLE products(
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    base_price FLOAT8 NOT NULL,
    final_price FLOAT8
);

INSERT INTO products VALUES(1, 'Mango', 55);

SELECT * FROM products;

CREATE TRIGGER add_tax_trigger
AFTER INSERT ON products
FOR EACH ROW
EXECUTE FUNCTION update_final_price();

CREATE OR REPLACE FUNCTION update_final_price()
RETURNS TRIGGER LANGUAGE PLPGSQL  AS
$$
    BEGIN
    -- NEW, OLD
        NEW.final_price := NEW.base_price * 1.05;
        RETURN NEW;
    END;
$$;

-- ## Indexing and Optimization

SELECT * FROM employee;

EXPLAIN ANALYSE SELECT empid  FROM employee;

CREATE INDEX name_idx ON employee(name);

EXPLAIN ANALYSE SELECT empid  FROM employee WHERE name = 'Emma Davis';

EXPLAIN ANALYSE SELECT empid  FROM employee WHERE name LIKE '%emm%';