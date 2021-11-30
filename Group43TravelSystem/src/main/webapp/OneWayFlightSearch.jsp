<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>Search One Way Flights</title>
	</head>
	<body>	
		<form action="OneWaySearchResults.jsp">
            <label for="departure_airport">From</label>
            <select name="departure_airport">
                <option value="EWR">EWR-Newark</option>
                <option value="MIA">MIA-Miami</option>
                <option value="LAX">LAX-Los Angeles</option>
            </select>

            <label for="arrival_airport">To</label>
            <select name="arrival_airport">
                <option value="EWR">EWR-Newark</option>
                <option value="MIA">MIA-Miami</option>
                <option value="LAX">LAX-Los Angeles</option>
            </select>

            <br>
            <label for="departure_date">Departure Date</label>
            <input type="date" id="departure_date" name="departure_date">
            <br>
            <p>Flexible dates +/- 3 days?</p>
            <label for="yes">Yes</label>
            <input type="radio" id="yes" name="answer" value="yes">
            <br>
            <label for="no"> No</label>
            <input type="radio" id="no" name="answer" value="no">
            <br>
            <label for="sort_selection">Sort by</label>
            <select name="sort_selection" id="sort_selection">
                <option value="no_sort">None</option>
                <option value="price_high_to_low">Price High to Low</option>
                <option value="price_low_to_high">Price Low to High</option>
                <option value="take_off_time">Take off Time</option>
                <option value="landing_time">Landing Time</option>
                <option value="flight_Duration">Flight Duration</option>
            </select>
            
            <label for="filter_selection">Filter by</label>
            <select name="filter_selection" id="filter_selection">
                <option value="no_filter">None</option>
                <option value="price_tier1">$0-$149.99</option>
                <option value="price_tier2">$150-$299.99</option>
                <option value="price_tier3">$300+</option>
                <option value="no_stops">No Stops</option>
                <option value="takeoff_am">Morning Takeoff AM</option>
                <option value="takeoff_pm">Afternoon Takeoff PM</option>
                <option value="landing_am">Morning Landing AM</option>
                <option value="landing_pm">Afternoon Landing PM</option>
            </select>
            <br>
            <input type="submit" value="submit">
            <br>
        </form>
	
		
	
	</body>
</html>