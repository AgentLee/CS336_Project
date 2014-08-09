<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Rutgers Special Permission System | View Courses</title>
</head>
<body>
	<!-- Professor views the courses they teach -->
	
	<%=session.getAttribute("netid")%>
	<%=session.getAttribute("ruid")%>
	
	<!-- H E A D E R -->
	<center>
		<p><img src = "http://www.holidaylga.com/blog/wp-content/uploads/2011/12/Rutgers-R-Logo.jpg" width="100px"></p>
		<h1 style="color:red">Rutgers Special Permission Request System</h1><hr width="80%">
		<h2><%=session.getAttribute("name")%></h2>
		<h3>Your Courses</h3>
	</center>	
	
	<form method="post" action="profViewCourseRequests.jsp">
	<%
		String deptNum = (String)session.getAttribute("majorid");
		String courseNum = (String)session.getAttribute("cid");
		String profid = (String)session.getAttribute("netid");
	
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
	
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/spnrequest";
		String user = "root";
		String password = "";
		String sql = "SELECT * FROM requestTest WHERE profid='"+profid+"'";

		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, user, password);
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery(); 
	%>	

	<table border="1" align="center">
		<tr>
			<td><center>Department:Course:Section</center></td>
			<td><center>View Request</center></td>
		</tr>
		<%
			while(rs.next()){
				String dept = rs.getString("majorid");
				String course = rs.getString("cid");
				String section = rs.getString("secnum");
		%>
		
		<tr>
			<td><center><%=dept%>:<%=course%>:<%=section%></center></td>
			<td><center><input type="radio" value="<%=dept%>:<%=course%>:<%=section%>" name="radioButton"></center></td>
		</tr>

		<%		
			}
		%>

	</table>
	
	<% 
		}catch(SQLException sqe){
			out.println("index"+sqe);
		}
	%>
	
		<br>	
		<center><input type="submit" value="submit"/></center>
	</form>
	
	<!-- F O O T E R -->
	<center> 
		<p><a href="profWelcome.jsp">Back to homepage</a></p>
		<p><a href="logout.jsp">Logout</a></p>
	</center>
</body>
</html>