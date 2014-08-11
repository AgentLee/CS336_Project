<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SPN Status</title>
</head>
<body>
	<div class="header">
		<center>
			<p><img src = "http://www.holidaylga.com/blog/wp-content/uploads/2011/12/Rutgers-R-Logo.jpg" width="100px"></p>
			<h1 style="color:red">Rutgers Special Permission Request System</h1><hr width="80%">
			<h2><%=session.getAttribute("name")%></h2>
			<h3>SPN Request Status</h3>
		</center>	
	</div>
	
	<%
		String userRUID = (String)session.getAttribute("ruid");
	
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
	
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/newspnsystem";
		String user = "root";
		String password = "";
		
		String query = "SELECT * FROM request r WHERE ruid='"+userRUID+"'";
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, user, password);
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery(); 
		%>	
		<form method="post" action="studentDeleteOneConnection.jsp">
			<table border="1" align="center">
				<tr>
					<td><center>Department : Course : Section</center></td>
					<td><center>Status</center></td>
					<td><center>SPN</center></td>
					<td><center>Message</center></td>
					<td><center>Cancel Request</center></td>
				</tr>
			<%
				while(rs.next()){
					String dept = rs.getString("majorid");
					String course = rs.getString("cid");
					String section = rs.getString("secnum");
					String status = rs.getString("status");
					String spn = rs.getString("response");
					String message = rs.getString("message");
					
					if(spn == null){
						spn = "-";
					}
					
					if(message == null){
						message = "Will respond within 7 days";
					}
					
					if(status.equals("Canceled")){
						continue;
					}
			%>
				<tr>
					<td><center><%=dept%> : <%=course%> : <%=section%></center></td>
					<td><center><i><%=status%></i></center></td>
					<td><center><%=spn%></center></td>
					<td><center><%=message%></center></td>
					<td><center><input type="radio" value="<%=dept%>:<%=course%>:<%=section%>" name="radioButton"></center></td>
				</tr>
			<%		
				}
		
			}catch(SQLException sqe){
				out.println("index"+sqe);
			}
			%>

			</table>
			<br>	
			<center><input type="submit" value="submit"/></center>
		</form>
		<center>
			<p><a href="studentWelcome.jsp">Back to homepage</a></p>
			<p><a href="logout.jsp">Logout</a></p>
		</center>
</body>
</html>