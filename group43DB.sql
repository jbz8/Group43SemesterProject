create database cs336Group43;
use cs336Group43;
 -- drop table Users,Airport,Airline,Aircraft,Owns,Belongs_To,
  -- Flights,Operates,Ticket,Associated_With,Buys,Waiting_List;

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
    Departure_Airport varchar(3),
    Departure_Date date,
    Departure_Time time,
    Arrival_Airport varchar(3),
    Arrival_Date date,
    Arrival_Time time,
    Flight_Type varchar(15),
    Flight_Class varchar(15),
    Price real,
    Seats_Left int,
    stops int,
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
	Airline_ID varchar(2),
	Ticket_Number int,
    Seat_Number int,
    Purchase_Date date,
    Purchase_Time time,
    Departure_Airport varchar(3),
    Departure_Date date,
    Departure_Time time,
	Arrival_Airport varchar(3),
    Arrival_Date date,
    Arrival_Time time,
	Ticket_Class varchar(15),
    First_Name varchar(45),
    Last_Name varchar(45),
    Booking_Fee real,
    Total_Fare real,
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
-- select * from Users;

-- three sample airport names , 3 sample airline names , and ten aircraft id's
insert into Airport(Airport_ID) values
('EWR'),('MIA'),('LAX');
insert into Airline(Airline_ID) values
('AA'),('DL'),('EK');
 insert into Aircraft(Aircraft_ID) values
 ('AC1'),('AC2'),('AC3'),('AC4'),('AC5'),('AC6'),
 ('AC7'),('AC8'),('AC9'),('AC10'),
  ('AC11'),('AC12'),('AC13'),('AC14'),
   ('AC15'),('AC16'),('AC17'),('AC18');
 insert into Owns(Airline_ID,Aircraft_ID) 
 values ('AA','AC1'),('DL','AC2'),('EK','AC3'),
 ('EK','AC4'),('AA','AC5'),('DL','AC6'),
 ('EK','AC7'),('EK','AC8'),('AA','AC9'),('AA','AC10'),
  ('AA','AC11'),('DL','AC12'),('AA','AC13'),('EK','AC14'),
   ('EK','AC15'),('DL','AC16'),('DL','AC17'),('DL','AC18');
 -- 
 insert into Flights(Flight_Number,Departure_Airport,Departure_Date,Departure_Time,
 Arrival_Airport,Arrival_Date,Arrival_Time,
 Flight_Type,Flight_Class,Price,Seats_Left,stops) values
 
 (1,'EWR','2021-12-05','08:00:00','MIA','2021-12-05','11:30:00','domestic','economy',
 50.50,0,0),
  (2,'EWR','2021-12-05','08:00:00','LAX','2021-12-05','13:30:00','domestic','economy',
 75.50,5,0),
  (3,'EWR','2021-12-05','12:00:00','MIA','2021-12-05','15:30:00','domestic','business',
 150.50,5,0),
  (4,'EWR','2021-12-05','12:00:00','LAX','2021-12-05','17:30:00','domestic','business',
 137.50,5,0),
  (5,'EWR','2021-12-05','15:00:00','MIA','2021-12-05','18:30:00','domestic','first',
 320.99,5,0),
  (6,'EWR','2021-12-05','15:00:00','LAX','2021-12-05','20:30:00','domestic','first',
 310.85,5,0),
 
  (7,'MIA','2021-12-05','08:00:00','EWR','2021-12-05','11:30:00','domestic','economy',
 65.00,5,0),
  (8,'MIA','2021-12-05','08:00:00','LAX','2021-12-05','13:30:00','domestic','economy',
 83.50,5,0),
   (9,'MIA','2021-12-05','13:00:00','EWR','2021-12-05','16:30:00','domestic','business',
 165.00,5,0),
  (10,'MIA','2021-12-05','13:00:00','LAX','2021-12-05','18:30:00','domestic','business',
 153.50,5,0),
   (11,'MIA','2021-12-05','14:00:00','EWR','2021-12-05','17:30:00','domestic','first',
 200.00,5,0),
  (12,'MIA','2021-12-05','14:00:00','LAX','2021-12-05','19:30:00','domestic','first',
 300.50,5,0),
 
  (13,'LAX','2021-12-05','09:30:00','EWR','2021-12-05','14:30:00','domestic','economy',
 320.50,5,0),
  (14,'LAX','2021-12-05','10:30:00','MIA','2021-12-05','15:30:00','domestic','economy',
 310.65,5,0),
   (15,'LAX','2021-12-05','11:00:00','EWR','2021-12-05','16:30:00','domestic','business',
 320.50,5,0),
  (16,'LAX','2021-12-05','12:00:00','MIA','2021-12-05','17:30:00','domestic','business',
 310.65,5,0),
  (17,'LAX','2021-12-05','13:00:00','EWR','2021-12-05','19:30:00','domestic','first',
 320.50,5,0),
  (18,'LAX','2021-12-05','14:00:00','MIA','2021-12-05','22:30:00','domestic','first',
 310.65,5,1);
 
insert into Operates(Flight_Number,Airline_ID,Aircraft_ID) values
(1,'AA','AC1'),(2,'DL','AC2'),(3,'EK','AC3'),
 (4,'EK','AC4'),(5,'AA','AC5'),(6,'DL','AC6'),
 (7,'EK','AC7'),(8,'EK','AC8'),(9,'AA','AC9'),(10,'AA','AC10'),
  (11,'AA','AC11'),(12,'DL','AC12'),(13,'AA','AC13'),(14,'EK','AC14'),
   (15,'EK','AC15'),(16,'DL','AC16'),(17,'DL','AC17'),(18,'DL','AC18');
   
 -- select * from Ticket;
 insert into Ticket(Airline_ID,Ticket_Number,Seat_Number,
    Purchase_Date,Purchase_Time,Departure_Airport,
    Departure_Date,Departure_Time,Arrival_Airport,
    Arrival_Date,Arrival_Time,Ticket_Class,First_Name,
    Last_Name,Booking_Fee,Total_Fare) values(
    'AA',1,1,
    '2021-11-11','18:40:00','EWR',
    '2021-11-20','08:45:00','LAX',
    '2021-11-20','14:55:00','economy','John',
    'Smith',25.00,75.00);
    
-- select * from Associated_With;
--  select * from Flights where Flight_Number=1;
-- select * from Waiting_List;
 
 -- select * from Ticket
 -- where Departure_Date > curdate() and First_Name = 'John' and Last_Name='Smith';