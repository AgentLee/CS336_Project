<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome</title>
</head>
<body>
	<center><p><img src = "http://www.holidaylga.com/blog/wp-content/uploads/2011/12/Rutgers-R-Logo.jpg" width="100px"></p>
		<h2 style="color:red">Rutgers Special Permission Request System</h2><hr width="80%">
		<p><%=session.getAttribute("name")%>
		<br><%=session.getAttribute("usertype")%></p>
	</center>
	
	<form method="post" action="studentcourses.jsp">
<%	
		Connection con= null;
		PreparedStatement ps = null;
		ResultSet rs = null;
	
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/spns";
		String user = "root";
		String password = "halo3rox";

		String sql = "SELECT DISTINCT m.majorid, m.majorname FROM majors m";

		try {
			Class.forName(driverName);
			con = DriverManager.getConnection(url, user, password);
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery(); 
%>


	<table border="1" align="center">
		<tr>
			<td>Department</td>
			<td>
				<select name="majorid">
				<option value="select">select</option>
<%
					while(rs.next()){
						String majorid = rs.getString("majorid");
						String majorname = rs.getString("majorname");
%>
						<option value=<%=majorid+majorname%>><%=majorid+": "+majorname%></option>
	<% 
					}
		}catch(SQLException sqe){
			out.println("index"+sqe);
		}
%>
				</select>
			</td>
		</tr>
		<tr>
			<td></td>
			<td>
				<input type="submit" value="submit"/>
			</td>
		</tr>
	</table>
	<center>
		<p>
			<a href="logout.jsp">Logout</a>
		</p>
	</center>
	</form>
</body>
</html>
