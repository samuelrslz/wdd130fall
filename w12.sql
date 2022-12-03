-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `university` ;

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` DEFAULT CHARACTER SET utf8 ;
USE `university` ;

-- -----------------------------------------------------
-- Table `university`.`colleges`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`colleges` ;

CREATE TABLE IF NOT EXISTS `university`.`colleges` (
  `college_id` INT NOT NULL AUTO_INCREMENT,
  `college_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`departments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`departments` ;

CREATE TABLE IF NOT EXISTS `university`.`departments` (
  `dept_id` INT NOT NULL AUTO_INCREMENT,
  `dept_name` VARCHAR(45) NOT NULL,
  `dept_code` VARCHAR(45) NOT NULL,
  `college_id` INT NOT NULL,
  PRIMARY KEY (`dept_id`),
  INDEX `fk_departments_colleges1_idx` (`college_id` ASC) VISIBLE,
  CONSTRAINT `fk_departments_colleges1`
    FOREIGN KEY (`college_id`)
    REFERENCES `university`.`colleges` (`college_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`courses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`courses` ;

CREATE TABLE IF NOT EXISTS `university`.`courses` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `course_name` VARCHAR(45) NOT NULL,
  `course_number` INT NOT NULL,
  `course_credits` INT NOT NULL,
  `dept_id` INT NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `fk_courses_departments1_idx` (`dept_id` ASC) VISIBLE,
  CONSTRAINT `fk_courses_departments1`
    FOREIGN KEY (`dept_id`)
    REFERENCES `university`.`departments` (`dept_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`semesters`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`semesters` ;

