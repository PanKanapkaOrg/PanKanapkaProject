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
	DayOfWork tinyint not null,
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
('Adam_Nowak@mail.com','123456*','Manager'),
('Marta_Wieczorek@mail.com','8is&kKK','Client'),
('Paweł_Wiśniewski@mail.com','P[(jjKS','Client'),
('Aleksandra_Pawlik@mail.com','a233DDqwe','Client'),
('Jakub_Paluch@mail.com','qazSWX23','Client'),
('Jakub_Nowak@mail.com','1345qwe','Client'),
('Maksymilian_Kozioł@mail.com','work1234','Worker'),
('Wiktor_Lewandowski@mail.com','xze1234','Worker'),
('Emilia_Kowalska@mail.com','1345qwe','Worker'),
('Igor_Czarnecki@mail.com','17wu89','Client'),
('Oliwia_Dąbrowska@mail.com','qwe123','Client'),
('Dominika_Wróblewska@mail.com','1345qwe','Client'),
('Gabriela_Chrzanowska@mail.com','1345qwe','Client'),
('Sebastian_Nowak@gmail.com','abcdef','Worker'),
('Justyna_mis@mail.com','123456*','Worker'),
('nowy@mail.com','8is&kKK','Worker')


insert into [CateringFirms] values
('Bon-Appetit','Dostawcza 7','info','tutajbedzielogo',254),
('Smakus','Sterlinga 22','info','tutajbedziekolejnelogo',252)

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
('Prime Solutions','Łąkowa 22','https://media.glassdoor.com/sqll/423197/prime-solutions-squarelogo-1441868871543.png', 'Lódź'),
('Butterflyght','Dostawcza 12','http://healthdotcom.in/UploadImage/WC5SIez3.jpg', 'Lódź'),
('Fujitsu','Fabryczna 17 ','https://cdn.iconscout.com/icon/free/png-256/fujitsu-285143.png', 'Lódź'),
('Barry Callebaut','Wolczanska 180','data:image/png;base64,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', 'Lódź'),
('TME','Ustronna 41','http://inveo.com.pl/wp-content/uploads/2018/01/TME-logo.png', 'Lódź'),
('Coats','Kaczeńcowa 16','https://pertay.pl/wp-content/uploads/2016/12/coats-logo-mini.png', 'Lódź')


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
(1,4.00,'Kanapka z serem i szynką','Chleb razowy, masło, sałata, ser, szynka','img',0),
(1,5.00,'Kanapka z kurczakiem','Chleb razowy, masło, sałata, pomidor, kurczak','img',0),
(1,7.50,'Kanapka z tuńczykiem','Chleb żytni, margaryna, tuńczyk, jajko, majonez, natka pietruszki','img',0),
(2,8.00,'Kanapka z tofu','Chleb razowy, masło, tofu, pomidor, papryka, rukola','img',1),
(2,3.00,'Kanapka z serem','Chleb pszenny, masło, sałata, pomidor, ser','img',1)

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
go
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
		select @auth as AuthId, m.ID as Id, @role as Role, m.name as Name, m.surname as Surname, CateringFirmID as FirmId,
		c.name as FirmName, c.address as Address, c.info as Info, c.logoUrl as LogoUrl, null as DayOfWork
		from Managers m
		join CateringFirms c on m.CateringFirmID=c.ID 
		where AuthID = @auth
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
		c.name as FirmName, c.address as Address, null as Info, c.logoUrl as LogoUrl, null as DayOfWork
		from Clients cl
		join ClientFirms c on cl.clientFirmID=c.ID 
		where AuthID = @auth
	end
end



