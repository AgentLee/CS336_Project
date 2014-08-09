<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Rutgers Special Permission System</title>
</head>
<body>
	<!-- Professor gets to see the students who requested SPNs for that specific course -->
	
	<center>
		<p><img src = "http://www.holidaylga.com/blog/wp-content/uploads/2011/12/Rutgers-R-Logo.jpg" width="100px"></p>
		<h1 style="color:red">Rutgers Special Permission Request System</h1><hr width="80%">
		<h2><%=session.getAttribute("name")%></h2>
	</center>
	
	<!-- <form method = "post" action = "studentRequestFourFiveConnection.jsp">-->
	<%	
	
		//Gets the string for the course information. Parse to split into Department/Course/Section			
		String courseInfo = (String)request.getParameter("radioButton");
		
		String dept1 = "";
		String course1 = "";
		String section1 = "";	
	
		for(int i = 0; i < courseInfo.length(); i++){
			if(i == 3 || i == 7){
				continue;
			}if(i < 3){
				dept1 = dept1+courseInfo.charAt(i);
			}else if(i > 3 && i < 7){
				course1 = course1+courseInfo.charAt(i);
			}else if(i > 7){
				section1 = section1+courseInfo.charAt(i);
			}
		}
	
		String deptNum = (String)session.getAttribute("majorid");
		String courseNum = (String)session.getAttribute("cid");
		String secNum = (String)session.getAttribute("secnum");
		String profID = (String)session.getAttribute("netid");

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
	
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/spnrequest";
		String user = "root";
		String password = "";
		
		String query = "SELECT * FROM requesttest WHERE cid="+"'"+course1+"' and majorid='"+dept1+"' and secnum='"+section1+"'";
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, user, password);
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery(); 
	%>
	
	<!-- <form method="post" action="viewTranscript.jsp" target="_blank">	-->
		<table border="1" align="center">		
			<tr>
				<td><center>Department:Course:Section</center></td>
				<td><center>Student</center></td>
				<td><center>Reason</center></td>
				<td><center>Status</center></td>
				<td><center>View Transcript</center></td>
				<td><center>SPN?</center></td>
				<td><center>Remaining SPNs</center></td>
				<td><center>Assigned SPN</center></td>
			</tr>
			<%
				while(rs.next()){
					String dept = rs.getString("majorid");
					String course = rs.getString("cid");
					String section = rs.getString("secnum");
					String student = rs.getString("netid");
					String reason = rs.getString("reason");
					String status = rs.getString("status");
					String spn = rs.getString("response");
			%>
			<tr>
				<td><center><%=courseInfo%></center></td>
				<td><center><%=student%></center></td>
				<td><center><%=reason%></center></td>
				<td><center><%=status%></center></td>
				<td><center><form method="post" action="viewTranscript.jsp" target="_blank"><input type="radio" name="radioButton" value="<%=student%>^<%=courseInfo%>"><input type="submit" value="submit" name="submit"></form></center></td>
				<td>
					<center>
					<form method="post" action="spnDecision.jsp">
						<input type="radio" name="radioButton" value="1<%=student%>^<%=courseInfo%>"><font color="green">Grant SPN</font>
						<br>
						<input type="radio" name="radioButton" value="0<%=student%>^<%=courseInfo%>"><font color="red">Deny SPN</font>
						<br>
						<input type="submit" name="submit" value="submit">
					</form>
					</center>
				</td>
				<td><center>10</center></td> <!-- The decrement can either be done in SQL or java -->
				<td><center><%=spn %></center></td>
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
		<center><input type="submit" value="submit" name="submit"></center>
	<!-- </form>-->
		

	
	<center>
		<p><a href="profWelcome.jsp">Back to homepage</a></p>
		<p><a href="logout.jsp">Logout</a></p>
	</center>





</body>
</html>