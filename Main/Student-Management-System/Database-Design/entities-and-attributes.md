# Entities and Attributes

## 1. Introduction

This document describes the entities and their attributes for the **Student Management System** database.

Each entity represents a real-world object or concept within the system. Attributes describe the information stored about each entity.

The database uses **Primary Keys (PKs)** to uniquely identify records and **Foreign Keys (FKs)** to establish relationships between tables.

## 2. Entities

### 2.1 Student

**Purpose:** Stores personal and academic identification details of students.

| Attribute | Description | Key / Constraint |
|---|---|---|
| `StudentID` | Unique identifier for each student | PK |
| `FirstName` | Student's first name | NOT NULL |
| `LastName` | Student's surname | NOT NULL |
| `DateOfBirth` | Student's date of birth | |
| `Gender` | Student's gender, if required | |
| `Email` | Student's email address | UNIQUE |
| `PhoneNumber` | Student's contact number | |
| `DepartmentID` | Department the student belongs to | FK |

### 2.2 Department

**Purpose:** Stores information about the academic departments within the institution.

| Attribute | Description | Key / Constraint |
|---|---|---|
| `DepartmentID` | Unique identifier for each department | PK |
| `DepartmentName` | Name of the department | NOT NULL |
| `DepartmentCode` | Short code identifying the department | UNIQUE |
| `Description` | Description of the department | |
| `OfficeLocation` | Department's office location | |
| `ContactEmail` | Department's contact email | |

### 2.3 Course

**Purpose:** Stores information about the courses offered by academic departments.

| Attribute | Description | Key / Constraint |
|---|---|---|
| `CourseID` | Unique identifier for each course | PK |
| `CourseName` | Name of the course | NOT NULL |
| `CourseCode` | Unique code identifying the course | UNIQUE |
| `Credits` | Number of credits assigned to the course | |
| `DepartmentID` | Department responsible for the course | FK |

### 2.4 Lecturer

**Purpose:** Stores information about lecturers who teach courses.

| Attribute | Description | Key / Constraint |
|---|---|---|
| `LecturerID` | Unique identifier for each lecturer | PK |
| `FirstName` | Lecturer's first name | NOT NULL |
| `LastName` | Lecturer's surname | NOT NULL |
| `Email` | Lecturer's email address | UNIQUE |
| `PhoneNumber` | Lecturer's contact number | |
| `DepartmentID` | Department the lecturer belongs to | FK |

### 2.5 Enrollment

**Purpose:** Records a student's registration for a particular course during a specific academic period.

| Attribute | Description | Key / Constraint |
|---|---|---|
| `EnrollmentID` | Unique identifier for each enrollment | PK |
| `StudentID` | Student registered for the course | FK |
| `CourseID` | Course the student registered for | FK |
| `Semester` | Semester of enrollment | |
| `Year` | Academic year of enrollment | |
| `EnrollmentDate` | Date the enrollment was recorded | |
| `Status` | Current enrollment status | |

**Design note:** A student can have multiple enrollment records for different courses or academic periods.

### 2.6 CourseAssignment

**Purpose:** Resolves the many-to-many relationship between courses and lecturers by recording which lecturers are assigned to which courses.

| Attribute | Description | Key / Constraint |
|---|---|---|
| `CourseAssignmentID` | Unique identifier for each assignment | PK |
| `CourseID` | Course assigned to the lecturer | FK |
| `LecturerID` | Lecturer assigned to the course | FK |
| `Semester` | Semester of the assignment | |
| `Year` | Academic year of the assignment | |

**Design note:** A lecturer can teach multiple courses, and a course can be taught by multiple lecturers.

A composite `UNIQUE` constraint on `CourseID`, `LecturerID`, `Semester`, and `Year` can prevent duplicate assignments during the same academic period.

### 2.7 Assessment

**Purpose:** Stores information about assessments associated with a course, including tests, assignments, and examinations.

| Attribute | Description | Key / Constraint |
|---|---|---|
| `AssessmentID` | Unique identifier for each assessment | PK |
| `CourseID` | Course to which the assessment belongs | FK |
| `AssessmentName` | Name of the assessment | NOT NULL |
| `AssessmentType` | Type of assessment | |
| `MaxMark` | Maximum obtainable mark | |
| `Weight` | Assessment's contribution to the final mark | |
| `Semester` | Semester of the assessment | |
| `Year` | Academic year of the assessment | |
| `DueDate` | Assessment due date | |
| `Description` | Additional assessment information | |

### 2.8 AssessmentResult

**Purpose:** Stores an individual student's mark and feedback for a specific assessment.

| Attribute | Description | Key / Constraint |
|---|---|---|
| `AssessmentResultID` | Unique identifier for each assessment result | PK |
| `EnrollmentID` | Enrollment associated with the student and course | FK |
| `AssessmentID` | Assessment being marked | FK |
| `Mark` | Mark obtained by the student | Nullable until marked |
| `SubmissionDate` | Date the assessment was submitted | |
| `MarkedDate` | Date the assessment was marked | |
| `Feedback` | Lecturer's feedback | |
| `Status` | Submission or marking status | |

**Design notes:**

- A composite `UNIQUE` constraint on `EnrollmentID` and `AssessmentID` prevents duplicate result records for the same enrollment and assessment.
- The mark must not be negative or exceed the assessment's maximum mark.
- The assessment must belong to the same course and academic period as the enrollment.

### 2.9 Result

**Purpose:** Stores the confirmed final result for a student's course enrollment.

| Attribute | Description | Key / Constraint |
|---|---|---|
| `ResultID` | Unique identifier for each final result | PK |
| `EnrollmentID` | Enrollment associated with the final result | FK, UNIQUE |
| `FinalMark` | Confirmed overall course mark | |
| `Grade` | Grade associated with the final mark | |
| `ConfirmedDate` | Date the result was confirmed | |

**Design notes:**

- Each enrollment can have zero or one confirmed final result.
- Each final result belongs to exactly one enrollment.
- `FinalMark` represents the overall course result, while `AssessmentResult` stores individual assessment marks.

## 3. Key Definitions

| Term | Description |
|---|---|
| **Primary Key (PK)** | Uniquely identifies each record in a table. |
| **Foreign Key (FK)** | References a key in another table to establish a relationship. |
| **UNIQUE** | Prevents duplicate values or duplicate combinations of values. |
| **NOT NULL** | Requires a value to be provided. |
| **Nullable** | Allows a field to remain empty when a value is optional or not yet available. |

## 4. Design Considerations

1. Every entity must have a primary key.
2. Foreign keys must reference valid records in related tables.
3. A student's course registration is stored in `Enrollment` rather than directly in `Student`.
4. `CourseAssignment` resolves the many-to-many relationship between `Course` and `Lecturer`.
5. `AssessmentResult` stores individual assessment marks, while `Result` stores the confirmed final course result.
6. Database constraints and application-level validation must enforce the defined business rules.
7. Entity names, attribute names, data types, and constraints must remain consistent across the ERD and SQL scripts.

## 5. Conclusion

The entities and attributes provide the foundation for the Student Management System database. They define the information to be stored and the keys needed to connect the entities.

This design will guide the creation of database tables, relationships, and constraints.
