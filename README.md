CS336_Project
=============


************* THINGS THAT NEED TO BE WORKED ON *************
	---
	SQL 
	---
		- Triggers/Transcript/Prereq/Requests
	
	--------
	STUDENTS
	--------
		- Inserting into request, find way to get profid (probably by execuitng another sql code)
	
	----------
	PROFESSORS
	----------
		- Transcript
			- Sort by semester
			- Button to view transcript (the courseinfo string prevents this)
		- Granting SPN
			- Should be like studentRequestFourFiveConenection
		- Denying SPN
		
	-----	
	ADMIN
	-----
		- EVERYTHING


Special Permission Number System

Overview of the JSP pages
=========================

	* = page needs work

	xxxxConnection.jsp transfers query information from previous page to next page

-----
Login
-----
	index.jsp - login page
	login.jsp - validates netid/password with the database
	error.jsp - redirects bad links/bad data 

--------
Students
--------
	studentWelcome.jsp - student landing page...choose request new spn or check spn status
		---------------
		New SPN Request
		---------------
		* Need to make sure it only shows the current semester
			- The administrator should have this job

		studentRequestOne.jsp 	
			- Picks the department

		studentRequestTwo.jsp 	
			- Picks the course

		studentRequestThree.jsp 
			- Picks the section 
			- User can change the section or course entirely
			- Currently only does one section at a time

		studentRequestFour.jsp 	
			- Student explains why they need the SPN
			* Request Table does not work (I made my own table to test) 

		studentRequestFive.jsp
			- Redirects student to status page

		------------
		Check status
		------------
		studentCheckOne.jsp 
			- Student checks status of SPNs
			- Student can delete a request if they want

----------
Professors
----------
	profWelcome.jsp - professor landing page...checks their courses and spns
	



