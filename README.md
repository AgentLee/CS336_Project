CS336_Project
=============

Special Permission Number System

Overview of the JSP pages
=========================

* = page needs work

index.jsp - login page
login.jsp - validates netid/password with the databse

xxxxConnection.jsp transfers query information from previous page to next page

--------
Students
--------
studentWelcome.jsp - student landing page...choose request new spn or check spn status
	---------------
	New SPN Request
	---------------
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
		* Text box needs work
		* Request Table does not work (I made my own table to test) 
		* Inserting is not yet implemented

	studentRequestFive.jsp
		- Redirects student to status page

	------------
	Check status
	------------
	studentCheckOne.jsp 
		- Student checks status of SPNs

