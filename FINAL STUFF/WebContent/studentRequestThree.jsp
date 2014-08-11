<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Choose Section</title>
</head>	
<body>
	<!-- New SPN Request -->
	<!-- Student chooses Section -->
	
	<div class="header">	
		<center>
			<p><img src = "http://www.holidaylga.com/blog/wp-content/uploads/2011/12/Rutgers-R-Logo.jpg" width="100px"></p>
			<h1 style="color:red">Rutgers Special Permission Request System</h1><hr width="80%">
			<h2><%=session.getAttribute("name")%></h2>
		</center>
	</div>
	
	<%
		String selectedMajorID = (String)session.getAttribute("majorid");
		String selectedCID = (String)session.getAttribute("cid");
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
	
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/newspnsystem";
		String user = "root";
		String password = "";
		
		String query = "SELECT * FROM courses WHERE cid="+selectedCID;
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, user, password);
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery(); 
	%>
	
	<form method = "post" action = "studentRequestThreeFourConnection.jsp">
		<table border="1" align="center">
			<%
				while(rs.next()){
					String secnum = rs.getString("secnum");
					String yr = rs.getString("year");
					String semester = rs.getString("semesterid");
			%>
			<tr>
				<td><input type="radio" name="secnum" value=<%=secnum%>><%=session.getAttribute("majorid")%> : <%=session.getAttribute("cid")%>: </td>
				<td><%=secnum%></td>
				<td><%=semester%> <%=yr%></td>
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
		<center><input type="submit" value="next"/></center>
	</form>
	
	<div class="footer">
		<center>
			<p>
				<a href="studentRequestOne.jsp">Select another department </a>|
				<a href="studentRequestOne.jsp">Select another course </a>
				<br>
				<a href="studentWelcome.jsp">Back to homepage </a>|
				<a href="logout.jsp">Logout</a>
			</p>
		</center>	
	</div>
	
</body>
</html>