create database library;

use library;

create table Branch(Branch_no int primary key,Manager_id int,
Branch_address varchar(50),Contact_no int);

insert into Branch(Branch_no,Manager_id,Branch_address,Contact_no)
values
(1,101,'nager street,kannur',123456),
(2,102,'baba road,calicat',34562),
(3,103,'puthanparambil road,kochi',98765),
(4,104,'gangabai road,pala',67543),
(5,105,'mulasseriyilpadi,kollam',98067);

create table Employee(Emp_id int primary key,Emp_name varchar(50),
Position varchar(20),salary decimal(10,2));

insert into Employee(Emp_id,Emp_name,position,salary)
values
(101,'Tarun','incharge',5000),
(102,'Abilash','Manager',15000),
(103,'Manna','Accountant',14000),
(104,'Adrith','cashier',10000),
(105,'Anup','security',4000);

create table Customer(Customer_id int primary key,Customer_name varchar(30),
Customer_address varchar(50),Reg_date date);

insert into Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
values
(1, 'Santhosh', '123street', '2023-01-01'),
(2, 'Akila', '45 puram', '2023-02-01'),
(3, 'Purusothaman', 'second street', '2023-03-01'),
(4, 'Govind', 'first level street', '2023-04-01'),
(5, 'Kiran', 'puthuparambil', '2023-05-01');

create table IssueStatus(Issue_id int primary key,Issued_cust int,
Issued_book_name varchar(100),Issue_date date,ISBN_book varchar(20),
foreign key(Issued_cust)references Customer(Customer_id),
foreign key(ISBN_book)references Books(ISBN));

insert into IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
values
(1, 1, 'kids story', '2023-01-01', 'ISBN1'),
(2, 2, 'Aladdin and magical lamp', '2023-02-01', 'ISBN2'),
(3, 3, 'The discovery', '2023-03-01', 'ISBN3'),
(4, 4, 'Macbeth', '2023-04-01', 'ISBN4'),
(5, 5, 'fire of wings', '2023-05-01', 'ISBN5');


create table ReturnState(Return_id int primary key,
Return_cust int,Return_book_name varchar(100),
Return_date date,ISBN_book2 varchar(20),
foreign key(Return_cust)references Customer(Customer_id),
foreign key(ISBN_book2)references Books(ISBN));
insert into ReturnState(Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
values
(1, 1, 'kids story', '2023-01-10', 'ISBN1'),
(2, 2, 'Aladdin and magical lamp', '2023-02-15', 'ISBN2'),
(3, 3, 'The discovery', '2023-03-20', 'ISBN3'),
(4, 4, 'Macbeth', '2023-04-25', 'ISBN4'),
(5, 5, 'fire of wings', '2023-05-30', 'ISBN5');



create table Books(ISBN varchar(20)primary key,
Book_title varchar(100),Category Varchar(50),Rental_price decimal(10,2),
Status enum('Yes','No'),Author varchar(100),Publisher varchar(100));

insert into Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
values
('ISBN1', 'kids story', 'kidsbook', 10.99, 'yes', 'kiran varma', 'AKV Publisher'),
('ISBN2', 'Aladdin and magical lamp', 'kidsbooks', 12.99, 'yes', 'strvin jose', 'kids Publisher'),
('ISBN3', 'The discovery', 'History', 8.99, 'no', 'Vikram sath', 'V&V publisher'),
('ISBN4', 'Macbeth', 'Noval', 9.99, 'yes', 'shakaspere', 'XVZ Publisher'),
('ISBN5', 'fire of wings', 'Autobiograpy', 11.99, 'no', 'kavitha koshi', 'j&j Publisher');

/*Write the queries for the following:
1. Retrieve the book title, category, and rental price of all available
books.*/
select Book_title,Category,Rental_price from Books where Status = 'Yes';

/*2. List the employee names and their respective salaries in descending
order of salary.*/
select Emp_name,Salary from Employee order by Salary desc;

/*3. Retrieve the book titles and the corresponding customers who have
issued those books.*/
select b.Book_title, c.Customer_name
from IssueStatus i
join Books b on i.Isbn_book = b.ISBN
join Customer c on i.Issued_cust = c.Customer_Id;

/*4. Display the total count of books in each category.*/
select category, count(*) as book_count
from Books
group by Category;

/*5. Retrieve the employee names and their positions for the employees
whose salaries are above Rs.50,000.*/
select Emp_name,position from Employee
where Salary > 50000;

/*6. List the customer names who registered before 2022-01-01 and have
not issued any books yet.*/
select Customer_name from Customer
where Reg_date<'2022-01-01'
and Customer_id not in (select Issued_cust from IssueStatus); 


/*7. Display the branch numbers and the total count of employees in each
branch.*/
select b.Branch_no,count(*) as Total_count
from Employee e
join Branch b on e.Emp_id =b.Manager_id
group by b.Branch_no;

/*8. Display the names of customers who have issued books in the month
of June 2023.*/
select c.Customer_name 
from Customer c 
join IssueStatus i on c.Customer_Id = i.Issued_cust
where month(i.Issue_date) =6 and year(i.Issue_date) =2023; 

/*9. Retrieve book_title from book table containing history.*/
select Book_title
from Books
where Category = 'history';

/*10.Retrieve the branch numbers along with the count of employees for
branches having more than 5 employees.*/
select b.Branch_no,count(*)as Employee_count
from Employee e
join Branch b on e.Emp_id = b.Manager_id
group by b.Branch_no
Having Employee_Count > 5;


 

