# Student Management System — Business Rules

## 1. Student
### BR-01: One department can have zero or many students. Each student belongs to exactly one department.

BR-02: One student can have zero or many enrolment records over time. Each enrolment belongs to exactly one student.
## 2. Department
BR-03: One department can have zero or many lecturers. Each lecturer belongs to exactly one department.

BR-04: One department can offer zero or many courses. Each course belongs to exactly one department.
## 3. Course
BR-05: One course can have zero or many assessments. Each assessment belongs to exactly one course.

BR-06: One course can have zero or many enrolments. Each enrolment is associated with exactly one course.

BR-07: One course can have zero or many course assignments. Each course assignment refers to exactly one course.
## 4. Lecturer
BR-08: One lecturer can have zero or many course assignments. Each course assignment refers to exactly one lecturer.

BR-09: One course can be assigned to multiple lecturers, and one lecturer can be assigned to multiple courses. The CourseAssignment entity resolves this many-to-many relationship.

BR-10: One lecturer can be assigned to the same course in different semesters or academic years, provided each assignment represents a distinct permitted academic period.
## 5. Enrollment 
BR-11: One enrolment can have zero or many assessment results. Each assessment result belongs to exactly one enrolment.

BR-12: One enrolment can have zero or one confirmed final result. Each final result belongs to exactly one enrolment.

BR-13: A student may enrol in the same course in different academic periods, but duplicate enrolments for the same course, semester and year are not permitted.
## 6. Assessment 
BR-14: One assessment can have zero or many assessment results. Each assessment result refers to exactly one assessment.

BR-15: Each assessment must be associated with exactly one course.

BR-16: Each assessment must have a defined name, type, maximum mark, weighting, semester and academic year.

BR-17: An assessment's weighting must be valid according to the institution's assessment rules. Where the final mark uses weighted assessments, the applicable weights must total 100%.
## 7. AssessmentResult 
BR-18: Each assessment result must be associated with exactly one enrolment and one assessment.

BR-19: One enrolment cannot have more than one result record for the same assessment.

BR-20: An assessment mark must not be less than zero or greater than the assessment's maximum mark.

BR-21: An assessment result must relate to an assessment for the same course and academic period as the student's enrolment.
## 8. Results
BR-22: Each confirmed final result must contain a final mark and a grade.

BR-23: Each enrolment may have no confirmed final result or exactly one confirmed final result.

BR-24: The final mark and grade must comply with the institution's approved calculation and grading rules.

BR-25: The final result must correspond to the enrolment for which the student's assessment marks were recorded.
