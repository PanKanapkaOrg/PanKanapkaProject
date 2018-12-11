USE master
GO
IF EXISTS (
  SELECT name
   FROM sys.databases
   WHERE name = N'PanKanapka'
)
DROP DATABASE PanKanapka
GO
CREATE DATABASE PanKanapka
GO
use PanKanapka
go

create table [Authentication]
(
	ID bigint identity(1,1) not null,
	mail nvarchar(max) not null,
	pass varchar(255) not null,
	role varchar(10) not null,
	Constraint PK_Authentication_ID Primary Key(ID)
) 
go

create table [CateringFirms]
(
	ID bigint identity(1,1) not null,
	name varchar(255) not null,
	address varchar(255) not null,
	info varchar(max) not null,
	logoUrl varchar(max) not null,
	Constraint PK_CateringFirms_ID Primary Key(ID)
)

go

create table [Workers]
(
	ID bigint identity(1,1) not null,
	name varchar(255) not null,
	surname varchar(255) not null,
	AuthID bigint not null,
	CateringFirmID bigint not null,
	Constraint PK_Workers_ID Primary Key(ID),
	Constraint FK_Workers_AuthID Foreign Key (AuthID) references Authentication(ID),
	Constraint FK_Workers_CateringFirmID Foreign Key (CateringFirmID) references CateringFirms(ID)
)
go

create table [Managers]
(
	ID bigint identity(1,1) not null,
	name varchar(255) not null,
	surname varchar(255) not null,
	AuthID bigint not null,
	CateringFirmID bigint not null,
	Constraint PK_Managers_ID Primary Key(ID),
	Constraint FK_Managers_AuthID Foreign Key (AuthID) references Authentication(ID),
	Constraint FK_Managers_CateringFirmID Foreign Key (CateringFirmID) references CateringFirms(ID)
)

go

create table ClientFirms
(
	ID bigint identity(1,1) not null,
	name varchar(255) not null,
	address varchar(255) not null,
	logoUrl varchar(max) not null,
	City varchar(255) not null,
	DayOfWork tinyint not null,
	Constraint PK_ClientFirms_ID Primary Key(ID)
)


go

create table Clients
(
	ID bigint identity(1,1) not null,
	name varchar(255) not null,
	surname varchar(255) not null,
	clientFirmID bigint not null,
	AuthID bigint not null,
    Constraint PK_Clients_ID Primary Key(ID),
	Constraint FK_Clients_AuthID Foreign Key (AuthID) references Authentication(ID),
	Constraint FK_Clients_clientFirmID Foreign Key (clientFirmID) references clientFirms(ID)
)
go

create table Tasks
(
	ID bigint identity(1,1) not null,
	clientFirmID bigint not null,
	isDone bit default(0) not null,
	taskDate date not null,
	workerID bigint not null,
	Constraint PK_Tasks_ID Primary Key(ID),
	Constraint FK_Tasks_clientFirmID Foreign Key (clientFirmID) references clientFirms(ID),
	Constraint FK_Tasks_workerID Foreign Key (workerID) references Workers(ID),
)


go


create table Foods
(
	ID bigint identity(1,1) not null,
	cateringFirmID bigint not null,
	price real not null, 
	foodname varchar(max) not null,
	fooddescription varchar(max) not null,
	imageURL varchar(max) not null,
	isVegan	bit not null
	Constraint PK_Foods_ID Primary Key(ID),
	Constraint FK_Foods_CateringFirmID Foreign Key (CateringFirmID) references CateringFirms(ID)
)

go

create table Reservation
(
	ID bigint identity(1,1) not null,
	reservationDate date not null,
	clientID bigint not null,
	foodID bigint not null,
	quantity smallint not null,
	isActive bit not null default(1),
	Constraint PK_Reservation_ID Primary Key(ID),
	Constraint FK_Reservation_clientID Foreign Key (clientID) references Clients(ID),
	Constraint FK_Reservation_foodID Foreign Key (foodID) references Foods(ID)
)

go 

create table CateringFirmClientFirm
(
cateringFirmID bigint not null,
clientFirmID bigint not null,
Constraint FK_CateringFirmClientFirm_cateringFirmID Foreign Key (cateringFirmID) references CateringFirms(ID),
Constraint FK_CateringFirmClientFirm_clientfirmID Foreign Key (clientfirmID) references ClientFirms(ID)
)

