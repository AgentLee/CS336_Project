<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome Professor!</title>

<style>
	.nav ul {
		list-style-type: none;
	}
	.nav li {
		margin: 5px;
		display: inline-block;
	}
</style>
</head>
<body>
	<!-- Landing page for students -->
	<%=session.getAttribute("netid") %>
	<%=session.getAttribute("ruid") %>
	
	<center>
		<p><img src = "http://www.holidaylga.com/blog/wp-content/uploads/2011/12/Rutgers-R-Logo.jpg" width="100px"></p>
		<h1 style="color:red">Rutgers Special Permission Request System</h1><hr width="80%">
		<h2>Welcome <%=session.getAttribute("name")%>!</h2>
	</center>
	
	

	<form method="post" action="studentRequestOne.jsp">
  		<center><input type="submit" value="View Courses"></center>
	</form>	
	<center><p><a href="logout.jsp">Logout</a></p></center>
</body>
</html>
