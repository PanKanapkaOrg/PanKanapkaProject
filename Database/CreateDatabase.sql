go 

create table Authentication
(
	ID bigint primary key identity(1,1) not null,
	mail nvarchar(max) not null,
	pass varchar(255) not null,
	role varchar(10) not null,
)
go

create table CateringFirms
(
	ID bigint primary key identity(1,1) not null,
	name varchar(255) not null,
	address varchar(255) not null,
	info varchar(max) not null,
	logoUrl varchar(max) not null,
	DayOfWork tinyint not null,	
)

go

create table Workers
(
	ID bigint primary key identity(1,1) not null,
	name varchar(255) not null,
	surname varchar(255) not null,
	AuthID bigint not null foreign key references Authentication(ID),
	CateringFirmID bigint not null foreign key references CateringFirms(ID)
)
go

create table Managers
(
	ID bigint primary key identity(1,1) not null,
	name varchar(255) not null,
	surname varchar(255) not null,
	AuthID bigint not null foreign key references Authentication(ID),
	CateringFirmID bigint not null foreign key references CateringFirms(ID)
)

go

create table ClientFirms
(
	ID bigint primary key identity(1,1) not null,
	name varchar(255) not null,
	address varchar(255) not null,
	logoUrl varchar(max) not null,
	
)


go

create table Clients
(
	ID bigint primary key identity(1,1) not null,
	name varchar(255) not null,
	surname varchar(255) not null,
	clientFirmID bigint not null foreign key references ClientFirms(ID),
	AuthID bigint not null foreign key references Authentication(ID)
)
go

create table Tasks
(
	ID bigint primary key identity(1,1) not null,
	clientFirmID bigint not null foreign key references ClientFirms(ID),
	isDone bit not null default(0),
	taskDate date not null,
	workerID bigint not null foreign key references Workers(ID),

)


go


create table Foods
(
	ID bigint primary key identity(1,1) not null,
	cateringFirmID bigint not null foreign key references CateringFirms(ID),
	price real not null, 
	foodname varchar(max) not null,
	fooddescription varchar(max) not null,
	imageURL varchar(max) not null,
	isVegan	bit not null
)

go

create table Reservation
(
	ID bigint primary key identity(1,1) not null,
	reservationDate date not null,
	clientID bigint not null foreign key references Clients(ID),
	foodID bigint not null foreign key references Foods(ID),
	quantity smallint not null,
	isActive bit not null default(1)
)

go 

create table CateringFirmClientFirm
(
cateringFirmID bigint not null foreign key references CateringFirms(ID),
clientFirmID bigint not null foreign key references ClientFirms(ID),
)