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
	
	<!-- Student gets to choose course -->

	<center>
		<p><img src = "http://www.holidaylga.com/blog/wp-content/uploads/2011/12/Rutgers-R-Logo.jpg" width="100px"></p>
		<h1 style="color:red">Rutgers Special Permission Request System</h1><hr width="80%">
		<h2><%=session.getAttribute("name")%></h2>
	</center>
	
	<form method = "post" action = "studentRequestTwoThreeConnection.jsp">
		<%
			String deptNum = (String)session.getAttribute("majorid");
			//System.out.println("DEPT: "+deptNum);
		%>
		
	<%	
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
	
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/spnrequest";
		String user = "root";
		String password = "";
		
		String query = "SELECT DISTINCT cid FROM courses WHERE majorid="+deptNum;
	%>

	<%		
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery(); 
	%>	
	
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
	<center>
		<p><a href="studentWelcome.jsp">Back to homepage</a></p>
		<p><a href="logout.jsp">Logout</a></p>
	</center>
</body>
</html>