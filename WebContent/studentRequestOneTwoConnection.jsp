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

<%! String userdbMajorID; %>
<%
	Connection con= null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	String driverName = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/spns";
	String user = "root";
	String dbpsw = "halo3rox";

	String sql = "select * from courses where majorid=?";

	String majorid = request.getParameter("majorid");
	
	if(!(majorid.equalsIgnoreCase("select"))){
		try{
			Class.forName(driverName);
			con = DriverManager.getConnection(url, user, dbpsw);
			ps = con.prepareStatement(sql);
			ps.setString(1, majorid);
			rs = ps.executeQuery();
			if(rs.next()){ 
				userdbMajorID = rs.getString("majorid");
				System.out.println(userdbMajorID);
				
				if(majorid.equals(userdbMajorID)){
					session.setAttribute("majorid",userdbMajorID);
					response.sendRedirect("studentRequestTwo.jsp");
				}
			}else
				response.sendRedirect("error.jsp");
			rs.close();
			ps.close(); 
		} catch(SQLException sqe){
			out.println(sqe);
		} 
	} else {
%>
<center><p style="color:red">Error In Login</p></center>
<% 
		getServletContext().getRequestDispatcher("/index.jsp").include(request, response);
	}
%>
</body>
</html>