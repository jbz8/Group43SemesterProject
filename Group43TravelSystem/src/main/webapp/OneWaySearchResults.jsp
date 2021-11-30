<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>One Way Flight Results</title>
	</head>
	<body>
	<a href="OneWayFlightSearch.jsp">Back to Search</a>
	<br>
	<br>
	<%
	try{
	String from = request.getParameter("departure_airport");
	String to = request.getParameter("arrival_airport");
	String leavingDay = request.getParameter("departure_date");
	String flexible = request.getParameter("answer");
	String sortSelect = request.getParameter("sort_selection");
	String filterSelect = request.getParameter("filter_selection");
	//create connection 	
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();		
	//Create a SQL statement
	Statement stmt = con.createStatement();
	String str = "Select * from Flights join Operates using (Flight_Number) where Departure_Airport='" + from +
			"' and Arrival_Airport='" + to + "'";
	if (flexible.equals("no") || Objects.equals(null,flexible)){
		str = str + " and Departure_Date='" + leavingDay + "'";
	}
	else{
		str = str + " and Departure_Date between date_sub('"+
		leavingDay+"',interval 3 day) and "+
		" date_add('" + leavingDay+"',interval 3 day) "; 
	}
	
	//add filter
	if (!filterSelect.equals("no_filter")){
		switch(filterSelect){
		case "price_tier1":
			str = str + " and Price>=0 and Price<150 ";
			break;
		case "price_tier2":
			str = str + " and Price>=150 and Price<300> ";
			break;
		case "price_tier3":
			str = str + " and Price>=300 ";
			break;
		case "no_stops":
			str = str + " and stops=0 ";
			break;
		case "takeoff_am":
			str = str + " and Departure_Time<='12:00:00' ";
			break;
		case "takeoff_pm":
			str = str + " and Departure_Time>='12:00:00' ";
			break;
		case "landing_am":
			str = str + "and Arrival_Time<='12:00:00'";
			break;
		case "landing_pm":
			str = str + " and Arrival_Time>='12:00:00' ";
			break;
		default:
			break;
			
		}
			
	//sort by option
	}
	if (!sortSelect.equals("no_sort")){
		switch(sortSelect){
		case "price_high_to_low":
			str = str + " order by Price desc ";
			break;
		case "price_low_to_high":
			str = str + " order by Price asc ";
			break;
		case "take_off_time":
			str = str + " order by Departure_Time asc ";
			break;
		case "landing_time":
			str = str + " order by Arrival_Time asc ";
			break;
		case "flight_Duration":
			break;
		default:
			break;
		}
		
	}
	str+=";";
	//out.println(str);
	//make several prefilled forms and submit the one we want
	//with the relevent information to the next page
	ResultSet result = stmt.executeQuery(str);
	while (result.next()) {
		out.println("<form action='buyOneWayFlight.jsp'>");
		out.println("<label for='flightNum'> Flight Number: </label> ");
		out.println("<input type='text' id='flightNum' name='flightNum' value='" + 
		result.getString("Flight_Number") + "' readonly>");
		out.println("<br>");
		
		out.println("<label for='departure_airport'> Departure Airport: </label> ");
		out.println("<input type='text' id='departure_airport' name='departure_airport' value='" + 
		result.getString("Departure_Airport") + "' readonly>");
		out.println("<br>");
		
		out.println("<label for='departure_date'> Leave on: </label> ");
		out.println("<input type='text' id='departure_date' name='departure_date' value='" + 
		result.getString("Departure_Date") +  "' readonly>");
		out.println("<br>");
		
		out.println("<label for='departure_time'> Time of Flight: </label>" );
		out.println("<input type='text' id='departure_time' name='departure_time' value='" + 
		result.getString("Departure_Time") + "' readonly>");
		out.println("<br>");
		
		
		out.println("<label for='arrival_airport'> Arrival Airport: </label> ");
		out.println("<input type='text' id='arrival_airport' name='arrival_airport' value='" + 
		result.getString("Arrival_Airport") + "' readonly>");
		out.println("<br>");
		
		
		out.println("<label for='arrival_date'> Land on: </label> ");
		out.println("<input type='text' id='arrival_date' name='arrival_date' value='" + 
		result.getString("Arrival_Date") + "' readonly>");
		out.println("<br>");
		
		out.println("<label for='arrival_time'> Land Time: </label> ");
		out.println("<input type='text' id='arrival_time' name='arrival_time' value='" + 
		result.getString("Arrival_Time") +  "' readonly>");
		out.println("<br>");
		
		out.println("<label for='num_stops'> Number of Stops: </label> ");
		out.println("<input type='text' id='num_stops' name='num_stops' value='" + 
		result.getString("stops") + "' readonly>");
		out.println("<br>");
		
		out.println("<label for='seats_left'> Seats Left: </label> ");
		out.println("<input type='text' id='seats_left' name='seats_left' value='" + 
		result.getString("Seats_Left") + "' readonly>");
		out.println("<br>");
		
		out.println("<label for='airline_id'> Airline: </label> ");
		out.println("<input type='text' id='airline_id' name='airline_id' value='"+
		result.getString("Airline_ID") + "' readonly>");
		out.println("<br>");
		
		out.println("<label for='flight_class'> Flight Class: </label> ");
		out.println("<input type='text' id='flight_class' name='flight_class' value='"+
		result.getString("Flight_Class") + "' readonly>");
		out.println("<br>");
		
		out.println("<label for='price'> Price: </label> ");
		out.println("<input type='text' id='price' name='price' value='"+
		result.getString("Price") + "' readonly>");
		out.println("<br>");
		
		
		
		
		
		out.println("<input type='submit' value='Buy Now'>");
		out.println(" </form> ");
		out.println("<br>");
		out.println("<br>");
		
		/*
		out.print("<div>");
		out.println("Flight Number:" + result.getString("Flight_Number"));
		out.println("<br>");
		out.println(result.getString("Departure_Airport") + " ->" + result.getString("Arrival_Airport"));
		out.println("<br>");
		out.println("Leave on:" + result.getString("Departure_Date") + " at " + result.getString("Departure_Time"));
		out.println("<br>");
		out.println("Land on:" + result.getString("Arrival_Date") + " at " + result.getString("Arrival_Time"));
		out.println("<br>");
		out.priantln("Flight Class:" + result.getString("Flight_Class"));
		out.println("<br>");
		out.println(result.getString("stops") + " stops.");
		out.println("<br>");
		out.println(result.getString("Seats_Left") + " seats left.");
		out.println("<br>");
		out.println(result.getString("Booking_Fee"));
		out.println("<br>");
		out.println("<a href='#'>" + "Buy Now" + "</a>");
		out.println("<br>");
		out.print("</div>");
		out.println("<br>");
		out.println("<br>");
		*/
	}
	//out.println(str);
	//con.close();
	
	
	
	
	
	}
	catch (Exception e){
		out.println("Some error occured or no available flights that match your search are available.");
		
	}
	%>
	
	
	</body>
</html>