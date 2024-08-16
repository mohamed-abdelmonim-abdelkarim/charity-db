create database Charity_Z
use charity_z
create schema donor_manage;
create schema benefici_manage;
create schema projects_manage;

create table donor_manage.donors 
(
donor_id int identity(1,1) primary key,
fullname varchar(70)not null,
address varchar(50),
phone_number varchar(25)not null,
email varchar(255) not null UNIQUE,
registration_date date not null default getdate(),
);

create table donor_manage.donations
(
donation_id int identity(1,1) primary key,
amount money not null,
donation_date date not null default getdate(),
donation_type varchar(50)not null,
donor_id int not null,
foreign key(donor_id) references donor_manage.donors 
(donor_id)on delete CASCADE on UPDATE CASCADE
);

create table benefici_manage.beneficiaries
(
benef_id int identity (1,1) primary key ,
fullname varchar(70) not null UNIQUE,
address varchar(100) not null,
phone_number varchar(20) not null UNIQUE,
assistance_type varchar(20) not null,
registr_date date not null default getdate()
);
create table benefici_manage.aidprovided
(
aid_id int identity(1,1) primary key,
assistance_type varchar(20) not null,
amount money not null,
aid_date date not null default getdate(),
benefi_id int not null,
foreign key(benefi_id) references benefici_manage.beneficiaries
(benef_id)on delete CASCADE on UPDATE CASCADE
);

create table projects_manage.projects
(
project_id int identity(1,1) primary key,
project_name varchar(50) not null ,
project_description varchar(255)not null,
start_date date not null default getdate(),
expectes_date date not null default getdate(),
budget money not null
); 

create table projects_manage.project_funding
(
funding_id int identity(1,1) primary key,
project_id int not null,
amount money not null,
funding_date date not null default getdate(),
foreign key(project_id) references projects_manage.projects 
(project_id)on delete CASCADE on UPDATE CASCADE
);

create table projects_manage.volunteers 
(
volunteer_id int identity(1,1) primary key,
fullname varchar(70) not null UNIQUE,
address varchar(100) not null,
phone_number varchar(20) not null UNIQUE,
email varchar(255) not null UNIQUE,
joining_date date not null default getdate(),
);

create table projects_manage.volunteer_participation
(
participation_id int identity(1,1) primary key,
volunteer_id int not null,
project_id int not null,
participation_date date not null default getdate(),
foreign key(volunteer_id) references projects_manage.volunteers 
(volunteer_id)on delete CASCADE on UPDATE CASCADE,
foreign key(project_id) references projects_manage.projects
(project_id)on delete CASCADE on UPDATE CASCADE,
);