Insert Into [Authentication] values ('Jan_Kowalski@gmail.com','abcdef','Manager'),
('Adam_Nowak@mail.com','abcdef','Manager'),
('Marta_Wieczorek@mail.com','abcdef','Client'),
('Paweł_Wiśniewski@mail.com','abcdef','Client'),
('Aleksandra_Pawlik@mail.com','abcdef','Client'),
('Jakub_Paluch@mail.com','abcdef','Client'),
('Jakub_Nowak@mail.com','abcdef','Client'),
('Maksymilian_Kozioł@mail.com','abcdef','Worker'),
('Wiktor_Lewandowski@mail.com','abcdef','Worker'),
('Emilia_Kowalska@mail.com','abcdef','Worker'),
('Igor_Czarnecki@mail.com','abcdef','Client'),
('Oliwia_Dąbrowska@mail.com','abcdef','Client'),
('Dominika_Wróblewska@mail.com','abcdef','Client'),
('Gabriela_Chrzanowska@mail.com','abcdef','Client'),
('Sebastian_Nowak@gmail.com','abcdef','Worker'),
('Justyna_mis@mail.com','abcdef','Worker'),
('nowy@mail.com','abcdef','Worker')


insert into [CateringFirms] values
('Bon-Appetit','Dostawcza 7','info','tutajbedzielogo'),
('Smakus','Sterlinga 22','info','tutajbedziekolejnelogo')

insert Into [Managers] values
('Jan','Kowalski','1','1'),
('Adam','Nowak','2','2')

insert into [Workers] values
('Maksymilian','Kozioł',8,1),
('Wiktor','Lewandowski',9,2),
('Emilia','Kowalska',10,1),
('Sebastian','Nowak',15,1),
('Justyna','Miśkiewicz',16,1),
('Anna','Sęk',17,1)

insert into [ClientFirms] values
('Hummingbird Corp','Traktorowa 17','https://media.licdn.com/dms/image/C560BAQEFce4b65Jt3w/company-logo_200_200/0?e=2159024400&v=beta&t=KxSQhD54dT3H2YwCHyzqWmY0-GFaxnXvyB79IC22bpM', 'Lódź'),
('Micro Industries','Gdańska 12','https://media.glassdoor.com/sqll/106487/micro-industries-squarelogo-1461240302453.png', 'Lódź'),
('Prime Solutions','Łąkowa 22','logo', 'Lódź'),
('Butterflyght','Dostawcza 12','logo', 'Lódź')
('Fujitsu','Fabryczna 17 ','logo', 'Lódź',168),
('Barry Callebaut','Wolczanska 180','logo', 'Lódź', 64),
('TME','Ustronna 41','logo', 'Lódź', 32),
('Coats','Kaczeńcowa 16','logo', 'Lódź',96)

insert into [Clients] values
('Marta','Wieczorek',1,3),
('Paweł','Wisniewski',1,4),
('Aleksandra','Pawlik',1,5),
('Jakub','Paluch',2,6),
('Jakub','Nowak',2,7),
('Igor','Czarnecki',3,11),
('Oliwia','Dąbrowska',3,12),
('Dominika','Wróblewska',3,13),
('Gabriela','Chrzanowska',4,14)

insert into [CateringFirmClientFirm] values
(1,1),(1,3),(1,4),(2,1),(2,2),(1,5),(1,6),(1,7),(1,8)

insert into [Foods] values
(1,4.00,'Kanapka z serem i szynką','Chleb razowy, masło, sałata, ser, szynka','http://www.cateringservice.com.pl/cache/50/pr/png/460_x/15317288201531728820.png',0),
(1,5.00,'Kanapka z kurczakiem','Chleb razowy, masło, sałata, pomidor, kurczak','http://www.cateringservice.com.pl/cache/50/pr/png/460_x/15274889771527488977.png',0),
(1,7.50,'Kanapka z tuńczykiem','Chleb żytni, margaryna, tuńczyk, jajko, majonez, natka pietruszki','http://www.cateringservice.com.pl/cache/50/pr/png/460_x/14495777241449577724.png',0),
(2,8.00,'Kanapka z tofu','Chleb razowy, masło, tofu, pomidor, papryka, rukola','http://www.cateringservice.com.pl/cache/50/pr/png/460_x/14531960421453196042.png',1),
(2,3.00,'Kanapka z serem','Chleb pszenny, masło, sałata, pomidor, ser','http://www.cateringservice.com.pl/cache/50/pr/png/460_x/15317287481531728748.png',1)

insert into [Reservation] values
('2018-11-01',1,2,3,1),
('2018-10-31',3,3,1,1),
('2018-10-28',4,5,2,1),
('2018-10-27',5,5,3,1),
('2018-10-29',5,4,1,1),
('2018-10-27',5,4,2,1),
('2018-10-27',5,4,3,1),
('2018-10-28',5,5,6,1),
('2018-10-27',7,1,4,1)

