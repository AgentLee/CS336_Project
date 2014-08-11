<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Choose Course</title>
</head>
<body>
	<!-- New SPN Request -->
	<!-- Student chooses Department -->
	
	<div class="header">
		<center>
			<p><img src = "http://www.holidaylga.com/blog/wp-content/uploads/2011/12/Rutgers-R-Logo.jpg" width="100px"></p>
			<h1 style="color:red">Rutgers Special Permission Request System</h1><hr width="80%">
			<h2><%=session.getAttribute("name")%></h2>
		</center>	
	</div>
	
	<% 
		String selectedMajorID = (String)session.getAttribute("majorid");
	
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
	
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/newspnsystem";
		String user = "root";
		String password = "";
		
		String query = "SELECT DISTINCT cid FROM prereq WHERE majorid="+selectedMajorID;
		
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery(); 
	%>		
	<form method = "post" action = "studentRequestTwoThreeConnection.jsp">
		<table border="1" align="center">
		<tr>
			<td><%=session.getAttribute("majorid")%></td>
			<td>Select Course
				<select name="cid">
				<option value="select">select</option>
	<%
					while(rs.next()){
						String cid = rs.getString("cid");
	%>
						<option value=<%=cid%>><%=cid%></option>
	<% 
					}
		}catch(SQLException sqe){
			out.println("index"+sqe);
		}
	%>
				</select>
			</td>
		</tr>
		</table>
		<br>	
		<center><input type="submit" value="next"/></center>
	</form>
	
	<div class="footer">
		<center>
			<p><a href="studentRequestOne.jsp">Select another department</a></p>
			<p><a href="studentWelcome.jsp">Back to homepage</a></p>
			<p><a href="logout.jsp">Logout</a></p>
		</center>		
	</div>
</body>
</html>