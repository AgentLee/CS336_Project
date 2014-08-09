<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Rutgers Special Permission Request System | SPN Granted</title>
</head>
<body>
	<% 
		getServletContext().getRequestDispatcher("/profViewCourses.jsp").include(request, response);
	%>
	
	<center><h3 style="color:red">SPN Approved!</h3></center>

</body>
</html>