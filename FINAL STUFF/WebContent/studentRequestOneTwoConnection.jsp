<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Department Validation</title>
</head>
<body>
	<%-- Declaration for query --%>
	<%!String selectedMajorID; %>
	
	<%
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/newspnsystem";
		String user = "root";
		String password = "";

		String query = "SELECT * FROM prereq WHERE majorid=?";

		String majorid = request.getParameter("majorid");
	
		if(!(majorid.equalsIgnoreCase("select"))){
			try{
				Class.forName(driverName);
				conn = DriverManager.getConnection(url, user, password);
				ps = conn.prepareStatement(query);
				ps.setString(1, majorid);
				rs = ps.executeQuery();
				
				if(rs.next()){ 
					selectedMajorID = rs.getString("majorid");
					//System.out.println(userMajorID);
				
					if(majorid.equals(selectedMajorID)){
						session.setAttribute("majorid",selectedMajorID);
						response.sendRedirect("studentRequestTwo.jsp");
					}
				}else {
					//NEEDS ERROR MESSSAGE?
					response.sendRedirect("studentRequestOne.jsp");
				}
				rs.close();
				ps.close(); 
			} catch(SQLException sqe){
				out.println(sqe);
			} 
		} else {
	%>
	
	<center><p style="color:red">No SPNs from that department</p></center>
	
	<% 
		getServletContext().getRequestDispatcher("/studentRequestOne.jsp").include(request, response);
	}
	%>
</body>
</html>