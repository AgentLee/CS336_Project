<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>

	<%! String userSecNum; %>
	<%! String useryr; %>
	<%! String usersemester; %>

	<%
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/spnrequest";
		String user = "root";
		String password = "";

		String query = "SELECT * FROM courses WHERE secnum=?";

		String secNum = request.getParameter("secnum");
		String yr = request.getParameter("year");
		String semester = request.getParameter("semesterid");
	
		if(!(secNum.equalsIgnoreCase("select"))){
			try{
				Class.forName(driverName);
				conn = DriverManager.getConnection(url, user, password);
				ps = conn.prepareStatement(query);
				ps.setString(1, secNum);
				rs = ps.executeQuery();
				if(rs.next()){ 
					userSecNum = rs.getString("secnum");
					if(secNum.equals(userSecNum)){
						session.setAttribute("secnum",userSecNum);
						session.setAttribute("yr",useryr);
						session.setAttribute("semester",usersemester);
						response.sendRedirect("studentRequestFour.jsp");
					}
				}else {
					response.sendRedirect("error.jsp");
				}
				rs.close();
				ps.close(); 
			} catch(SQLException sqe){
				out.println(sqe);
			} 
		} else {
	%>
	
	<center><p style="color:red">Error processing request</p></center>
	
	<% 
		getServletContext().getRequestDispatcher("/index.jsp").include(request, response);
	}
	%>
</body>
</html>
