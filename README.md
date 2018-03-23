# sentdecoder

sentdecoder is a real time twitter based sentiment analysis engine built using java. This engine can fetch tweets based on 
user query and run several types of analysis on them. The results of the analysis are displayed using Chartjs charts to make 
them visually promising.

### Features of the Application

* Live Dashboard for sentiment analysis.
* Stream or non stream type analysis.
* Generating report of any type of analysis.
* Option to do zonal analysis/predicting sentiment of a country.
* History of all analysis done.
* User account management.
* Stunning visualizations for the sentiment results obtained.
* Geoplotting feature in case of zonal analysis.

### Upcoming updates
* Option to choose more than one source for fetching user reviews. (Currently only fetching Twitter).
* Stream plotting at near real time (no delay).

### Workflow Step by Step
1. User logs in to the system.
2. Open any one of the four analysis options.
3. Types the query and starts the analysis.
4. System calls the Python scripts underneath to do the analysis work.
5. Analysis completes in 20 seconds and reults are returned to the web application.
6. Results are plotted in the graphs.
7. User can do any other analysis or generate report of the results.

### Steps to set up the project
#### Software Requirement
1. Java 1.7+
2. Eclipse for Java EE developers
3. Apache Tomcat 8.0+
4. Python (Anaconda distribution)
5. Chartjs
6. jsPDF
7. MySql Server

#### Setting up Eclipse
1. Add the Tomcat server to eclipse.
2. Add the JRE system library to eclipse.

#### Installing Python libraries
1. ```pip install -r requirements.txt``` (File provided in the repository)

#### Setting up MySql database
1. Create a new user in MySql.
2. Create a new database for the user.
3. Create table Users in that database with the following specification:

Field     | Type            | NULL     | Key         | Extra
--------- | --------------- | -------- |------------ | --------------
user_id   | int(6) unsigned | NOT NULL | PRIMARY KEY | AUTO_INCREMENT
firstname | varchar(30)     | NOT NULL | NIL         | NIL 
lastname  | varchar(30)     | NOT NULL | NIL         | NIL
company   | varchar(30)     | NULLABLE | NIL         | NIL
email     | varchar(50)     | NOT NULL | UNIQUE      | NIL
passwd    | varchar(50)     | NOT NULL | NIL         | NIL

#### Editing the project
1. Import the project in eclipse.
2. If importing doesn't work then create a project with the same name and copy all files.
3. Edit the Path.java file (Add your own paths to files).
4. Edit the DatabaseConnection.java file and change the database link with your own.
5. Save everything and run the application.

#### Using the application
1. Create a new account/Log In to your account.
2. Open Guide page for instructions.
3. Use the application accordingly.
