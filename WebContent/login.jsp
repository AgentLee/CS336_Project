<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Rutgers Special Permission Request System | Login</title>
</head>
<body>
	
	<!-- This checks the users credentials with the db -->
	<!-- Depending on if it's a student/prof/admin they'll have different landing pages -->
	
<%! 
	String userNetID;
	String userName;
	String userPassword;
	String userType;
	String userRUID;
%>
<%
	Connection con= null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	String driverName = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/spnrequest";
	String user = "root";
	String dbpsw = "";

	String sql = "select * from users where netid=? and password=?";

	String netid = request.getParameter("netid");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String usertype = request.getParameter("usertype");
	String ruid = request.getParameter("ruid");
	
	if((!(netid.equals(null) || netid.equals("")) && !(password.equals(null) || password.equals("")))){
		try{
			Class.forName(driverName);
			con = DriverManager.getConnection(url, user, dbpsw);
			ps = con.prepareStatement(sql);
			ps.setString(1, netid);
			ps.setString(2, password);
			rs = ps.executeQuery();
			if(rs.next()){ 
				userNetID = rs.getString("netid");
				userPassword = rs.getString("password");
				userName = rs.getString("name");
				userType = rs.getString("usertype");
				userRUID = rs.getString("ruid");
				
				//System.out.println(userdbNetID);
				if(netid.equals(userNetID) && password.equals(userPassword)){
					session.setAttribute("name",userName);
					session.setAttribute("usertype",userType);
					session.setAttribute("netid", userNetID);
					session.setAttribute("ruid", userRUID);
					
					if(userType.equals("1")){
						response.sendRedirect("studentWelcome.jsp");
					}else if(userType.equals("2")){
						response.sendRedirect("profWelcome.jsp");
					}else if(userType.equals("3")){
						response.sendRedirect("adminWelcome.jsp");
					}				
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
	<center><p style="color:red">Login Error</p></center>
<% 
		getServletContext().getRequestDispatcher("/index.jsp").include(request, response);
	}
%>
</body>
</html>