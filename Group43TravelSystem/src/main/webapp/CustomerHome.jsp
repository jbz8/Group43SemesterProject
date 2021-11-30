<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
	<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>Home</title>
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
	<div>
            <div>
                <a href="OneWayFlightSearch.jsp">Search One Way Flights</a>
            </div>
            <br>
            <div>
                <a href="RoundTripFlightSearch.jsp">Search Round Trip Flights</a>
            </div>
            <br>
            <div>
                <a href="CheckFlightHistory.jsp">View Flight History</a>
            </div>
			<br>
            <div>
                <a href="CheckUpcomingFlights.jsp">Check Upcoming Flights</a>
            </div>
            <br>
            <div>
                <a href="CheckWaitingList.jsp">My Waiting List</a>
            </div>
            <br>
            <div>
                <a href="QuestionsAndAnswersPage.jsp">Questions and Answers</a>
            </div>
            <br>
            <div>
                <a href="#">Ask a question</a>
            </div>
            <br>
            
        </div>
	<a href='logout.jsp'>Click here to logout.</a>
	
	</body>
</html>