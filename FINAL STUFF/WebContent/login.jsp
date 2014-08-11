<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Rutgers Special Permission Request System | Login Valiation</title>
</head>
<body>
	<!-- 
		 Login Validation
		 If the user decides to login, this checks if the user's information
		 matches the database information
	 -->
	 
	<%! 
		//Variables for the login information
		String userNetID;
		String userName;
		String userPassword;
		String userType;
		String userRUID;
	%>
	
	<%
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	String driverName = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/newspnsystem";
	String user = "root";
	String dbpsw = "";

	String query = "SELECT * FROM users WHERE netid=? and password=?";
	
	String netid = request.getParameter("netid");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String usertype = request.getParameter("usertype");
	String ruid = request.getParameter("ruid");

	if((!(netid.equals(null) || netid.equals("")) && !(password.equals(null) || password.equals("")))){
		try{
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, user, dbpsw);
			ps = conn.prepareStatement(query);
			ps.setString(1, netid);
			ps.setString(2, password);
			rs = ps.executeQuery();
			
			if(rs.next()){ 
				userNetID = rs.getString("netid");
				userPassword = rs.getString("password");
				userName = rs.getString("name");
				userType = rs.getString("usertype");
				userRUID = rs.getString("ruid");

				if(netid.equals(userNetID) && password.equals(userPassword)){
					//set attributes so that the next page can use the information
					session.setAttribute("name",userName);
					session.setAttribute("usertype",userType);
					session.setAttribute("netid", userNetID);
					session.setAttribute("ruid", userRUID);
					
					//depending on which user logs in, there are redirects for them
					if(userType.equals("1")){
						response.sendRedirect("studentWelcome.jsp");
					}else if(userType.equals("2")){
						response.sendRedirect("profWelcome.jsp");
					}else if(userType.equals("3")){
						response.sendRedirect("adminWelcome.jsp");
					}				
				}
			}else
				//if login fails redirect to error.jsp which redirects to the index with the error message
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
		//if user doesn't input information then there will be an error message
		getServletContext().getRequestDispatcher("/index.jsp").include(request, response);
	}
%>
</body>
</html>