<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<center>
		<p><img src = "http://www.holidaylga.com/blog/wp-content/uploads/2011/12/Rutgers-R-Logo.jpg" width="100px"></p>
		<h2 style="color:red">Rutgers Special Permission Request System</h2><hr width="80%">
		<p><%=session.getAttribute("name")%>
		<br><%=session.getAttribute("usertype")%></p>
	</center>

	<form method="post" action="studentRequestOneTwoConnection.jsp">
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
	
		<center>
			<table>
				<tr>
					<td>Select Department</td>
					<td><select name="majorid">
					<option value="select">select</option>
<%
						while(rs.next()){
							String majorid = rs.getString("majorid");
%>
					<option value=<%=majorid%>><%=majorid%></option>
<%
						}
				}catch(SQLException sqe){
					out.println("showcourses"+sqe);
				}
%>
					</select></td>
				</tr>
			</table>
		
			<input type="submit" value="submit"/>
		</center>
	</form>
	
	<center>
		<p><a href="logout.jsp">Logout</a></p>
	</center>
</body>
</html>