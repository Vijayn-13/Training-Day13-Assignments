create table customers(
	customer_id integer not null Primary key,
	first_name text,
	last_name text,
	date_of_birth date,
	gender text,
	contact_number text check (contact_number ~ '^[0-9]{10}$'),
	email text,
	address text
);

create table policies(
	policy_id integer not null Primary key,
	policy_name text,
	policy_type text,
	coverage_details text,
	premium numeric(10,4),
	start_date date,
	end_date date
);

create table agents(
	agent_id integer not null Primary key,
	first_name text,
	last_name text,
	contact_number text check (contact_number~'^[0-9]{10}$'),
	email text,
	hire_date date
);

create table claims(
	claim_id integer not null Primary key,
	policy_id integer,
	customer_id integer,
	claim_date date,
	claim_amount numeric(10,4),
	approved_amount numeric(10,4),
	claim_status text,
	Foreign key(policy_id) References policies(policy_id),
	Foreign key(customer_id) References customers(customer_id)
);

create table policy_assignments(
	assignment_id integer not null Primary key,
	customer_id integer,
	policy_id integer,
	Foreign key(customer_id) references customers(customer_id),
	Foreign key(policy_id) references policies(policy_id),
	start_date date,
	end_date date
);

create table claim_processing(
	processing_id integer not null Primary key,
	claim_id integer,
	Foreign key(claim_id) references claims,
	processing_date date,
	payment_amount numeric(10,4),
	payment_date date
);

select table_name from information_schema.tables where table_schema ='public';

select*from agents;

alter table agents drop column email;

select*from agents;

--ddl qn1
alter table agents add column email text;

select*from agents;

select*from policies;

--ddl qn2
alter table policies rename column policy_name to policy_title;

select*from policies;

select *from customers;

--ddl qn3
alter table customers drop column address;

select *from customers;

insert into customers (customer_id,first_name,last_name,date_of_birth,gender,contact_number,email) values(1,'raj','kumar','1990-12-03','male','9876547890','raj@gmail.com');

insert into customers (customer_id,first_name,last_name,date_of_birth,gender,contact_number,email) values(2,'vel','raj','1970-10-21','male','8765490321','velraj@gmail.com');

insert into customers (customer_id,first_name,last_name,date_of_birth,gender,contact_number,email) values(3,'sri','divya','2000-07-15','female','8032167545','sridivya@gmail.com'),(4,'lokesh','kanagaraj','1985-04-10','male','7895674565','lokeshkanagaraj@gmail.com'),(5,'mouni','roj','1990-09-11','female','9032187654','mouniroy@gmail.com'),(6,'malar','vizhi','1995-08-19','female','7654908321','malarvizhi@gmail.com'),(7,'dilip','kumar','1970-01-21','male','8549032176','dilipkumar@gmail.com');

update customers set last_name='roy' where customer_id=5;

select*from policies;

insert into policies(policy_id,policy_title,policy_type,coverage_details,premium,start_date,end_date) values(1,'property insurance','home','damages on home will be covered',12000,'1990-10-20','2010-10-20');

insert into policies(policy_id,policy_title,policy_type,coverage_details,premium,start_date,end_date) values(2,'long term insurance','term','provides financial security to your entire family in case of the unfortunate death of the policyholder',50000,'1979-04-19','2000-10-09'),(3,'health insurance','health','covers costs for medical tests, doctor consultation fees, medicines, hospitalization charges, and even post-hospitalization care',25000,'1998-07-10','2005-10-20'),(4,'life insurance','life','provides financial support in the event of policyholder demise',30000,'1980-02-21','2009-10-20'),(5,'health insurance','health','covers costs for medical emergencies',10000,'2000-02-10','2010-10-10'),(6,'auto insurance','auto','provides protection against financial loss in the event of an accident or theft',7000,'1986-09-14','1993-07-12'),(7,'property insurance','home','damages on home will be covered',2000,'2000-10-20','2007-08-17');

select*from claims;

insert into claims(claim_id,policy_id,customer_id,claim_date,claim_amount,approved_amount,claim_status) values(1,7,1,'2007-08-20',12000,10500,'approved');

insert into claims(claim_id,policy_id,customer_id,claim_date,claim_amount,approved_amount,claim_status) values(2,6,2,'1993-08-10',135000,125000,'approved'),(3,5,5,'2011-04-20',145000,140000,'approved'),(4,3,1,'2005-11-11',98000,96500,'denied'),(5,4,7,'2009-10-30',167000,166000,'approved'),(6,1,4,'2010-08-20',135000,134000,'denied');

select *from agents;

