<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import= 'java.time.format.*' %>
<%@ page import= 'java.time.*' %>
<%@ page import= 'java.util.Random' %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>Past Flights</title>
	</head>
	<body>
	<%
	try{
		//get parameters for query
		String firstName = (String)session.getAttribute("Customer_First_Name");
		String lastName = (String)session.getAttribute("Customer_Last_Name");
		
		
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		String str = "Select * from Ticket where Departure_Date < curdate() and";
		str = str + " First_Name='" + firstName + "' and Last_Name='" + lastName + "';";
		
		ResultSet result = stmt.executeQuery(str);
		while (result.next()) {
			//get details of ticket
			String airline_id = result.getString("Airline_ID");
			int ticket_number = Integer.valueOf(result.getString("Ticket_Number"));
			int seat_number = Integer.valueOf(result.getString("Seat_Number"));
			String purchase_date = result.getString("Purchase_Date");
			String purchase_time = result.getString("Purchase_Time");
			String departure_airport = result.getString("Departure_Airport");
			String departure_date = result.getString("Departure_Date");
			String departure_time = result.getString("Departure_Time");
			String arrival_airport = result.getString("Arrival_Airport");
			String arrival_date = result.getString("Arrival_Date");
			String arrival_time = result.getString("Arrival_Time");
			String ticket_class = result.getString("Ticket_Class"); 
			float booking_fee = Float.valueOf(result.getString("Booking_Fee"));
			float total_fare = Float.valueOf(result.getString("Total_Fare"));
			float flight_price = total_fare - booking_fee;
			
			//show details
			out.println("Ticket Number:"+ticket_number);
			out.println("<br>");
			
			out.println("Airline:"+ airline_id);
			out.println("<br>");
			
			out.println("Seat Number:"+seat_number);
			out.println("<br>");
			
			out.println("Purchase Date:"+ purchase_date);
			out.println("<br>");
			
			out.println("Purchase Time:" +purchase_time);
			out.println("<br>");
			
			out.println("Departure Airport:"+ departure_airport);
			out.println("<br>");
			
			out.println("Leave on:"+departure_date);
			out.println("<br>");
			
			out.println("Time of Flight:"+ departure_time);
			out.println("<br>");
			
			
			out.println("Arrival Airport:"+ arrival_airport);
			out.println("<br>");
			
			
			out.println("Land on:"+ arrival_date);
			out.println("<br>");
			
			out.println("Land Time:" + arrival_time);
			out.println("<br>");
			
			out.println("Flight Class:"+ticket_class);
			out.println("<br>");
			
			out.println("First Name:"+firstName);
			out.println("<br>");
			
			out.println("Last Name:"+lastName);
			out.println("<br>");
			
			out.println("Booking Fee:"+booking_fee);
			out.println("<br>");
			
			out.println("Total Fare:"+total_fare);
			out.println("<br>");
			
			out.println("Price:"+ flight_price);
			out.println("<br>");
		}
		con.close();
		out.println("<a href='CustomerHome.jsp'>Return Home</a>");
		
	}

	catch(Exception e){
		out.println("No data to show.");
		out.println("<br>");
		out.println("<a href='CustomerHome.jsp'>Return Home</a>");
	}

	%>
	</body>
</html>