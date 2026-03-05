Cricket Score Management System (Java & MySQL)
Project Overview
This project is a Cricket Score Management System built using Object-Oriented Programming (OOP) principles in Java. It features a Graphical User Interface (GUI) and a MySQL database to manage match schedules, team squads, player statistics, and real-time score updates.

Note: This is a semester-level academic project. While it covers core match functionalities, it may not include every complex rule of international cricket and is intended for educational purposes.

Core Features & Interfaces
1. Home Dashboard: The landing page displays a general project description alongside a summary of the latest four matches played. Each match includes a "View" button to open complete statistics and detailed performance data.

2. Live Match Interface: A dedicated scoring panel (as shown in the provided image) allows for manual score updates. It includes intuitive buttons for runs (0, 1, 2, 3, 4, 6), wickets (OUT), and extras (WD for Wide, NB for No Ball).

3. Match Schedule: A central location to view all upcoming and previously scheduled matches.

4. Teams & Squads: Detailed views of all participating teams and their full player rosters.

5. Rankings: A dedicated section showing team and player standings based on performance data.

6. Admin Panel: A secure area for authorized users to manage the system. Features include:

Create/Delete Teams: Full control over team entry and removal.

Player Management: Add or update player details and stats.

Team Reports: View specific team statistics, including top run-scorers and leading wicket-takers.

Match Management: Schedule and initialize new matches.

Setup & Database Instructions
To run this project locally, you must first set up the MySQL database:

Install MySQL: Ensure you have MySQL Server and a client (like MySQL Workbench or XAMPP) installed.

Import Schema: Open your MySQL client and execute the provided .sql file included in this repository to create the tables and necessary structure.

Update Configuration: In the Java source code, navigate to the database connection class and update the following:

DB URL: jdbc:mysql://localhost:3306/your_database_name

User: your_mysql_username

Password: your_mysql_password

Admin Credentials
To access the Admin Panel, use the following default credentials:

Username: admin

Password: 12345

Technologies Used
Language: Java (JDK 8)

Database: MySQL

Paradigm: Object-Oriented Programming (Classes, Inheritance, Encapsulation)

GUI Library: Java Swing / AWT
