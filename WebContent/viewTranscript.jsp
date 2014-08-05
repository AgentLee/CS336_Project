<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Rutgers Special Permission System | Check Status</title>
</head>
<body>
	<!-- Student chooses section -->
	<%=session.getAttribute("netid")%>
	<%=session.getAttribute("ruid")%>
	
	<center>
		<p><img src = "http://www.holidaylga.com/blog/wp-content/uploads/2011/12/Rutgers-R-Logo.jpg" width="100px"></p>
		<h1 style="color:red">Rutgers Special Permission Request System</h1><hr width="80%">
		<h2><%=session.getAttribute("name")%></h2>
		<h3>SPN Requests</h3>
	</center>	
	
	<form method = "post" action = "studentDeleteConnection.jsp">
	<%
		String deptNum = (String)session.getAttribute("majorid");
		String courseNum = (String)session.getAttribute("cid");
		String profid = (String)session.getAttribute("netid");
	%>
		
	<%	
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
	
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/spnrequest";
		String user = "root";
		String password = "";
		//System.out.println(userNetID);
		String sql = "SELECT t.ruid, t.majorid, t.cid, t.grade, t.semesterid, t.year, s.name FROM transcript t, students s WHERE s.ruid=t.ruid";
	%>

	<%		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, user, password);
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery(); 
	%>	

	<table border="1" align="center">
		<tr>
			<td><center>Name</center></td>
			<td><center>Student ID</center></td>
			<td><center>Department</center></td>
			<td><center>Course</center></td>
			<td><center>Grade</center></td>
			<td><center>Semester|Year</center></td>
		</tr>
		<%
			while(rs.next()){
				String name = rs.getString("name");
				String student = rs.getString("ruid");
				String dept = rs.getString("majorid");
				String course = rs.getString("cid");
				String grade = rs.getString("grade");
				String semester = rs.getString("semesterid");
				String year = rs.getString("year");
		%>
		<tr>
			<td><center><%=name %></center>
			<td><center><%=student%></center>
			<td><center><%=dept%></center></td>
			<td><center><%=course%></center></td>
			<td><center><%=grade%></center></td>
			<td><center><%=semester%><%=year%></center></td>
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
	<center>
		<p><a href="studentWelcome.jsp">Back to homepage</a></p>
		<p><a href="logout.jsp">Logout</a></p>
	</center>
</body>
</html>