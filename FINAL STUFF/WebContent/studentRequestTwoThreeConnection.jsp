<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Course Validation</title>
</head>
<body>
	<%! String selectedCID; %>
	
	<%
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/newspnsystem";
		String user = "root";
		String password = "";

		String query = "SELECT * FROM courses WHERE cid=?";

		String cid = request.getParameter("cid");
	
		if(!(cid.equalsIgnoreCase("select"))){
			try{
				Class.forName(driverName);
				conn = DriverManager.getConnection(url, user, password);
				ps = conn.prepareStatement(query);
				ps.setString(1, cid);
				rs = ps.executeQuery();
				
				if(rs.next()){ 
					selectedCID = rs.getString("cid");
				
					if(cid.equals(selectedCID)){
						session.setAttribute("cid",selectedCID);
						response.sendRedirect("studentRequestThree.jsp");
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
	
	<center><p style="color:red">Error In Login</p></center>
	
	<% 
		getServletContext().getRequestDispatcher("/index.jsp").include(request, response);
	}
	%>
</body>
</html>