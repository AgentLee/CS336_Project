drop database newspnsystem;
create database newspnsystem;
use newspnsystem;

CREATE TABLE UserTypeID(
	userType INTEGER,
	userTypeName VARCHAR(15) NOT NULL,
	PRIMARY KEY(userType),
	KEY(userType)
);

CREATE TABLE Majors(
	majorID CHAR(3),
	majorName CHAR(20),
	PRIMARY KEY(majorID),
	KEY(majorID)
);

CREATE TABLE Users(
	ruid CHAR(9),
	name VARCHAR(15),
	netID VARCHAR(15) NOT NULL,
	password VARCHAR(15) NOT NULL,
	userType INTEGER,
	PRIMARY KEY(ruid),
	KEY(ruid),
	UNIQUE(netid),
	FOREIGN KEY(userType) REFERENCES UserTypeID(userType)
		ON DELETE NO ACTION
);

CREATE TABLE Students(
	ruid CHAR(9),
	netid VARCHAR(15),
	name VARCHAR(15),
	majorID CHAR(3),
	email VARCHAR(25),
	creditsEarned INTEGER DEFAULT NULL,
	PRIMARY KEY(ruid),
	KEY(ruid),
	FOREIGN KEY(ruid) REFERENCES Users(ruid)
		ON DELETE NO ACTION,
	FOREIGN KEY(majorID) REFERENCES Majors(majorID)
		ON DELETE NO ACTION
);

CREATE TABLE Classrooms(
	bldCode CHAR(3),
	maxSeating INTEGER,
	roomID CHAR(3),
	PRIMARY KEY(bldCode, roomID),
	KEY(bldCode, roomID)
);

CREATE TABLE prereq (
	majorid CHAR(3),
	cid CHAR(3),
	PRIMARY KEY(majorid, cid),
	KEY (majorid, cid),
	FOREIGN KEY (majorID) REFERENCES Majors(majorID)
);

CREATE TABLE Courses(
	majorID CHAR(3),
	cid CHAR(3),
	secNum CHAR(2),
	credits INTEGER,
	semesterID CHAR(2),
	year CHAR(4),
	profID CHAR(9),
	bldCode CHAR(3),
	roomID char(3),
	maxEnroll INTEGER,
	deadline DATETIME,
	prereqMajorID CHAR(3),
	prereqCID CHAR(3),
	preCredits INTEGER,
	PRIMARY KEY(majorID, cid, secNum, semesterID, year),
	KEY (cid, secNum, semesterID, year),
	FOREIGN KEY(bldCode, roomID) REFERENCES Classrooms(bldCode, roomID),
	FOREIGN KEY(majorID) REFERENCES Majors(majorID),
	FOREIGN KEY(profID) REFERENCES Users(ruid),
	FOREIGN KEY(prereqMajorID, prereqCID) REFERENCES prereq(majorID, cid)
);

