<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
	<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>Insert title here</title>
	</head>
	<body>
	<%String firstName = (String)session.getAttribute("Customer_First_Name");
	String lastName = (String)session.getAttribute("Customer_Last_Name");
	String email = (String)session.getAttribute("Customer_Email");
	
	out.println("Welcome customer");
	out.println("<p>" + firstName + "</p>");
	out.println("<p>" + lastName + "</p>");
	out.println("<p>" + email + "</p>");
	%>
	<a href='logout.jsp'>Click here to logout.</a>
	
	</body>
</html>