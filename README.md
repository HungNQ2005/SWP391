Movie Website Online – MVC Java Project

A simple and functional online movie streaming website built using the MVC architecture with Java, HTML, JavaScript, and Bootstrap.
The platform allows users to browse movies, search, view details, register, log in, and manage their personal accounts.
Movie Browsing

View a list of available movies

See movie details including title, description, category, duration, thumbnail, and trailer URL

Movie Search

Search movies by keyword

Supports partial matching

User Management

Register a new account

Login and authenticate users

Basic validation (unique username/email, password rules)

Movie Playback (Demo)

Open streaming URL (if provided)

Controlled through a view page
Architecture

This project follows the Model–View–Controller (MVC) pattern:

Model

Java classes representing data (Movie, User, Category, etc.)

Handles business rules and data validation

View

HTML pages with Bootstrap for layout

JavaScript for client-side interaction

JSP (if used) for dynamic content rendering

Controller

Java Servlets controlling request flow

Communicates with services and repositories

Handles user actions (login, search, view movies)

Backend      :Java, Servlet/JSP, JDBC            
Frontend     :HTML5, CSS3, JavaScript, Bootstrap 
Database     :SQL server (or your SQL engine)         
Architecture : MVC (Model–View–Controller)        
Server       :Apache Tomcat                      
