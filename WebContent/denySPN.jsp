<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>	
	<%
		//Getting information from spnDecision
		String studentNetID = (String)session.getAttribute("studentNetID");
		String dept = (String)session.getAttribute("dept");
		String cid = (String)session.getAttribute("cid");
		String secnum = (String)session.getAttribute("secnum");
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/spnrequest";
		String user = "root";
		String password = "";

		Class.forName(driverName);
		conn = DriverManager.getConnection(url, user, password);
		
		Statement statement = conn.createStatement();
        	
		String query = "UPDATE requesttest set status='Denied' WHERE netid='"+studentNetID+"' AND majorid='"+dept+"' AND cid='"+cid+"' AND secnum='"+secnum+"'";
		String queryTwo = "UPDATE requesttest set response='-' WHERE netid='"+studentNetID+"' AND majorid='"+dept+"' AND cid='"+cid+"' AND secnum='"+secnum+"'";
		
		statement.executeUpdate(query);
		statement.executeUpdate(queryTwo);

		getServletContext().getRequestDispatcher("/profViewCourses.jsp").include(request, response);
	%>
	
	<center><h3 style="color:red">SPN Denied!</h3></center>
</body>
</html>