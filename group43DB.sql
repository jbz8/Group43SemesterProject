create database cs336Group43;
use cs336Group43;

create table if not exists Users(
	First_Name varchar(45),
    Last_Name varchar(45),
    Email varchar(45),
    Password varchar(45),
    Account_Type varchar(45),
    Primary key(Email)
    );

insert into Users(First_Name,Last_Name,
Email,Password,Account_Type) values
('John','Smith','customer1@gmail.com','password','customer'),
('Mark','Williams','admin1@gmail.com','password','Admin'),
('Peter','R.','customerRep1@gmail.com','password','Customer_Representative');


create table if not exists Airport(
	Airport_ID varchar(3),
    Primary key(Airport_ID)
    );
    
create table if not exists Airline(
	Airline_ID varchar(2),
    Primary key(Airline_ID)
    );
    
create table if not exists Aircraft(
	Aircraft_ID varchar(45),
    number_of_seats int,
    schedule varchar(70),
    primary key(Aircraft_ID)
    );

create table if not exists Owns(
	Airline_ID varchar(2),
    Aircraft_ID varchar(45),
    primary key(Aircraft_ID,Airline_ID),
    foreign key (Airline_ID) references Airline(Airline_ID),
    foreign key(Aircraft_ID) references Aircraft(Aircraft_ID)
    );
    
create table if not exists Belongs_To(
	Airport_ID varchar(3),
    Airline_ID varchar(2),
    Aircraft_ID varchar(45),
    primary key(Airport_ID,Airline_ID,Aircraft_ID),
    foreign key(Airport_ID) references Airport(Airport_ID),
    foreign key(Airline_ID,Aircraft_ID)
    references Owns(Airline_ID,Aircraft_ID)
    );
    
create table if not exists Flights(
	Flight_Number int,
    Flight_Type varchar(15),
    Departure_Time varchar(15),
    Departure_Airport varchar(3),
    Arrival_Time varchar(15),
    Arrival_Airport varchar(3),
    Primary key(Flight_Number)
    );
    
create table if not exists Operates(
	Flight_Number int,
    Airline_ID varchar(2),
    Aircraft_ID varchar(45),
    primary key(Flight_Number,Airline_ID,Aircraft_ID),
    foreign key(Flight_Number) references 
    Flights(Flight_Number),
    foreign key(Airline_ID,Aircraft_ID) references 
    Owns(Airline_ID,Aircraft_ID));
create table if not exists Ticket(
	Ticket_Number int,
    Seat_Number int,
    total_fare real,
    Purchase_Date date,
    Purchase_Time time,
    Departure_Airport varchar(3),
    Departure_Date date,
    Arrival_Date date,
	Arrival_Airport varchar(3),
    class varchar(10),
    First_Name varchar(45),
    Last_Name varchar(45),
    Booking_Fee real,
    primary key(Ticket_Number)
    );

create table if not exists Associated_With(
	Flight_Number int,
    Ticket_Number int,
    Primary key(Ticket_Number),
    foreign key(Flight_Number) references 
    Flights(Flight_Number),
    foreign key(Ticket_Number) references 
    Ticket(Ticket_Number)
    );
    
create table if not exists Buys(
	Change_or_cancel_fee real,
    email varchar(45),
    Ticket_Number int,
    Primary key(Ticket_Number),
    foreign key(Ticket_Number) references
    Ticket(Ticket_Number),
    foreign key(email) references Users(email)
    );
    
create table if not exists Waiting_List(
	email varchar(45),
    Flight_Number int,
    primary key(email,Flight_Number),
    foreign key(email)
    references Users(email),
    foreign key (Flight_Number)
    references Flights(Flight_Number)
    );
    

    

    

    
    
    
