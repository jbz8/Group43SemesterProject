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
	<title>Confirmation</title>
	</head>
	<body>
	<% 
	try{
	DateTimeFormatter dtf = DateTimeFormatter.ofPattern("uuuu-MM-dd");
	LocalDate localdate = LocalDate.now();
	
	DateTimeFormatter dtf2 = DateTimeFormatter.ofPattern("HH:mm:ss");
	LocalTime localtime = LocalTime.now();
	
	float fee;
	float total_fare;
	String firstName = (String)session.getAttribute("Customer_First_Name");
	String lastName = (String)session.getAttribute("Customer_Last_Name");
	String email = (String)session.getAttribute("Customer_Email");
	
	int flight_number = Integer.valueOf(request.getParameter("flightNum"));
	String from = request.getParameter("departure_airport");
	String departure_day = request.getParameter("departure_date");
	String to = request.getParameter("arrival_airport");
	String land_day = request.getParameter("arrival_date");
	String ticket_cls = request.getParameter("flight_class");
	Float price = Float.parseFloat(request.getParameter("price"));
	int seat_num = Integer.valueOf(request.getParameter("seats_left"));
	String airline = request.getParameter("airline_id");
	//generate random number for ticket number
	int ticket_num = (int)Math.floor(Math.random()*(999999998)+1);
	String arrivaltime = request.getParameter("arrival_time");
	String departuretime = request.getParameter("departure_time");
	
	if (ticket_cls.equals("economy")){
		fee = (float)20;
	}
	else{
		fee = (float)45.50;
	}
	total_fare = (float)(fee+price);
	if (seat_num!=0){
		
		out.println("Flight number:" + flight_number);
		out.println("<br>");
		
		out.println("Your ticket number:" + ticket_num);
		out.println("<br>");
		
		out.println("Your seat number:" + seat_num);
		out.println("<br>");
		
		out.println("Date of Purchase:" + localdate.toString().substring(0,10));
		out.println("<br>");
		
		out.println("Time of Purchase:" +localtime.toString().substring(0,8));
		out.println("<br>");
		
		out.println("Departure Airport:" + from);
		out.println("<br>");
		
		out.println("Departure Day:" + departure_day);
		out.println("<br>");
		
		out.println("Departure Time:" + departuretime);
		out.println("<br>");
		
		out.println("Arrival Airport:" + to);
		out.println("<br>");
		
		out.println("Landing Day:" + land_day);
		out.println("<br>");
		
		out.println("Arrival Time:" + arrivaltime);
		out.println("<br>");
		
		out.println("Ticket Class:" +ticket_cls);
		out.println("<br>");
		
		out.println("Flight Price:" + price);
		out.println("<br>");
		
		out.println("Company booking fee:" + fee);
		out.println("<br>");
		
		out.println("Total fare:" + total_fare);
		out.println("<br>");
		
		out.println(firstName);
		out.println("<br>");
		
		out.println(lastName);
		out.println("<br>");
		
		out.println(email);
		out.println("<br>");
		
		out.println("Airline:" + airline);
		out.println("<br>");
		
		//update Ticket table , AssociatedWith table , and update the number of seats left on the flight.
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		PreparedStatement ps;	
		String insert = "INSERT INTO Ticket(Airline_ID,Ticket_Number,Seat_Number,Purchase_Date,"+
				"Purchase_Time,Departure_Airport,Departure_Date,Departure_Time,"+
				"Arrival_Airport,Arrival_Date,Arrival_Time,"+
				"Ticket_Class,First_Name,Last_Name,Booking_Fee,Total_Fare)"
				+ "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		
		ps = con.prepareStatement(insert);
		ps.setString(1,airline); //airline
		ps.setInt(2,ticket_num); //ticket number
		ps.setInt(3,seat_num); //set number
		ps.setString(4,localdate.toString().substring(0,10)); //date purchased
		ps.setString(5,localtime.toString().substring(0,8)); //time purchased
		
		ps.setString(6,from); //departure airport
		ps.setString(7,departure_day); //departure day
		ps.setString(8,departuretime); //dep time
		ps.setString(9,to); //arrival airport
		ps.setString(10,land_day); //arrival day
		
		ps.setString(11,arrivaltime); //arrival time
		ps.setString(12,ticket_cls); //ticket class
		ps.setString(13,firstName); //first
		ps.setString(14,lastName); //last
		ps.setFloat(15,fee); //fee 
		ps.setFloat(16,total_fare); //fare 		
		ps.executeUpdate();
		//con.close();
		
		//update the number of seats left on the flight
		//update table_name set column=value where condition;
		int remaining_seats = seat_num-1;
		PreparedStatement ps2;
		String update = "update Flights set Seats_Left=? where Flight_Number=?";
		ps2 = con.prepareStatement(update);
		ps2.setInt(1,remaining_seats);
		ps2.setInt(2,flight_number);
		ps2.executeUpdate();
		//update asscociated with table 
		
		PreparedStatement ps3;
		String insert2 = "insert into Associated_With(Flight_Number,Ticket_Number) values (?,?) ";
		ps3 = con.prepareStatement(insert2);
		ps3.setInt(1,flight_number);
		ps3.setInt(2,ticket_num);
		ps3.executeUpdate();
		
		con.close();
		out.println("<br>");
		out.println("Check your details again in home page");
		out.println("<a href='CustomerHome.jsp'>Home Page</a>");	
	}
	else{
		out.println("<br>");
		out.println("You will be put on the waiting list.");
		out.println("If a spot becomes available we will send you a notification");
		out.println("<a href='CustomerHome.jsp'>Return Home</a>");
		
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		PreparedStatement ps;	
		
		String insert = "insert into Waiting_List(email,Flight_number) values(?,?)";
		ps = con.prepareStatement(insert);
		ps.setString(1,(String)session.getAttribute("Customer_Email"));
		ps.setInt(2,flight_number);
		ps.executeUpdate();
		con.close();
		
		
		
	}
	}
	catch (Exception e){
		out.println("something went wrong search again");
		out.println("<br>");
		out.println("<a href='OneWayFlightSearch.jsp'>Search again.</a>");
	}
	
	%>
	
	</body>
</html>