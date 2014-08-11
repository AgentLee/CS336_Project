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
		//Parse reasoning into a string to be put into database
        StringBuffer spnReason = new StringBuffer(request.getParameter("spnReason"));
  
        int loc = (new String(spnReason)).indexOf('\n');
        while(loc > 0){
        	spnReason.replace(loc, loc+1, "<BR>");
            loc = (new String(spnReason)).indexOf('\n');
       }        

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
        	
		String userRUID = (String)session.getAttribute("ruid");
		String selectedMajorID = (String)session.getAttribute("majorid");
		String selectedCID = (String)session.getAttribute("cid");
		String selectedSecNum = (String)session.getAttribute("secnum");
		String selectedSemesterID = (String)session.getAttribute("semesterid");
		String selectedYear = (String)session.getAttribute("year");
		String status = "Pending";
		String userResponse = "";
		
		System.out.println(userRUID+" "+selectedMajorID+" "+selectedCID+" "+selectedSecNum+" "+selectedSemesterID+" "+selectedYear+" "+status+" "+spnReason);
		
		//Do error checking to see if the student has an spn for that section already
		//Do error checking to see if the student is already registered for the course		
		
		//majorid, cid, secnum, semester, year, ruid, time, status, reason, response, message
		String query = "INSERT INTO request(majorid, cid, secnum, semesterid, year, ruid, time, status, reason) VALUES('"+selectedMajorID+"', '"+selectedCID+"', '"+selectedSecNum+"', '"+selectedSemesterID+"','"+selectedYear+"','"+userRUID+"', curtime(), '"+status+"', '"+spnReason+"')";
		
		statement.executeUpdate(query);
		response.sendRedirect("studentRequestFive.jsp");
	%>     
</body>
</html>