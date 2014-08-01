<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome Student!</title>
</head>
<body>
	
	<!-- Landing page for students -->

	<%	
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
	
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/spnrequest";
		String user = "root";
		String password = "";
	%>

	<center>
		<p><img src = "http://www.holidaylga.com/blog/wp-content/uploads/2011/12/Rutgers-R-Logo.jpg" width="100px"></p>
		<h1 style="color:red">Rutgers Special Permission Request System</h1><hr width="80%">
		<h2>Welcome <%=session.getAttribute("name")%>!</h2>
	</center>

	<form method="post" action="studentRequestOne.jsp">
  		<center><input type="submit" value="Request new spn"></center>
	</form>
	
	<form method="post" action="studentCheckOne.jsp">
  		<center><input type="submit" value="Check Status"></center>
	</form>
	
	<center><p><a href="logout.jsp">Logout</a></p></center>
</body>
</html>
