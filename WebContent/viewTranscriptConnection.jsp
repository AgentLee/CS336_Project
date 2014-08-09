<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Courses</title>
</head>
<body><h1>hello</h1>

	<%! String userNetID; %>

	<%
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/spnrequest";
		String user = "root";
		String password = "";

		String query = "SELECT * FROM requesttest WHERE profid=?";

		String netid = request.getParameter("student");
		System.out.println(netid);

			try{
				Class.forName(driverName);
				conn = DriverManager.getConnection(url, user, password);
				ps = conn.prepareStatement(query);
				ps.setString(1, netid);
				rs = ps.executeQuery();
				if(rs.next()){ 
					userNetID = rs.getString("netid");
					//System.out.println(userMajorID);
				
					if(netid.equals(userNetID)){
						session.setAttribute("netid",userNetID);
						response.sendRedirect("profViewCourses.jsp");
					}
				}else {
					response.sendRedirect("error.jsp");
				}
				rs.close();
				ps.close(); 
			} catch(SQLException sqe){
				out.println(sqe);
			}
	%>
	
	<center><p style="color:red">Error In Login</p></center>

</body>
</html>