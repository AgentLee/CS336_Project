/*UPDATED STUFF*/

#need this just in case?
#update transcript
#set grad = '2016';

#we should reorganize for the final copy
#alter table transcript
#add deptID char(3);

#alter table Students
#add email varchar(30);

#update students
#set email = 'jl1424@rutgers.edu'
#where netid='jl1424';

#alter table requesttest
#add email varchar(30);

alter table students 
drop column email;



alter table Students
add column email varchar(30) key(email);

ALTER TABLE requesttest
ADD CONSTRAINT emailConstraint
FOREIGN KEY (email)
REFERENCES students(email)
