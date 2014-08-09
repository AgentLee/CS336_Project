<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.util.Random" %>
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
		
		//Creates random 5 digit number for SPN
		Random r = new Random( System.currentTimeMillis() );
		String spn = Integer.toString(10000 + r.nextInt(20000));
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/spnrequest";
		String user = "root";
		String password = "";

		Class.forName(driverName);
		conn = DriverManager.getConnection(url, user, password);
		
		//need check for spn
		
		Statement statement = conn.createStatement();
        	
		String query = "UPDATE requesttest set response='"+spn+"' WHERE netid='"+studentNetID+"' AND majorid='"+dept+"' AND cid='"+cid+"' AND secnum='"+secnum+"'";
		String queryTwo = "UPDATE requesttest set status='Approved' WHERE netid='"+studentNetID+"' AND majorid='"+dept+"' AND cid='"+cid+"' AND secnum='"+secnum+"'";
		
		statement.executeUpdate(query);
		statement.executeUpdate(queryTwo);
		
		response.sendRedirect("grantSPN.jsp");
	%>
	
	<center><p style="color:red">Error processing request</p></center>

</body>
</html>