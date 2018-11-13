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
('Gabriela_Chrzanowska@mail.com','1345qwe','Client')


insert into [CateringFirms] values
('Bon-Appetit','Dostawcza 7','info','tutajbedzielogo',254),
('Smakus','Sterlinga 22','info','tutajbedziekolejnelogo',252)

insert Into [Managers] values
('Jan','Kowalski','1','1'),
('Adam','Nowak','2','2')

insert into [Workers] values
('Maksymilian','Kozioł',8,1),
('Wiktor','Lewandowski',9,2),
('Emilia','Kowalska',10,1)

insert into [ClientFirms] values
('Hummingbird Corp','Traktorowa 17','logo', 'Lódź'),
('Micro Industries','Gdańska 12','logo', 'Lódź'),
('Prime Solutions','Łąkowa 22','logo', 'Lódź'),
('Butterflyght','Dostawcza 12','logo', 'Lódź')


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
(1,1),(1,3),(1,4),(2,1),(2,2)

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
(4,0,'2018-10-27',1)


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


