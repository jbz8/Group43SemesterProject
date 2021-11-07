<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the index.jsp
		String first = request.getParameter("First");
		String last = request.getParameter("Last");
		//float acct = Float.valueOf(request.getParameter("acct"));
		String email = request.getParameter("email");
		String pass = request.getParameter("Pass");
		
		PreparedStatement ps;

		
		String insert = "INSERT INTO Users(First_Name, Last_Name, Email, Password,Account_Type)"
				+ "VALUES (?,?,?,?,?)";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		
		 ps = con.prepareStatement(insert);
		
		
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		
		ps.setString(1, first);
		ps.setString(2, last);
		ps.setString(3, email);
		ps.setString(4, pass);
		ps.setString(5,"customer");
		
		
		//Run the query against the DB
		
		ps.executeUpdate();
		
		//Run the query against the DB
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		
		
		con.close();
		out.print("Account Created Successful");
		out.print("<a href='welcome_page.jsp'>Click here to login now </a>" );
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Account Creation failed");
	}
%>
</body>
</html>