insert into [Tasks] values
(1,0,'2018-10-27',3),
(1,0,'2018-10-27',2),
(2,0,'2018-10-27',2),
(3,0,'2018-10-27',1),
(4,0,'2018-10-27',1),
(7,0,'2018-10-29',6),
(6,0,'2018-10-30',5),
(7,0,'2018-10-31',1),
(6,0,'2018-10-27',1),
(8,0,'2018-10-28',6)


-- Przykładowa kwerenda wyświetlajaca wszystkie zamówienia na dzisiejszy dzień - sumuje zamówienia tej samej osoby na tą samą rzecz
select cf.name,c.name +' '+ c.surname as FullName,f.foodname,sum(r.quantity) as ilosc,cat.name,r.reservationDate from Reservation as r
join Clients as c on c.ID=r.clientID
join ClientFirms as cf on cf.ID=c.clientFirmID
join Foods as f on f.ID=r.foodID
join CateringFirms as cat on cat.ID=f.cateringFirmID
--where r.reservationDate Like convert (date,getdate()) and r.isActive like 1   na dzisiejszy dzien zamowienia 
Group by cf.name,f.foodname,cat.name,r.reservationDate,c.name +' '+ c.surname
order by cat.name,reservationDate



-- wszystkie przydzielone taski dla dany dzien
select w.name+ ' '+ w.surname, t.taskDate,cf.name,c.name+' ' +c.surname, f.foodname,r.quantity from workers as w
right join tasks as t on t.workerID=w.ID
join ClientFirms as cf on cf.ID=t.clientFirmID
join Clients as c on c.clientFirmID=cf.ID
join Reservation as r on r.clientID=c.ID
join Foods as f on f.ID=r.foodID
join CateringFirms as cat on cat.ID=w.CateringFirmID
where f.cateringFirmID LIKE w.CateringFirmID and taskDate like reservationDate


-- powiązania firm klienckich i kateringowych 
select cf.name,cat.name from CateringFirmClientFirm as c				
join ClientFirms as cf on cf.ID=c.clientFirmID
join CateringFirms cat on cat.ID=c.cateringFirmID


-- TODO  ułożenie ważnych kwerend ( wyświetl wszystkie firmy z zamóieniami na dany dzień gdzie nie został jeszcze przydzielony task do żadnego workera dla danej firmy itp.)


select * from Tasks


select w.ID as WorkerId, w.name as WorkerName, w.surname as WorkerSurname, 
t.taskDate as TaskDate, cf.logoUrl as LogoUrl, cf.City as ClientFirmCity, cf.name as ClientFirmName, 
cf.address as Address, t.isDone as IsDone 
from Tasks t 
join Workers w on w.ID = t.workerID join ClientFirms cf on cf.ID = t.clientFirmID 
where w.ID in (1,2,3) and t.taskDate between CONVERT(DATETIME, '2018-10-27', 102)-1 and CONVERT(DATETIME, '2018-10-27', 102)+1; 


--Procedura logowania
create or alter procedure LoginProcedure @mail varchar(50), @password varchar(50)
as
declare @role varchar(20);
declare @auth bigint;

select @role = role, @auth = ID
from Authentication 
where mail=@mail and pass=@password;
	
begin
	if @role = 'Manager'  
	begin
	select @auth as AuthId, m.ID as Id, @role as Role, m.name as Name, m.surname as Surname, CateringFirmID as FirmId, c.name as FirmName, c.address as Address, c.info as Info, c.logoUrl as LogoUrl, null as DayOfWork
	from Managers m
	join CateringFirms c on m.CateringFirmID=c.ID 

	end
	else if @role = 'Worker'
	begin
		select @auth as AuthID, w.ID as Id, @role as Role, w.name as Name, surname as Surname, CateringFirmID as FirmId,
		c.name as FirmName, c.address as Address, c.info as Info, c.logoUrl as LogoUrl, null as DayOfWork
		from Workers w
		join CateringFirms c on w.CateringFirmID=c.ID 
		where AuthID = @auth
	end
	else if @role ='Client'
	begin
		select @auth as AuthId, c.ID as Id, @role as Role, cl.name as Name, surname as Surname, ClientFirmID as FirmId,
		c.name as FirmName, c.address as Address, null as Info, c.logoUrl as LogoUrl, c.DayOfWork as DayOfWork
		from Clients cl
		join ClientFirms c on cl.clientFirmID=c.ID 
		where AuthID = @auth
	end
end