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
	<title>Upcoming Flights</title>
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
		String str = "Select * from Ticket where Departure_Date > curdate() and";
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
			out.println("<form action='#'>"); //change later to cancel a flight
			out.println("<label for='flightNum'> Ticket Number: </label> ");
			out.println("<input type='text' id='ticketNum' name='ticketNum' value='" + 
			ticket_number + "' readonly>");
			out.println("<br>");
			
			out.println("<label for='airline_id'> Airline: </label> ");
			out.println("<input type='text' id='airline_id' name='airline_id' value='"+
			airline_id + "' readonly>");
			out.println("<br>");
			
			out.println("<label for='seats_left'> Seat Number: </label> ");
			out.println("<input type='text' id='seat_number' name='seat_number' value='" + 
			seat_number  + "' readonly>");
			out.println("<br>");
			
			out.println("<label for='purchase_date'> Purchase Date: </label> ");
			out.println("<input type='text' id='purchase_date' name='purchase_date' value='" + 
			purchase_date  + "' readonly>");
			out.println("<br>");
			
			out.println("<label for='purchase_time'> Purchase Time: </label> ");
			out.println("<input type='text' id='purchase_time' name='purchase_time' value='" + 
			purchase_time  + "' readonly>");
			out.println("<br>");
			
			out.println("<label for='departure_airport'> Departure Airport: </label> ");
			out.println("<input type='text' id='departure_airport' name='departure_airport' value='" + 
			departure_airport + "' readonly>");
			out.println("<br>");
			
			out.println("<label for='departure_date'> Leave on: </label> ");
			out.println("<input type='text' id='departure_date' name='departure_date' value='" + 
			departure_date +  "' readonly>");
			out.println("<br>");
			
			out.println("<label for='departure_time'> Time of Flight: </label>" );
			out.println("<input type='text' id='departure_time' name='departure_time' value='" + 
			departure_time + "' readonly>");
			out.println("<br>");
			
			
			out.println("<label for='arrival_airport'> Arrival Airport: </label> ");
			out.println("<input type='text' id='arrival_airport' name='arrival_airport' value='" + 
			arrival_airport + "' readonly>");
			out.println("<br>");
			
			
			out.println("<label for='arrival_date'> Land on: </label> ");
			out.println("<input type='text' id='arrival_date' name='arrival_date' value='" + 
			arrival_date + "' readonly>");
			out.println("<br>");
			
			out.println("<label for='arrival_time'> Land Time: </label> ");
			out.println("<input type='text' id='arrival_time' name='arrival_time' value='" + 
			arrival_time +  "' readonly>");
			out.println("<br>");
			
			out.println("<label for='flight_class'> Flight Class: </label> ");
			out.println("<input type='text' id='flight_class' name='flight_class' value='"+
			ticket_class + "' readonly>");
			out.println("<br>");
			
			out.println("<label for='first_name'> First Name: </label> ");
			out.println("<input type='text' id='first_name' name='first_name' value='"+
			firstName + "' readonly>");
			out.println("<br>");
			
			out.println("<label for='last_name'> Last Name: </label> ");
			out.println("<input type='text' id='last_name' name='last_name' value='"+
			lastName + "' readonly>");
			out.println("<br>");
			
			out.println("<label for='booking_fee'> Booking Fee: </label> ");
			out.println("<input type='text' id='booking_fee' name='booking_fee' value='"+
			booking_fee + "' readonly>");
			out.println("<br>");
			
			out.println("<label for='total_fare'> Total Fare: </label> ");
			out.println("<input type='text' id='total_fare' name='total_fare' value='"+
			total_fare + "' readonly>");
			out.println("<br>");
			
			
			out.println("<label for='price'> Price: </label> ");
			out.println("<input type='text' id='price' name='price' value='"+
			flight_price + "' readonly>");
			out.println("<br>");
			
			
			if (ticket_class.equals("economy")){
				out.println("<input type='submit' value='Cancel Now for a Fee'>");
				out.println(" </form> ");
				out.println("<br>");
				out.println("<br>");
				
			}
			else{
				out.println("<input type='submit' value='Cancel Now'>");
				out.println(" </form> ");
				out.println("<br>");
				out.println("<br>");
			}
		}
		con.close();
		
	}
	catch(Exception e){
		out.println("No data to show.");
		out.println("<br>");
		out.println("<a href='CustomerHome.jsp'>Return Home</a>");
		
	}

	%>
	</body>
</html>