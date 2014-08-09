<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Rutgers Special Permission System | View Transcript</title>

<style>
	li{
		display:inline;
		margin-right: 5px;
	}
</style>
</head>
<body>	
	<!-- Professor/Admin gets to look at transcript -->
	
	<%
		String str = (String)request.getParameter("radioButton");
		String courseInfo = "";
		String dept1 = "";
		String course1 = "";
		String section1 = "";
		String studentID = "";
		boolean b = false;
		
		for(int i = 0; i < str.length(); i++){
			if(str.charAt(i) != '^'){
				if(b == false){
					studentID = studentID+str.charAt(i);
				}else if(b == true){
					courseInfo = courseInfo+str.charAt(i);
				}
			}else if(str.charAt(i) == '^'){
				b = true;
			}
		}
		
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
		
		//have a boolean function on profViewCourseRequest
		//then have course info = this course info
	%>
	
	
	<%=session.getAttribute("netid")%>
	<%=session.getAttribute("ruid")%>
	
	<center>
		<p><img src = "http://www.holidaylga.com/blog/wp-content/uploads/2011/12/Rutgers-R-Logo.jpg" width="100px"></p>
		<h1 style="color:red">Rutgers Special Permission Request System</h1><hr width="80%">
		<h2><%=session.getAttribute("name")%></h2>
		<h3>Transcript</h3>
	</center>
	
	<form method = "post" action = "studentDeleteConnection.jsp">
	<%
		String deptNum = (String)session.getAttribute("majorid");
		String courseNum = (String)session.getAttribute("cid");
		String profid = (String)session.getAttribute("netid");

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
	
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/spnrequest";
		String user = "root";
		String password = "";
		
		String query = "SELECT * FROM students s, transcript t, majors m WHERE s.netid='"+studentID+"' AND s.ruid=t.ruid and m.majorid = s.majorid";		
	
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, user, password);
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery(); 
	%>	

	<%
		String s = "";
		String s2 = "";
		String s3 = "";
		String s7 = "";
		String s8 = "";
		while(rs.next()){
			s = rs.getString("ruid");
			s2 = rs.getString("majorname");
			s3 = rs.getString("name");
			s7 = rs.getString("majorid");
			s8 = rs.getString("grad");
		}
	%>
	
	<center>
		<div class = "transcriptNav">
			<ul>
				<li><b>Student Name:</b> <%=s3%></li>
				<li><b>Student ID:</b> <%=s%></li>
				<li><b>Major:</b> <%=s2%> (<%=s7%>)</li>
				<li><b>Anticipated Graduation Year:</b> <%=s8%></li>
			</ul>
		</div>
	</center>	
	
	<% 
		}catch(SQLException sqe){
			out.println("index"+sqe);
		}
	%>
	
	<%
		String queryTwo = "SELECT t.ruid, t.deptid, t.cid, t.grade, t.semesterid, t.year, t.grad FROM transcript t, students s WHERE s.netid='"+studentID+"' AND t.ruid = s.ruid ORDER BY t.year";
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, user, password);
			ps = conn.prepareStatement(queryTwo);
			rs = ps.executeQuery(); 
	%>
	
	<table border="1" align="center">
		<tr>
			<td>Department</td>
			<td>Course</td>
			<td>Grade</td>
			<td>Semester</td>
			<td>Year</td>
		</tr>
		<%
			while(rs.next()){
				String department2 = rs.getString("deptid");
				String course2 = rs.getString("cid");
				String grade2 = rs.getString("grade");
				String semester2 = rs.getString("semesterid");
				String year2 = rs.getString("year");
		%>
		<tr>
			<td><center><%=department2%></center></td>
			<td><center><%=course2%></center></td>
			<td><center><%=grade2%></center></td>
			<td><center><%=semester2%></center></td>
			<td><center><%=year2%></center></td>
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
		<center><input type="submit" value="submit"/></center>
	</form>
	
	<form method="post" action="profViewCourseRequests.jsp">
		<input type="submit" name="<%=courseInfo%>" value="<%=courseInfo%>">
	</form>
	
	
	<div align="center" class="footer">
		<ul>
			<li><a href="profViewCourseRequests.jsp">Back to Requests</a></li>
			<li><a href="profViewCourses.jsp">Back to Courses</a></li>
		</ul>
		<ul>
			<li><a href="profWelcome.jsp">Back to homepage</a></li>
			<li><a href="logout.jsp">Logout</a></li>
		</ul>
	</div>
</body>
</html>