insert into agents (agent_id,first_name,last_name,contact_number,hire_date,email) values(1,'tilak','varma','8794561020','1987-12-01','tilak@gmail.com');

insert into agents (agent_id,first_name,last_name,contact_number,hire_date,email) values(2,'rachin','ravindra','9456102087','2000-07-10','rachinravindra@gmail.com'),(3,'shyam','singh','7894561020','1970-10-06','shyam@gmail.com'),(4,'shalini','pandey','9458761020','1996-01-15','shalini@gmail.com'),(5,'shreya','ghoshal','9456102023','1975-10-11','shreyaghoshal@gmail.com');

select *from policy_assignments;

insert into policy_assignments (assignment_id,customer_id,policy_id,start_date,end_date) values(1,1,7,'2000-10-20','2007-08-17');

--dml qn3
insert into policy_assignments (assignment_id,customer_id,policy_id,start_date,end_date) values(2,1,4,'1990-10-20','2010-10-20'),(3,4,7,'1980-02-21','2009-10-20'),(4,3,1,'1998-07-10','2005-10-20'),(5,5,5,'2000-02-10','2010-10-10'),(6,6,2,'1986-09-14','1993-07-12');

select *from claim_processing;

insert into claim_processing (processing_id,claim_id,processing_date,payment_amount,payment_date) values(1,6,'2010-08-10',134000,'2010-08-20');

insert into claim_processing (processing_id,claim_id,processing_date,payment_amount,payment_date) values(2,5,'2009-10-10',166000,'2009-10-30'),(3,4,'2005-11-07',96500,'2005-11-11'),(4,3,'2011-04-10',140000,'2011-04-20'),(5,2,'1993-08-05',125000,'1993-08-10'),(6,1,'2007-08-10',10500,'2007-08-20');

select *from policies;

--dml qn1
update policies set premium =29500 where policy_id =4;

select *from claim_processing;

alter table claim_processing drop claim_id;

alter table claim_processing add column claim_id integer;

alter table claim_processing add constraint fk foreign key(claim_id) references claims(claim_id) on delete cascade;

update claim_processing set claim_id =6 where processing_id =1;

update claim_processing set claim_id =5 where processing_id =2;

update claim_processing set claim_id =4 where processing_id =3;

update claim_processing set claim_id =3 where processing_id =4;

update claim_processing set claim_id =2 where processing_id =5;

update claim_processing set claim_id =1 where processing_id =6;

--dml qn2
delete from claims where claim_id=5;

select *from claims;

alter table policies add column agent_id integer;

alter table policies add foreign key(agent_id) references agents(agent_id);

update policies set agent_id=1 where policy_type ='home';

update policies set agent_id=2 where policy_type ='term';

update policies set agent_id=4 where policy_type ='health';

update policies set agent_id=3 where policy_type ='life';

update policies set agent_id=5 where policy_type ='auto';

--joins qn1
select c.policy_id,p.policy_type,c.customer_id,c1.first_name||' '||c1.last_name as customer_name,a.agent_id,a.first_name||' '||a.last_name as agent_name from claims c inner join customers c1 on c1.customer_id =c.customer_id inner join policies p on p.policy_id =c.policy_id inner join agents a on a.agent_id=p.agent_id; 

--joins qn2
select c.claim_id,c.policy_id,c.customer_id,concat(c1.first_name,' ',c1.last_name) as customer_name,c.claim_date,c.claim_amount,c.approved_amount,c.claim_status,p.policy_title,p.policy_type,p.coverage_details,p.premium,p.start_date,p.end_date from claims c inner join policies p on p.policy_id=c.policy_id inner join customers c1 on c1.customer_id =c.customer_id ;

--joins qn3
select c.claim_id,c.policy_id,c.customer_id,c1.first_name||' '||c1.last_name as customer_name,c1.date_of_birth,c1.gender,c1.contact_number,c1.email,c.claim_date,c.claim_amount,c.approved_amount,c.claim_status from claims c inner join customers c1 on c1.customer_id=c.customer_id; 

--joins qn4
select p.policy_type,count(c.claim_id) as number_of_claims,sum(c.claim_amount) as Total_claim_amount from claims c inner join policies p on p.policy_id =c.policy_id group by p.policy_type;

--joins qn5
select c.customer_id,concat(c.first_name,' ',c.last_name) as customer_name,c1.claim_date as most_recent_claim,c1.claim_id,p.policy_type from customers c inner join claims c1 on c1.customer_id=c.customer_id inner join policies p on p.policy_id=c1.policy_id inner join (select customer_id,max(claim_date) as most_recent_claim_date from claims group by customer_id)recent_claims on recent_claims.customer_id=c.customer_id and c1.claim_date =recent_claims.most_recent_claim_date; 







