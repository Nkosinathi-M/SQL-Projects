DROP TABLE IF EXISTS Results;
DROP TABLE IF EXISTS CourseAssignment;
DROP TABLE IF EXISTS Enrollment;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Lecturer;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Department;

CREATE TABLE Department(
	DepartmentID varchar(4) NOT NULL,
	DepartmentName varchar(50) NOT NULL,
	CONSTRAINT pk_department PRIMARY KEY (DepartmentID)
);


CREATE TABLE Student(
	studentID VARCHAR(10),
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50),
	Gender VARCHAR(6),
	Email VARCHAR(30),
	Phone VARCHAR(13),
	DepartmentID VARCHAR(4),
	CONSTRAINT studentID_pk 
		PRIMARY KEY (studentID),
	CONSTRAINT fk_DepartID 
		FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Lecturer(
	LecturerID VARCHAR(6) NOT NULL,
	FirstName VARCHAR(30) NOT NULL,
	LastName VARCHAR(30) NOT NULL,
	Email VARCHAR(30),
	DepartmentID VARCHAR(4),
	CONSTRAINT pk_LecturerID PRIMARY KEY (LecturerID),
	CONSTRAINT fk_departmentId 
		FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Course(
	CourseID VARCHAR(6) NOT NULL,
	CourseName VARCHAR(50) NOT NULL,
	Credits INT,
	CONSTRAINT pk_CourseID PRIMARY KEY (CourseID)
);


CREATE TABLE CourseAssignment(
	CourseAssignmentID VARCHAR(10) NOT NULL,
	LecturerID VARCHAR(6) NOT NULL,	
	CourseID VARCHAR(6),
	Semester INT,
	AcademicYear INT,		
	CONSTRAINT pk_CourseAssignment 
		PRIMARY KEY (CourseAssignmentID),
	CONSTRAINT fk_LecturerID 
		FOREIGN KEY (LecturerID) REFERENCES Lecturer(LecturerID),
	CONSTRAINT fk_CourseID
		FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);


CREATE TABLE Enrollment(
	EnrollmentID VARCHAR(10) NOT NULL,  
	Semester INT ,
	AcademicYear INT ,
	StudentID VARCHAR(10) NOT NULL,
	CourseID VARCHAR(6) ,
	CONSTRAINT uq_enrollment
		UNIQUE(StudentID, CourseID, Semester, AcademicYear),
	CONSTRAINT pk_EnrollmentID 
		PRIMARY KEY (EnrollmentID),
	CONSTRAINT fk_studentID 
		FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
	CONSTRAINT fk_course_ID
		FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE Results(
	ResultID VARCHAR(9) NOT NULL,	
	Mark DECIMAL(5, 2),
	Grade VARCHAR(2),		
	EnrollmentID VARCHAR(10) ,
	CONSTRAINT uq_results_enrollment 
		UNIQUE (EnrollmentID),
	CONSTRAINT chk_mark
		CHECK (Mark BETWEEN 0 AND 100),
	CONSTRAINT pk_ResultID
		PRIMARY KEY (ResultID),
	CONSTRAINT fk_EnrollmentID 
		FOREIGN KEY (EnrollmentID) REFERENCES Enrollment(EnrollmentID)
);
