<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Processing Request</title>
</head>
<body>
	<%
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/newspnsystem";
		String user = "root";
		String password = "";

		Class.forName(driverName);
		conn = DriverManager.getConnection(url, user, password);
		
		Statement statement = conn.createStatement();
        	
		String courseInfo = request.getParameter("radioButton");		
		String userRUID = (String)session.getAttribute("ruid");
		String deptID = "";
		String courseID = "";
		String sectionNum = "";
		
		for(int i = 0; i < courseInfo.length(); i++){
			if(i == 3 || i == 7){
				continue;
			}if(i < 3){
				deptID = deptID+courseInfo.charAt(i);
			}else if(i > 3 && i < 7){
				courseID = courseID+courseInfo.charAt(i);
			}else if(i > 7){
				sectionNum = sectionNum+courseInfo.charAt(i);
			}
		}
		
		String query = "UPDATE request SET status='Canceled' WHERE ruid='"+userRUID+"' AND majorid='"+deptID+"' AND cid='"+courseID+"' AND secNum='"+sectionNum+"'";
		
		statement.executeUpdate(query);
		System.out.println("success");
		response.sendRedirect("studentDeleteOne.jsp");
	%>     
</body>
</html>