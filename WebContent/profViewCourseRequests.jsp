<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<center>
		<p><img src = "http://www.holidaylga.com/blog/wp-content/uploads/2011/12/Rutgers-R-Logo.jpg" width="100px"></p>
		<h1 style="color:red">Rutgers Special Permission Request System</h1><hr width="80%">
		<h2><%=session.getAttribute("name")%></h2>
	</center>
	
	<!-- <form method = "post" action = "studentRequestFourFiveConnection.jsp">-->
	<%
	
		String x = (String)request.getParameter("radioButton");
	
		String deptNum = (String)session.getAttribute("majorid");
		//System.out.println("DEPT: "+deptNum);
		String courseNum = (String)session.getAttribute("cid");
		String secNum = (String)session.getAttribute("secnum");
		String profID = (String)session.getAttribute("netid");
		//System.out.println(profID);

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
	
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/spnrequest";
		String user = "root";
		String password = "";
		
		String query = "SELECT * FROM requesttest WHERE profid="+"'"+profID+"'";
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, user, password);
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery(); 
	%>
		

		<br>
		<center><input type="submit" value="submit"/></center>

	<table border="1" align="center">
		<tr>
			<td><center>Department</center></td>
			<td><center>Course</center></td>
			<td><center>Section</center></td>
			<td><center>Student</center></td>
		</tr>
		<%
			while(rs.next()){
				String dept = rs.getString("majorid");
				String course = rs.getString("cid");
				String section = rs.getString("secnum");
				String student = rs.getString("netid");
		%>
		<tr>
			<td><center><%=dept%></center></td>
			<td><center><%=course%></center></td>
			<td><center><%=section%></center></td>
			<td><center><%=student%></center></td>
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
	
	
	
	<center>
		<p><a href="profWelcome.jsp">Back to homepage</a></p>
		<p><a href="logout.jsp">Logout</a></p>
	</center>





</body>
</html>