CREATE TABLE IF NOT EXISTS `university`.`semesters` (
  `semester_id` INT NOT NULL AUTO_INCREMENT,
  `year` YEAR(4) NOT NULL,
  `term` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`semester_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`faculty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`faculty` ;

CREATE TABLE IF NOT EXISTS `university`.`faculty` (
  `faculty_id` INT NOT NULL AUTO_INCREMENT,
  `faculty_fname` VARCHAR(45) NOT NULL,
  `faculty_lname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`faculty_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`sections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`sections` ;

CREATE TABLE IF NOT EXISTS `university`.`sections` (
  `section_id` INT NOT NULL AUTO_INCREMENT,
  `section_capacity` INT NOT NULL,
  `section_course` VARCHAR(20) NOT NULL,
  `section_number` INT NULL,
  `faculty_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `semester_id` INT NOT NULL,
  PRIMARY KEY (`section_id`),
  INDEX `fk_sections_faculty1_idx` (`faculty_id` ASC) VISIBLE,
  INDEX `fk_sections_courses1_idx` (`course_id` ASC) VISIBLE,
  INDEX `fk_sections_semesters1_idx` (`semester_id` ASC) VISIBLE,
  CONSTRAINT `fk_sections_faculty1`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `university`.`faculty` (`faculty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sections_courses1`
    FOREIGN KEY (`course_id`)
    REFERENCES `university`.`courses` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sections_semesters1`
    FOREIGN KEY (`semester_id`)
    REFERENCES `university`.`semesters` (`semester_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`students`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`students` ;

CREATE TABLE IF NOT EXISTS `university`.`students` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(20) NOT NULL,
  `lname` VARCHAR(45) NOT NULL,
  `gender` ENUM("F", "M") NOT NULL,
  `city` VARCHAR(30) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `dob` DATE NOT NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`sections_has_students`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`sections_has_students` ;

CREATE TABLE IF NOT EXISTS `university`.`sections_has_students` (
  `section_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  PRIMARY KEY (`section_id`, `student_id`),
  INDEX `fk_sections_has_students_students1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_sections_has_students_sections1_idx` (`section_id` ASC) VISIBLE,
  CONSTRAINT `fk_sections_has_students_sections1`
    FOREIGN KEY (`section_id`)
    REFERENCES `university`.`sections` (`section_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sections_has_students_students1`
    FOREIGN KEY (`student_id`)
    REFERENCES `university`.`students` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;





-- Insert Statements

USE university;

INSERT INTO colleges
	(college_name)
VALUES
	("College of Physical Science and Engineering"),
    ("College of Business and Communication"),
    ("College of Language and Letters");
    
SELECT * FROM colleges;


INSERT INTO departments
	(dept_name, dept_code, college_id)
VALUES
	("Computer Information Technology", "CIT", 1),
    ("Economics", "ECON", 2),
    ("Humanities and Philosophy", "HUM", 3);
    
SELECT * FROM departments;


INSERT INTO courses
	(course_name, course_number, course_credits, dept_id)
VALUES 
	("Intro to Databases", 111, 3, 1),
    ("Econometrics", 388, 4, 2),
    ("Micro Economics", 150, 3, 2),
    ("Classical Heritage", 376, 2, 3);
    
SELECT * FROM courses;    


INSERT INTO faculty
	(faculty_fname, faculty_lname)
VALUES
	("Marty", "Morring"),
    ("Nate", "Nathan"),
    ("Ben", "Barrus"),
    ("John", "Jensen"),
    ("Bill", "Barney");
    
SELECT * FROM faculty;


INSERT INTO semesters
	(year, term)
VALUES
	("2019", "Fall"),
    ("2018", "Winter");
    
SELECT * FROM semesters;


INSERT INTO students
	(fname, lname, gender, city, state, dob)
VALUES
	("Paul", "Miller", "M", "Dallas", "TX", "1996-02-22"),
    ("Katie", "Smith", "F", "Provo", "UT", "1995-07-22"),
    ("Kelly", "Jones", "F", "Provo", "UT", "1998-06-22"),
    ("Devon", "Merrill", "M", "Mesa", "AZ", "2000-07-22"),
    ("Mandy", "Murdock", "F", "Topeka", "KS", "1996-11-22"),
    ("Alece", "Adams", "F", "Rigby", "ID", "1997-05-22"),
    ("Bryce", "Carlson", "M", "Bozeman", "MT", "1997-11-22"),
    ("Preston", "Larsen", "M", "Decatur", "TN", "1996-09-22"),
    ("Julia", "Madsen", "F", "Rexburg", "ID", "1998-09-22"),
    ("Susan", "Sorensen", "F", "Mesa", "AZ", "1998-08-09");
    
SELECT * FROM students;
    

INSERT INTO sections
	(section_capacity, section_course, section_number, faculty_id, course_id, semester_id)
VALUES
(30, "CIT 111", 1, 1, 1, 1),
(50, "ECON 150", 1, 2, 3, 1),
(50, "ECON 150", 2, 2, 3, 1),
(35, "ECON 388", 1, 3, 2, 1),
(30, "HUM 376", 1, 4, 4, 1),
(30, "CIT 111", 2, 1, 1, 2), -- Delete the first numbers of each line
(35, "CIT 111", 3, 5, 1, 2),
(50, "ECON 150", 1, 2, 3, 2),
(50, "ECON 150", 2, 2, 3, 2),
(30, "HUM 376", 1, 4, 4, 2);
    
SELECT * FROM sections;

INSERT INTO sections_has_students
	(section_id, student_id)
VALUES
	(7, 6),
    (6, 7),
    (8, 7),
    (10, 7),
    (5, 4),
    (9, 9),
    (4, 2),
    (4, 3),
    (4, 5),
    (5, 5),
    (1, 1),
    (3, 1),
    (9, 8),
    (6, 10);
    
SELECT * FROM sections_has_students;





-- Week 12

-- Query 1

SELECT fname, lname, DATE_FORMAT(dob, "%M %e, %Y") AS "Sept Birthdays"
FROM students
WHERE MONTH(dob) = 9
ORDER BY lname;

-- Query 2

SELECT lname, fname, FLOOR(DATEDIFF("2017-01-05", dob) / 365) AS "Years", MOD(DATEDIFF("2017-01-05", dob), 365) AS "Days", CONCAT(FLOOR(DATEDIFF("2017-01-05", dob) / 365), " - Yrs, ", MOD(DATEDIFF("2017-01-05", dob), 365), " - Days")
FROM students
ORDER BY DATEDIFF("2017-01-05", dob) DESC;

-- Query 3

SELECT fname, lname
FROM students
	JOIN sections_has_students
    ON students.student_id = sections_has_students.student_id
    JOIN sections
    ON sections_has_students.section_id = sections.section_id
    JOIN faculty
    ON sections.faculty_id = faculty.faculty_id
WHERE faculty_fname = "John" AND faculty_lname = "Jensen"
ORDER BY lname;
