<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Rutgers Special Permission System</title>
</head>
<body>
	
	<!-- Student gets to choose section -->
	
	<center>
		<p><img src = "http://www.holidaylga.com/blog/wp-content/uploads/2011/12/Rutgers-R-Logo.jpg" width="100px"></p>
		<h1 style="color:red">Rutgers Special Permission Request System</h1><hr width="80%">
		<h2><%=session.getAttribute("name")%></h2>
	</center>
	
	<form method = "post" action = "studentRequestThreeFourConnection.jsp">
	<%
		String deptNum = (String)session.getAttribute("majorid");
		//System.out.println("DEPT: "+deptNum);		
		String courseNum = (String)session.getAttribute("cid");
	%>
		
	<%	
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
	
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/spnrequest";
		String user = "root";
		String password = "";
		
		String sql = "SELECT secnum,year,semesterid FROM courses WHERE cid="+courseNum;
	%>

	<%		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, user, password);
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery(); 
	%>	

	<!-- might want to change the format of the sections -->
	
	
	<!-- I like this format but need to figure out how to send data to connector -->
		<table border="1" align="center">
			<%
				while(rs.next()){
					String secnum = rs.getString("secnum");
					String yr = rs.getString("year");
					String semester = rs.getString("semesterid");
			%>
					<tr>
					<td><input type="radio" name="secnum" value=<%=secnum%>><%=session.getAttribute("majorid")%> : <%=session.getAttribute("cid")%>:</td>
					<td><%=secnum%></td><td><%=yr%></td><td><%=semester%></td>
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
	<center>
		<p><a href="studentWelcome.jsp">Back to homepage</a></p>
		<p><a href="logout.jsp">Logout</a></p>
	</center>
</body>
</html>
