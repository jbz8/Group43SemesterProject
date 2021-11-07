<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Travel Application Project CS336</title>
	</head>
	
	<body>
	
	<h1 style="color: green">Welcome to the Travel Application:</h1> 
	
	<h2 style="color: blue">Log In:</h2> 
	
		<br>
		<br>
		<br>
	
	
		<form method="post" action="show.jsp">
		
		  <input type="text" name="email" /> Enter Email address
		  <br>
		  <input type="password" name="Password" /> Enter Password


		  <br>
		  <input type="submit" value="submit" />
		</form>
		<br>
		
		
		
		 To register for a new account choose below:

							  
		<br>

		<form method="post" action="Reg_page.jsp">
		
		  <input type="radio" />
	
		  <input type="submit" value="submit" />
		</form>
		<br>
</body>
</html>