#Complaint Management System

A simple and efficient Complaint Management System built using Java Servlet, JSP, MySQL, and Bootstrap. This system follows the MVC architecture and includes role-based access for Admins and Employees.

📌 Project Overview

This system allows employees to submit complaints and admins to manage them efficiently. It is designed to help organizations track, review, and resolve internal issues.

👥 Roles:

Employee: Can register, log in, submit complaints, update profile, and view their complaint history.

Admin: Can view all complaints from all users, update complaint statuses (Pending → In Progress → Resolved), and delete complaints.

✨ Key Features:

User authentication and registration with validation

Role-based access control

CRUD operations for complaints

Status update (Admin only)

Account/profile management

Responsive UI with Bootstrap

Session handling and logout functionality

Timestamps 


⚙️ Setup and Configuration Guide


🧰 Prerequisites:

Java JDK 21

Apache Tomcat 9+

MySQL 8+

Maven 

📂 Steps:

1.Clone the repository:

2.Database Setup:

Create a database named cms

3.Run the SQL script (schema.sql) provided in the repo to create the required tables

4.Update DBConnection.java with your MySQL username & password

5.Configure Tomcat:

6.Deploy the project in Apache Tomcat (webapps folder)

7.Start the Tomcat server

8.Access the Application:


📁 Project Structure

complaint-management-system/
│
├── src/
│   ├── controller/       # Servlets (Signin, Complaint, Dashboard, etc.)
│   ├── dao/              # Database access layer 
│   ├── model/            # JavaBeans for User, Complain
│   └── db/               # DBConnection (connection pool via DBCP)
│
├── web/
│   ├── view/             # JSP pages (index.jsp, dashboard.jsp, complaint.jsp, etc.)           
│   └── WEB-INF/          # web.xml configuration
│
├── README.md
└── schema.sql


