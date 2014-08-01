#users
#insert into users values('145005986', 'Jon Lee', 'jl1424', 'password', 1); 
#insert into users values('123456789', 'Prof X', 'profx', 'xmen', '2');

#majors
#insert into majors values('198', 'Computer Science');
#insert into majors values('640', 'Math');
#insert into majors values('730', 'Physics');

#students
#insert into students values('145005986', 'jl1424', 'Jon Lee', 'password', '198');
/*
CREATE TABLE ClassRooms (
	bldCode CHAR(3),
	maxSeating INTEGER,
	roomid CHAR(3),
	PRIMARY KEY (bldCode,roomid)
);
*/
/*
CREATE TABLE Courses (
	majorid CHAR(3), 
	cid CHAR (3),
	secNum CHAR(2),
	year CHAR(4),
	semesterid CHAR(2),
	profID CHAR(9),
	bldCode CHAR(3),
	roomid CHAR(3),
	maxEnroll INTEGER,
	deadline DATETIME,
	prereq VARCHAR(12),
	PRIMARY KEY (majorid,cid,secNum,year,semesterid),
	FOREIGN KEY (bldCode,roomid) REFERENCES ClassRooms(bldCode,roomid),
	FOREIGN KEY (majorid) REFERENCES Majors (majorid),
	FOREIGN KEY (profID) REFERENCES Users(ruid)
);
*/


#insert into classrooms values('SEC', 50, '208'); 
#insert into courses values('198', '336', '01', '2014', 'SU', 'profx', 'SEC', '208', 45, curdate(), '205');
/*
create table courses(
	majorid char(3),
	cid char(3),
	secnum char(3),
	year char(4),
	semesterid char(2),
	bldcode char(3),
	roomid char(3),
	maxenroll integer,
	primary key(majorid, cid, secnum, semesterid, year),
	foreign key(bldcode, roomid) references classrooms(bldcode, roomid),
	foreign key(majorid) references majors (majorid)
);

insert into courses values('198', '336', '01', '2014', 'SU', 'SEC', '208', 45);*/ 
insert into classrooms values('SEC', 50, '210'); 
insert into classrooms values('SEC', 50, '211'); 

insert into courses values('198', '336', '02', '2014', 'SU', 'SEC', '208', 45);
insert into courses values('198', '336', '03', '2014', 'SU', 'SEC', '208', 45);
insert into courses values('198', '214', '01', '2014', 'FA', 'SEC', '210', 45);
insert into courses values('198', '214', '02', '2014', 'FA', 'SEC', '210', 45);
insert into courses values('198', '214', '03', '2014', 'FA', 'SEC', '210', 45);
insert into courses values('198', '214', '04', '2014', 'FA', 'SEC', '210', 45);
insert into courses values('198', '111', '01', '2014', 'FA', 'SEC', '211', 150);
insert into courses values('198', '111', '02', '2014', 'FA', 'SEC', '211', 150);
insert into courses values('198', '111', '03', '2014', 'FA', 'SEC', '211', 150);
insert into courses values('198', '111', '04', '2014', 'FA', 'SEC', '211', 150);
