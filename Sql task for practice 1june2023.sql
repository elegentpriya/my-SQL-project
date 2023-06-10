create database emp;
use emp;
CREATE table Employee (
  Empid INT PRIMARY KEY,
  Empname VARCHAR(20),
  DepartmentId VARCHAR(5),
  Contactno BIGINT(5),
  Emailid VARCHAR(100),
  Empheadid INT
);
INSERT INTO Employee (Empid, Empname, DepartmentId, Contactno, Emailid, Empheadid)
VALUES
  (1, 'John Doe', '101', 1234567890, 'john.doe@yahoo.com', 5),
  (2, 'Jane Smith', '102', 9876543210, 'jane.smith@gmail.com', 4),
  (3, 'Michael Johnson', '103', 5678901234, 'michael.johnson@reddiff.com', 7),
  (4, 'Emily Davis', '101', 9087654321, 'emily.davis@yahoo.com', 5),
  (5, 'David Brown', '104', 3456789012, 'david.brown@gmail.com', 2),
  (6, 'Sarah Wilson', '102', 6789012345, 'sarah.wilson@hotmail.com', 4),
  (7, 'Christopher Lee', '105', 2109876543, 'christopher.lee@gmail.com', 1),
  (8, 'Olivia Taylor', '103', 6543210987, 'olivia.taylor@gmail.com', 7),
  (9, 'Daniel Anderson', '101', 4321098765, 'daniel.anderson@rediff.com', 5),
  (10, 'Sophia Martinez', '104', 8765432109, 'sophia.martinez@gmail.com', 2);

CREATE TABLE EmpDept (
  DeptId INT PRIMARY KEY,
  DeptName VARCHAR(100),
  Dept_off VARCHAR(100),
  DeptHead INT
);
INSERT INTO EmpDept (DeptId, DeptName, Dept_off, DeptHead)
VALUES
  (101, 'Sales', 'Saturday', 5),
  (102, 'Marketing', 'Sunday', 4),
  (103, 'Finance', 'Monday', 7),
  (104, 'Engineering', 'Tuesday', 2),
  (105, 'Human Resources', 'Wednesday', 1),
  (106, 'Operations', 'Thursday', 3),
  (107, 'Research and Development', 'Friday', 6),
  (108, 'Customer Service', 'Saturday', 9),
  (109, 'IT', 'Sunday', 8),
  (110, 'Administration', 'Monday', 10);

  CREATE TABLE EmpSalary (
  EmpId INT PRIMARY KEY,
  Salary DECIMAL(10, 2),
  IsPermanent varchar(10)
);
INSERT INTO EmpSalary (EmpId, Salary, IsPermanent)
VALUES
  (1, 5000, 'yes'),
  (2, 6000, 'yes'),
  (3, 7000, 'yes'),
  (4, 5500, 'yes'),
  (5, 8000, 'yes'),
  (6, 6500, 'yes'),
  (7, 7500, 'yes'),
  (8, 7000, 'yes'),
  (9, 5200, 'yes'),
  (10, 7800, 'yes');

  CREATE TABLE Project (
  ProjectId INT PRIMARY KEY,
  Duration INT
);
INSERT INTO Project (ProjectId, Duration)
VALUES
 (1, 12),(2, 8),(3, 6),(4, 10),(5, 16),(6, 14),(7, 9),(8, 7),(9, 11),(10, 13);
CREATE TABLE Country (
  cid INT PRIMARY KEY,
  cname VARCHAR(40)
);
INSERT INTO Country (cid, cname)
VALUES
  (1, 'United States'),
  (2, 'Canada'),
  (3, 'United Kingdom'),
  (4, 'Germany'),
  (5, 'France'),
  (6, 'Australia'),
  (7, 'Japan'),
  (8, 'India'),
  (9, 'Brazil'),
  (10, 'China');

CREATE TABLE Client (
  ClientId INT PRIMARY KEY,
  Clientname VARCHAR(50),
  Cid INT,
  FOREIGN KEY (Cid) REFERENCES Country(Cid)
);
INSERT INTO Client (ClientId, Clientname, Cid)
VALUES
  (1, 'ABC Company', 3),
  (2, 'XYZ Corporation', 4),
  (3, '123 Industries', 2),
  (4, 'Acme Corporation', 1),
  (5, 'Global Enterprises', 5),
  (6, 'Innovative Solutions', 8),
  (7, 'Tech Solutions Ltd.', 7),
  (8, 'Maxim Enterprises', 6),
  (9, 'Prime Systems', 9),
  (10, 'PowerTech Inc.', 10);

