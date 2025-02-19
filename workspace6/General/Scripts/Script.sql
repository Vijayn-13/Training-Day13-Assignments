create table authors(
	author_id integer not null Primary key,
	first_name varchar(100),
	last_name varchar(100),
	date_of_birth date,
	nationality varchar(50)
);

create table members(
	member_id integer not null Primary key,
	first_name varchar(100),
	last_name varchar(100),
	date_of_birth date,
	contact_number numeric(10),
	email varchar(50),
	membership_date date
);

create table staff(
	staff_id integer not null Primary key,
	first_name varchar(100),
	last_name varchar(100),
	position varchar(100),
	contact_number numeric(10),
	email varchar(50),
	hire_date date
);

create table books(
	book_id integer not null Primary key,
	title varchar(100),
	author_id integer,
	Foreign Key(author_id) References authors(author_id),
	publication_year numeric(4),
	genre varchar(100),
	isbn numeric(20),
	available_copies integer
);

select * from information_schema.columns where table_schema='public' and table_name='books'; 

create table loans(
	loan_id integer not null Primary key,
	loan_date date,
	return_date date,
	actual_return_date date
);

alter table loans add column book_id integer;

alter table loans add constraint fk1 foreign key(book_id) references books(book_id);

alter table loans add column member_id integer;

alter table loans add constraint fk2 foreign key(member_id) references members(member_id);

select*from loans;

--ddl qn2
alter table staff rename column position to job_title;

select*from staff;

select*from members;

--ddl qn3
alter table members drop column email;

select*from members;

select*from authors;

insert into authors(author_id,first_name,last_name,date_of_birth,nationality) values(1,'robert','jr','1956-12-07','american');

insert into authors(author_id,first_name,last_name,date_of_birth,nationality) values(2,'david','wise','1940-08-17','italian'),(4,'harry','potter','1977-02-07','american'),(5,'william','kane','1889-10-08','indian'),(9,'jackson','roy','2002-10-24','indian');

select*from authors;

select*from books;

--dml qn1
insert into books(book_id ,title ,author_id ,publication_year ,genre ,isbn ,available_copies ) values(1,'life of pi',4,1997,'survival',3224217658,10);

select*from books;

insert into books(book_id ,title ,author_id ,publication_year ,genre ,isbn ,available_copies ) values(2,'game of clash',2,1975,'gaming',8971765870,26),(4,'ms dhoni untold story',5,1920,'biography',5421726582,17),(6,'bermuda triangle',2,1980,'mystery',21765890896,9);

select*from books;

select*from members;

insert into members(member_id,first_name,last_name,date_of_birth,contact_number,membership_date) values(1,'vijay','narayanamoorthy','2003-01-13',9566007840,'2020-11-23'),(6,'mahi','ms','1986-07-07',9784076898,'2005-07-12'),(3,'sri','divya','1995-08-15',8423043247,'2009-02-06');

select *from members;

--dml qn2
update members set contact_number =9878659823 where member_id =6; 

select *from members;

select *from loans;

--dml qn4
insert into loans(loan_id,loan_date,return_date,actual_return_date,book_id,member_id) values(1,'1990-12-12','1991-01-10','1991-01-05',1,6);

select*from loans;

insert into loans(loan_id,loan_date,return_date,actual_return_date,book_id,member_id) values(2,'2007-11-09','2007-12-10','2007-12-01',4,3),(4,'2011-07-12','2011-07-12','2011-07-12',4,1),(7,'1990-12-12','1991-01-10','1991-01-05',1,3);

insert into loans(loan_id,loan_date,return_date,actual_return_date,book_id,member_id) values(6,'2007-11-09','2007-12-10','2007-12-01',1,3),(3,'2011-07-12','2011-07-12','2011-07-12',4,6),(5,'1990-12-12','1991-01-10','1991-01-05',2,3);

select*from loans;

--dml qn3
delete from loans where loan_id=7;

select*from loans;

select*from books;

select *from authors;

--joins qn1
select b.title,a.first_name,a.last_name from books b inner join authors a on b.author_id =a.author_id; 

select*from loans;

update books set genre = 'mystery' where book_id =2;

insert into books(book_id ,title ,author_id ,publication_year ,genre ,isbn ,available_copies ) values(3,'do or die',5,1987,'survival',6589897896,34);

select *from books;

--joins qn2
select l.book_id,b.title,m.member_id,m.first_name,m.last_name,m.date_of_birth,m.contact_number,m.membership_date from loans l inner join members m on l.member_id=m.member_id inner join books b on b.book_id=l.book_id ;

--joins qn3
select b.title from loans l inner join books b on b.book_id =l.book_id where l.member_id=3;

--joins qn4
select genre, count(book_id) as number_of_books ,sum(available_copies) as total_number_of_copies from books group by genre;

select*from staff;

insert into staff(staff_id,first_name,last_name,job_title,contact_number,email,hire_date) values(1,'raj','kumar','librarian',7689097890,'raj@gmail.com','2000-02-10');

insert into staff(staff_id,first_name,last_name,job_title,contact_number,email,hire_date) values(2,'govind','samy','assistant',6789098954,'govind@gmail.com','1990-12-27'),(3,'vetri','maran','librarian',9097890098,'vetrimaran@gmail.com','1980-11-01'),(4,'jaya','shree','librarian',8909789090,'jayashree@gmail.com','2005-07-10'),(5,'lokesh','kanagaraj','asssitant',7909789087,'lokeshkanagaraj@gmail.com','2010-02-15'),(6,'divya','sri','librarian',8909780980,'divya@gmail.com','1999-05-21');

--joins qn5
select staff_id,first_name,last_name,hire_date from staff where job_title='librarian';