CREATE TABLE Transcript(
	ruid CHAR(9),
	majorID CHAR(3),
	cid CHAR(3),	
	grade CHAR(4), #curr for classes current classes
	gpa REAL,
	credits INTEGER,
	semesterID CHAR(2),
	year CHAR(4),
	enrolled CHAR(5),
	grad CHAR(5), 
	PRIMARY KEY(ruid, cid, semesterID, year, majorid), 
	FOREIGN KEY(ruid) REFERENCES Students(ruid)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	FOREIGN KEY(cid) REFERENCES Courses(cid)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	FOREIGN KEY(majorID) REFERENCES Majors(majorID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);

CREATE TABLE Recitation(
	majorID CHAR(3),
	cid CHAR(3),
	secNum CHAR(2),
	semesterID CHAR(2),
	year CHAR(4),
	maxEnroll INTEGER,
	time CHAR(4),
	roomID CHAR(3),
	bldCode CHAR(3),
	PRIMARY KEY(majorID, cid, secNum, semesterID, year),
	FOREIGN KEY(majorID) REFERENCES Majors(majorID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	FOREIGN KEY(cid, secNum, semesterID, year) REFERENCES Courses(cid, secNum, semesterID, year)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	FOREIGN KEY(bldCode, roomID) REFERENCES Classrooms(bldCode, roomID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);

CREATE TABLE Request(
	majorID CHAR(3),
	cid CHAR(3),
	secNum CHAR(2),
	semesterID CHAR(2),
	year CHAR(4),
	ruid CHAR(9),
	time DATETIME,
	status CHAR(20), #updated by professor
	reason CHAR(20), #student reason
	response CHAR(20) DEFAULT NULL, #pending/approved/denied
	message CHAR(50) DEFAULT NULL, #professor's message to student
	PRIMARY KEY(ruid, majorID, cid, secNum, semesterID, year),
	FOREIGN KEY(majorID) REFERENCES Majors(majorID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	FOREIGN KEY(cid, secNum, semesterID, year) REFERENCES Courses(cid, secNum, semesterID, year)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	FOREIGN KEY(ruid) REFERENCES Students(ruid)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);

CREATE TABLE spns(
	majorID CHAR(3),
	cid CHAR(3),
	secNum CHAR(2),
	semesterID CHAR(2),
	year CHAR(4),
	quantity INTEGER,
	PRIMARY KEY(majorID, cid, secNum, semesterID, year),
	FOREIGN KEY(majorID) REFERENCES Majors(majorID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	FOREIGN KEY(cid, secNum, semesterID, year) REFERENCES Courses(cid, secNum, semesterID, year)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);

CREATE TABLE profMessage(
	ruid CHAR(9),
	profID CHAR(9),
	majorID CHAR(3),
	CID CHAR(3),
	secNum CHAR(2),
	message CHAR(100),
	date DATETIME,
	FOREIGN KEY(ruid) REFERENCES Students(ruid),
	FOREIGN KEY(profID) REFERENCES Users(ruid),
	FOREIGN KEY(majorid, cid, secnum) REFERENCES Courses(majorid, cid, secnum)
);

INSERT INTO usertypeid VALUES(1, 'Student');
INSERT INTO usertypeid VALUES(2, 'Professor');
INSERT INTO usertypeid VALUES(3, 'Administrator');

INSERT INTO majors VALUES('198', 'Computer Science');
INSERT INTO majors VALUES('640', 'MATHEMATICS');

INSERT INTO classrooms VALUES('SEC', 60, '208');
INSERT INTO classrooms VALUES('LSH', 200, 'AUD');
INSERT INTO classrooms VALUES('PHY', 200, 'LH');
INSERT INTO classrooms VALUES('ENG', 100, '111');

INSERT INTO users VALUES('123456789', 'root root', 'root', 'root', 1);
INSERT INTO users VALUES('234567891', 'prof root', 'profroot', 'root', 2);
INSERT INTO users VALUES('345678912', 'admin root', 'adminroot', 'root', 3);

INSERT INTO students VALUES('123456789', 'root', 'root root', '198', 'root@rutgers.edu', 65);

INSERT INTO prereq VALUES('198', '111');
INSERT INTO prereq VALUES('198', '112');
INSERT INTO prereq VALUES('198', '205');
INSERT INTO prereq VALUES('198', '206');
INSERT INTO prereq VALUES('198', '211');
INSERT INTO prereq VALUES('198', '214');
INSERT INTO prereq VALUES('198', '314');
INSERT INTO prereq VALUES('198', '336');

INSERT INTO courses VALUES('198', '111', '01', 4, 'FA', '2014', '234567891', 'ENG', '111', 200, '2014-09-21', null, null, null);
INSERT INTO courses VALUES('198', '111', '02', 4, 'FA', '2014', '234567891', 'ENG', '111', 200, '2014-09-21', null, null, null);
INSERT INTO courses VALUES('198', '111', '03', 4, 'FA', '2014', '234567891', 'ENG', '111', 200, '2014-09-21', null, null, null);
INSERT INTO courses VALUES('198', '111', '04', 4, 'FA', '2014', '234567891', 'ENG', '111', 200, '2014-09-21', null, null, null);