CREATE TABLE EmpProject (
  EmpId INT,
  ProjectId INT,
  ClientID INT,
  StartYear INT,
  EndYear INT,
  FOREIGN KEY (EmpId) REFERENCES Employee(empid),
  FOREIGN KEY (ProjectId) REFERENCES Project(projectId),
  FOREIGN KEY (ClientID) REFERENCES Client(clientId)
);
INSERT INTO EmpProject (EmpId, ProjectId, ClientID, StartYear, EndYear)
VALUES
  (1, 1, 1, 2020, 2022),
  (2, 2, 2, 2021, 2023),
  (3, 3, 3, 2019, 2022),
  (4, 4, 4, 2020, 2021),
  (5, 5, 5, 2021, 2023),
  (6, 6, 6, 2018, 2020),
  (7, 7, 7, 2019, 2021),
  (8, 8, 8, 2020, 2021),
  (9, 9, 9, 2019, 2022),
  (10, 10, 10, 2021, 2023);

---  8)Select the detail of the employee whose name start with p
select * from employee
where empname like 'p%';
--- 9)How many permanent employee take salary more than 5000.
select count(*)
from empsalary
where IsPermanent = yes and salary > 5000;
--- 10)Select the detail of employee whose emailId is in gmail.
select * from employee
 where emailId like'%gmail.com';
--- 11)Select the details of the employee who work either for department 104 or 102.
select * from employee
where DepartmentId in ('104','102');
--- 12)What is the department name for DeptID 102?
select Deptname from EmpDept
where DeptId = 102;
--- 13) What is total salary that is paid to permanent employees? 
select sum(salary)
from EmpSalary
where IsPermanent = 'yes';
--- 14) List name of all employees whose name ends with a. 
select Empname
from Employee
where Empname Like '%a';
--- 15) List the number of department of employees in each project. 
select EmpProject.ProjectId, COUNT(Employee.DepartmentId) as NumberOfDepartments
from EmpProject
join Employee on Employee.EmpId = EmpProject.EmpId
group by EmpProject.ProjectId;

--- 16) How many project started in year 2010.
select count(*)
from EmpProject 
where startyear = 2010; 
--- 17) How many project started and finished in the same year.
select count(*)
from EmpProject
where startyear = endyear;
 
--- 18) Select the name of the employee whose name's 3rd character is 
--- 'h. 
select Empname
from Employee
Where Substring(Empname,3,1) = 'h';
--- 19) Select the department name of the company which is assigned to 
--- the employee whose employee id is grater 103.
select EmpDept.DeptName
from Employee
join EmpDept on Employee.DepartmentId = EmpDept.DeptId
where Employee.Empid > 103; 
--- 20) Select the name of the employee who is working under Abhishek.
select Employee.Empname
from Employee
join Employee as Manager on Employee.Empheadid = Manager.Empid
Where Manager.Empname ='Abhishek'; 
--- 21) Select the name of the employee who is department head of HR. 
select Employee.Empname
from Employee
join EmpDept on Employee.DepartmentId = EmpDept.DeptId
where EmpDept.DeptName = 'HR' and Employee.Empid = EmpDept.DeptHead;
--- 22) Select the name and email of the Dept Head who is not 
--- Permanent. 
select Employee.Empname, Employee.Emailid
from Employee
join EmpDept on Employee.Empid = EmpDept.DeptHead
join Empsalary on Employee.Empid = EmpSalary.EmpId
where EmpSalary.IsPermanent = 'no';
--- 23) Select the employee whose department off is Monday.
select Employee.*
from Employee
join EmpDept on Employee.DepartmentId = EmpDept.DeptId
where EmpDept.Dept_off = 'Monday'; 
--- 24) Select the Indian clients details.
select Client.*
from Client
join Country on Client.Cid = Country.cid
where Country.cname = 'India'; 
--- 25) select the details of all employee working in development 
--- department.
select Employee.*
from Employee
join EmpDept on Employee.DepartmentId = EmpDept.DeptId
where EmpDept.DeptName = 'Development';
