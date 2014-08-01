<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Rutgers Special Permission Request System</title>
</head>
<body>
		
	<!-- First page to login -->	
		
	<%
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/spnrequest";
		String user = "root";
		String password = "";

		String sql = "select usertype from users";

		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery(); 
	%>

	<center>
		<p><img src = "http://www.holidaylga.com/blog/wp-content/uploads/2011/12/Rutgers-R-Logo.jpg" width="100px"></p>
		<h1 style="color:red">Rutgers Special Permission Request System</h1><hr width="80%">
		<h2>Welcome!</h2>
	</center>

	<form method="post" action="login.jsp">
		<table style="border:none" align="center">
			<tr>
				<td>NetID:</td>
				<td><input type="text" name="netid"/></td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input type="password" name="password"/></td>
			</tr>
	<% 
		} catch(SQLException sqe){
			out.println("index"+sqe);
		}
	%>
		</table>	
		<center><p><input type="submit" value="submit"/></p></center>
	</form>
</body>
</html>