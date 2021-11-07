<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Insert title here</title>
	</head>
	<body>
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String entity = request.getParameter("email");
			String pass = request.getParameter("Password");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			//String str = "SELECT * FROM CUSTOMER WHERE Email ="+"'" + entity + "';";
			String str = "select * from Users where Email='" + entity + "' and Password='" + pass + "';";
			
			
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
	
			if (result.next()){
				String AccountType = result.getString("Account_Type");
				//out.println(AccountType);
				//set session attributes and take user to correct homepage
				if (AccountType.equals("customer")){
					session.setAttribute("Customer_First_Name",result.getString("First_Name"));
					session.setAttribute("Customer_Last_Name",result.getString("Last_Name"));
					session.setAttribute("Customer_Email",result.getString("email"));
					con.close();
					response.sendRedirect("CustomerHome.jsp");
					
				}
				else if (AccountType.equals("Admin")){
					session.setAttribute("Admin_First_Name",result.getString("First_Name"));
					session.setAttribute("Admin_Last_Name",result.getString("Last_Name"));
					session.setAttribute("Admin_Email",result.getString("email"));
					con.close();
					response.sendRedirect("AdminHome.jsp");
					
				}
				else{
					session.setAttribute("CustomerRep_First_Name",result.getString("First_Name"));
					session.setAttribute("CustomerRep_Last_Name",result.getString("Last_Name"));
					session.setAttribute("CustomerRep_Email",result.getString("email"));
					con.close();
					response.sendRedirect("CustomerRepresentativeHome.jsp");
				}
			}
			else{
				out.println("Invalid Username and/or password  <a href='login.jsp'>try again</a>");
			}
		}
		catch(Exception e){
				
		}
			
		%>
		
	
	

	</body>
</html>