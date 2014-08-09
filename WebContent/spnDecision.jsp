<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SPN</title>
</head>
<body>
	<%
		String radioButton = (String)request.getParameter("radioButton");
		int decision = Character.getNumericValue(radioButton.charAt(0));
		String studentID = "";
		String courseInfo = "";		
		
		boolean b = false;
	
		for(int i = 1; i < radioButton.length(); i++){
			if(radioButton.charAt(i) != '^'){
				if(b == false){
					studentID = studentID+radioButton.charAt(i);
				}else if(b == true){
					courseInfo = courseInfo+radioButton.charAt(i);
				}
			}else if(radioButton.charAt(i) == '^'){
				b = true;
			}
		}
		
		String dept1 = "";
		String course1 = "";
		String section1 = "";	
	
		for(int i = 0; i < courseInfo.length(); i++){
			if(i == 3 || i == 7){
				continue;
			}if(i < 3){
				dept1 = dept1+courseInfo.charAt(i);
			}else if(i > 3 && i < 7){
				course1 = course1+courseInfo.charAt(i);
			}else if(i > 7){
				section1 = section1+courseInfo.charAt(i);
			}
		}		
		
		//set attribuites for student/dept/cid/secnum to both pages
		session.setAttribute("studentNetID", studentID);
		session.setAttribute("dept", dept1);
		session.setAttribute("cid", course1);
		session.setAttribute("secnum", section1);		
		
		//1 = approved...0 = denied
		if(decision == 1){
			session.setAttribute("decision",decision);
			response.sendRedirect("grantSPNConnection.jsp");
		}else {
			session.setAttribute("decision",decision);
			response.sendRedirect("denySPN.jsp");
		}
	%>
</body>
</html>