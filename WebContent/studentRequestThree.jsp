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
	<center>
		<p><img src = "http://www.holidaylga.com/blog/wp-content/uploads/2011/12/Rutgers-R-Logo.jpg" width="100px"></p>
		<h2 style="color:red">Rutgers Special Permission Request System</h2><hr width="80%">
		<p><%=session.getAttribute("name")%>
		<br><%=session.getAttribute("majorid")%></p>
		
		<%
			String s = (String)session.getAttribute("cid");
			System.out.println("COURSE: "+s);
		%>
	</center>

<%	
		Connection con= null;
		PreparedStatement ps = null;
		ResultSet rs = null;
	
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/spns";
		String user = "root";
		String password = "halo3rox";
		
		//Need a way to connect this to studentcourses.jsp
		//String str = request.getParameter("majorid");
		//System.out.println(str+"kddkd");
		//String sql="select DISTINCT cid from courses where majorid='" + str +"'";
		String sql = "SELECT secnum FROM courses WHERE cid="+s;
%>
<%
    //String name = session.getAttribute( "majorid" );
	//System.out.println(name+"dkjfd");
    //String mysql = "select * from table1 where cottCode=" + name;
    // then connecting MySql server using driver in JSP to execute the SQL query
%>

<%		
		try {
			Class.forName(driverName);
			con = DriverManager.getConnection(url, user, password);
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery(); 
%>	
	<form method = "post" action = "studentRequestThree.jsp">
	<table border="1" align="center">
		<tr>
			<td>Courses</td>
			<td>
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
	<center><input type="submit" value="submit"/></center>
</form>
	<center>
		<p>
			<a href="logout.jsp">Logout</a>
		</p>
	</center>
</body>
</html>