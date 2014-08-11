<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Request New SPN</title>
</head>
<body>
	<!-- New SPN Request -->
	<!-- Student chooses Department -->
	
	<%	
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/newspnsystem";
		String user = "root";
		String password = "";

		String sql = "SELECT DISTINCT m.majorid, m.majorname FROM majors m";
	
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, user, password);
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery(); 
	%>
	
	<div class="header">
		<center>
			<p><img src = "http://www.holidaylga.com/blog/wp-content/uploads/2011/12/Rutgers-R-Logo.jpg" width="100px"></p>
			<h1 style="color:red">Rutgers Special Permission Request System</h1><hr width="80%">
			<h2>Welcome <%=session.getAttribute("name")%>!</h2>
		</center>
	</div>
	
	<form method="post" action="studentRequestOneTwoConnection.jsp">
		<center>
			<table border="1">
				<tr>
					<td>Select Department
						<select name="majorid">
						<option value="select">select</option>
		<%
			while(rs.next()){
				String majorid = rs.getString("majorid");
				String majorname = rs.getString("majorname");
		%>
					<option value=<%=majorid%>><%=majorname%> (<%=majorid%>)</option>
	<%
			}
		}catch(SQLException sqe){
			out.println("showcourses"+sqe);
		}
	%>
						</select>
					</td>
				</tr>
			</table>
			<br>
			<input type="submit" value="next"/>
		</center>
	</form>
	
	<div class="footer">
		<center>
			<p><a href="studentWelcome.jsp">Back to homepage</a></p>
			<p><a href="logout.jsp">Logout</a></p>
		</center>
	</div>
</body>
</html>