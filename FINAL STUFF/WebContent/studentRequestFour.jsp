<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Why do you need an SPN?</title>
</head>
<body>
	<!-- New SPN Request -->
	<!-- Student explains why they need an SPN -->
	
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
		String selectedSecNum = (String)session.getAttribute("secnum");
		String selectedSemesterID = (String)session.getAttribute("semesterid");
		String selectedYear = (String)session.getAttribute("year");		

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
	
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/newspnsystem";
		String user = "root";
		String password = "";
		
		String query = "SELECT * FROM courses WHERE secnum="+selectedSecNum;
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, user, password);
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery(); 
	%>	
	
	<div class="spnInformation">
		<form method="post" action="studentRequestFourFiveConnection.jsp">
			<center>
				<h3>SPN for <%=session.getAttribute("majorid")%> : <%=session.getAttribute("cid")%> : <%=session.getAttribute("secnum")%> | <%=session.getAttribute("semesterid")%>:<%=session.getAttribute("year")%> </h3>
				<!-- The input text box needs to be fixed -->
				<!-- Reasoning: <input type="text" name="spnReason" style="height:100px; width:200px;" > -->
				<h4>I need this because...</h4>
				<textarea name="spnReason" rows="5" cols="50"></textarea>
				<p><a href="studentRequestThree.jsp">Choose a different section</a> | <a href="studentRequestOne.jsp">Choose a different course</a></p>
			</center>
	
	<%
		}catch(SQLException sqe){
			out.println("index"+sqe);
		}
	%>
			<br>
			<center><input type="submit" value="submit"/></center>
		</form>
	</div>
</body>
</html>