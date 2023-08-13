# my-SQL-project
Basic Library Management System
This project involves the creation of a basic library management system database. The database schema consists of tables for managing information related to library branches, employees, customers, book issues, book returns, and books. The SQL queries provided showcase various functionalities of the library management system, including data retrieval, analysis, and reporting.

Database Schema:
The database is structured with the following tables:

Branch: Stores information about library branches, including branch number, manager ID, branch address, and contact number.

Employee: Contains details of library employees, such as employee ID, name, position, and salary.

Customer: Stores customer information, including customer ID, name, address, and registration date.

IssueStatus: Manages issued books, recording issue ID, customer ID, book name, issue date, and ISBN.

ReturnState: Records book returns, including return ID, customer ID, returned book name, return date, and ISBN.

Books: Stores book details, such as ISBN, title, category, rental price, status, author, and publisher.

SQL Queries:
Retrieve Available Books:

Query: SELECT Book_title, Category, Rental_price FROM Books WHERE Status = 'Yes';
List Employee Salaries:

Query: SELECT Emp_name, Salary FROM Employee ORDER BY Salary DESC;
Retrieve Issued Books and Customers:

Query: SELECT b.Book_title, c.Customer_name FROM IssueStatus i JOIN Books b ON i.Isbn_book = b.ISBN JOIN Customer c ON i.Issued_cust = c.Customer_Id;
Count Books in Each Category:

Query: SELECT Category, COUNT(*) AS book_count FROM Books GROUP BY Category;
Employees with High Salaries:

Query: SELECT Emp_name, Position FROM Employee WHERE Salary > 50000;
Customers Registered Before 2022-01-01 with No Issued Books:

Query: SELECT Customer_name FROM Customer WHERE Reg_date < '2022-01-01' AND Customer_id NOT IN (SELECT Issued_cust FROM IssueStatus);
Total Employees per Branch:

Query: SELECT b.Branch_no, COUNT(*) AS Total_count FROM Employee e JOIN Branch b ON e.Emp_id = b.Manager_id GROUP BY b.Branch_no;
Customers Issuing Books in June 2023:

Query: SELECT c.Customer_name FROM Customer c JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust WHERE MONTH(i.Issue_date) = 6 AND YEAR(i.Issue_date) = 2023;
Retrieve History Books:

Query: SELECT Book_title FROM Books WHERE Category = 'history';
Branches with More than 5 Employees:

Query: SELECT b.Branch_no, COUNT(*) AS Employee_count FROM Employee e JOIN Branch b ON e.Emp_id = b.Manager_id GROUP BY b.Branch_no HAVING Employee_Count > 5;
