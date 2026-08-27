USE online_lms;
CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    course_year INT
);
CREATE TABLE Instructors (
    instructor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    specialization VARCHAR(100)
);
CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    instructor_id INT,
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id)
);
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
CREATE TABLE Learning_Materials (
    material_id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL,
    material_name VARCHAR(150) NOT NULL,
    material_type VARCHAR(50),
    material_url VARCHAR(255),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
INSERT INTO Students (name, email, course_year) VALUES
('Rahul Kumar', 'rahul@gmail.com', 2),
('Priya Sharma', 'priya@gmail.com', 2),
('Arjun Reddy', 'arjun@gmail.com', 3),
('Sneha Patel', 'sneha@gmail.com', 1),
('Aisha Khan', 'aisha@gmail.com', 3);
INSERT INTO Instructors (name, email, specialization) VALUES
('Dr. Ramesh Kumar', 'ramesh@lms.com', 'Database Management'),
('Prof. Anitha Rao', 'anitha@lms.com', 'Python Programming'),
('Dr. Suresh Babu', 'suresh@lms.com', 'Web Development');
INSERT INTO Courses (course_name, description, instructor_id) VALUES
('Database Management Systems', 'Learn SQL, databases and database design', 1),
('Python Programming', 'Learn Python programming from basics', 2),
('Web Development', 'Learn HTML, CSS and JavaScript', 3),
('Data Structures', 'Learn algorithms and data structures', 1),
('Machine Learning', 'Introduction to machine learning concepts', 2);
INSERT INTO Enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2026-08-20'),
(2, 1, '2026-08-21'),
(3, 2, '2026-08-22'),
(4, 3, '2026-08-23'),
(5, 4, '2026-08-24'),
(1, 5, '2026-08-25');
INSERT INTO Learning_Materials
(course_id, material_name, material_type, material_url)
VALUES
(1, 'DBMS Introduction Notes', 'PDF', 'lms.com/dbms-intro'),
(1, 'SQL Basics Video', 'Video', 'lms.com/sql-basics'),
(2, 'Python Basics Notes', 'PDF', 'lms.com/python-basics'),
(3, 'HTML and CSS Tutorial', 'Video', 'lms.com/html-css'),
(4, 'Data Structures Notes', 'PDF', 'lms.com/data-structures'),
(5, 'Machine Learning Introduction', 'PDF', 'lms.com/ml-intro');
SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Enrollments;
SELECT 
    s.name AS Student_Name,
    c.course_name AS Course_Name,
    e.enrollment_date
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id;
SELECT
    c.course_name AS Course_Name,
    i.name AS Instructor_Name,
    i.specialization AS Specialization
FROM Courses c
JOIN Instructors i
ON c.instructor_id = i.instructor_id;
SELECT
    c.course_name AS Course_Name,
    COUNT(e.student_id) AS Number_of_Students
FROM Courses c
LEFT JOIN Enrollments e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;
SELECT name
FROM Students
WHERE student_id IN (
    SELECT student_id
    FROM Enrollments
    WHERE course_id = (
        SELECT course_id
        FROM Courses
        WHERE course_name = 'Database Management Systems'
    )
);
SELECT course_name, description
FROM Courses
ORDER BY course_name ASC;
SELECT
    c.course_name AS Course_Name,
    lm.material_name AS Material_Name,
    lm.material_type AS Material_Type
FROM Learning_Materials lm
JOIN Courses c
ON lm.course_id = c.course_id;