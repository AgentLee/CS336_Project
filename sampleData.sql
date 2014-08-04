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

insert into courses values('198', '336', '01', '2014', 'SU', 'SEC', '208', 45);
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


insert into classrooms values('ENG', 150, '111'); 
insert into classrooms values('SEC', 150, '118'); 
insert into classrooms values('BE', 150, '100'); 
insert into classrooms values('TIL', 150, '208'); 
insert into classrooms values('TIL', 150, '210'); 

insert into courses values('198', '111', '01', '2013', 'SP', 'ENG', '111', 150);
insert into courses values('198', '112', '01', '2013', 'FA', 'SEC', '118', 150);
insert into courses values('198', '211', '01', '2014', 'SP', 'BE', '100', 150);
insert into courses values('198', '205', '01', '2013', 'FA', 'TIL', '208', 150);
insert into courses values('198', '206', '01', '2014', 'SP', 'TIL', '210', 150);
insert into courses values('640', '152', '01', '2012', 'FA', 'TIL', '208', 50);
insert into courses values('640', '250', '01', '2013', 'SP', 'SEC', '118', 150);

CREATE TABLE Transcript (
	ruid CHAR(9),
	semester CHAR(2),
	cid CHAR (3),
	year CHAR(2),
	grade CHAR(2),
	majorid CHAR(3),
	enrolled CHAR(5), #University Enrollment -->
	grad CHAR(5) DEFAULT NULL,
	PRIMARY KEY (ruid,cid), #Yuan: I add cid here considering that one student may have taken several course, thus will have several grades for differnt course-->
	FOREIGN KEY (ruid) REFERENCES Students(ruid)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	FOREIGN KEY (cid) REFERENCES Courses(cid)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	FOREIGN KEY (majorid) REFERENCES Majors(majorid)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);
*/

CREATE TABLE request(
	cid CHAR(3),
	secNum CHAR(2),
	ruid CHAR(9),
	time DATETIME,
	status CHAR(20),
	reason CHAR(20),
	response CHAR(20) DEFAULT NULL, 
	FOREIGN KEY (cid, secNum) REFERENCES Courses(cid, secNum)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	FOREIGN KEY (ruid) REFERENCES Student(ruid)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);