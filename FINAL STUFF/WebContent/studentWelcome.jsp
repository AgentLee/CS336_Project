<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Welcome Student!</title>
</head>
<body>
	<!-- 
		If the user is a student, they will be redirected to this page.
		This page allows students to request a new SPN or check on their previous SPN statuses
	 -->
	
	<%-- These are to get the information of the students from the login validation page --%>
	<%-- netid and ruid refer to if the student logged in directly from the index --%>
	<%-- accountNetid, accountRuid, accountName refer to users who just made an account --%>
	<%--
		<%=session.getAttribute("netid") %>
		<%=session.getAttribute("ruid") %>
		<%=session.getAttribute("accountNetid") %>
		<%=session.getAttribute("accountRuid") %>
		<%=session.getAttribute("accountName") %>
	--%>
	
	<div class="header">
		<center>
			<p><img src = "http://www.holidaylga.com/blog/wp-content/uploads/2011/12/Rutgers-R-Logo.jpg" width="100px"></p>
			<h1 style="color:red">Rutgers Special Permission Request System</h1><hr width="80%">
			<h2>Welcome <%=session.getAttribute("name")%>!</h2>
		</center>
	</div>
	 
	<form method="post" action="studentRequestOne.jsp">
  		<center><input type="submit" value="Request new spn"></center>
	</form>
	
	<form method="post" action="studentCheckOne.jsp">
  		<center><input type="submit" value="Check Status"></center>
	</form>
	
	<center><p><a href="logout.jsp">Logout</a></p></center> 
</body>
</html>