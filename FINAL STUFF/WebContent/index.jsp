<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Rutgers Special Permission System</title>
</head>
<body>
	<!--First Page - People have the option to make an account or login-->
	
	<div class="header">
		<center>
			<p><img src = "http://www.holidaylga.com/blog/wp-content/uploads/2011/12/Rutgers-R-Logo.jpg" width="100px"></p>
			<h1 style="color:red">Rutgers Special Permission Request System</h1><hr width="80%">
			<h2>Please login</h2>
		</center>
	</div>		
	
	<%	
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		//Change this for submission
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/newspnsystem";
		String user = "root";
		String password = "";

		String sql = "SELECT usertype FROM usertypeid";

		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery(); 
	%>
	
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
			<tr>
				<td></td>
			</tr>
		</table>	
		<center>
			<p>
			<a href="signupIndex.jsp">Need an account? Sign up here!</a>
			<br>
			<br>
			<input type="submit" value="submit"/>
			<br>
			</p>
		</center>
	</form>	
</body>
</html>