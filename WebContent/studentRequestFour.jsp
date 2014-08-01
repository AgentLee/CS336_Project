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

	<!-- Student explains why they need the SPN -->

	<center>
		<p><img src = "http://www.holidaylga.com/blog/wp-content/uploads/2011/12/Rutgers-R-Logo.jpg" width="100px"></p>
		<h1 style="color:red">Rutgers Special Permission Request System</h1><hr width="80%">
		<h2><%=session.getAttribute("name")%></h2>
	</center>
	
	<form method = "post" action = "studentRequestTwoThreeConnection.jsp">
	<%
		String deptNum = (String)session.getAttribute("majorid");
		//System.out.println("DEPT: "+deptNum);
		String courseNum = (String)session.getAttribute("cid");
		String secNum = (String)session.getAttribute("secnum");

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
	
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/spnrequest";
		String user = "root";
		String password = "";
		
		String query = "SELECT * FROM courses WHERE secnum="+secNum;
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, user, password);
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery(); 
	%>	

	<!-- If you can figure out how to make an entire listing of the sections instead of just a drop down menu for the sections, that'd be awesome -->
	
		<center>
			<h3>Requesting: <%=session.getAttribute("majorid")%>: <%=session.getAttribute("cid")%>: <%=session.getAttribute("secnum")%></h3>
			<!-- The input text box needs to be fixed -->
			Reasoning: <input type="text" name="spnReason" style="height:100px; width:200px;" >
			<p><a href ="studentRequestOne.jsp">Choose another course</a></p>
		</center>
	
	<%
		}catch(SQLException sqe){
			out.println("index"+sqe);
		}
	%>
		<br>
		<center><input type="submit" value="submit"/></center>
	</form>
	<center><p><a href="logout.jsp">Logout</a></p></center>
</body>
</html>