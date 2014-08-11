<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Section Validation</title>
</head>
<body>
	<%! String selectedSecNum; %>
	<%! String selectedSemesterID; %>
	<%! String selectedSelectedYear; %>
	
	<%
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/newspnsystem";
		String user = "root";
		String password = "";

		String query = "SELECT * FROM courses WHERE secnum=?";
		
		String secNum = request.getParameter("secnum");
		String year = request.getParameter("year");
		String semesterid = request.getParameter("semesterid");
	
		if(!(secNum.equalsIgnoreCase("select"))){
			try{
				Class.forName(driverName);
				conn = DriverManager.getConnection(url, user, password);
				ps = conn.prepareStatement(query);
				ps.setString(1, secNum);
				rs = ps.executeQuery();
				
				if(rs.next()){ 
					selectedSecNum = rs.getString("secnum");
					selectedSemesterID = rs.getString("semesterid");
					selectedSelectedYear = rs.getString("year");
					if(secNum.equals(selectedSecNum)){
						session.setAttribute("secnum",selectedSecNum);
						session.setAttribute("year",selectedSelectedYear);
						session.setAttribute("semesterid",selectedSemesterID);
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