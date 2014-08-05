CREATE TABLE UserTypeID(
	userType INTEGER,
	userTypeName VARCHAR(12),
	PRIMARY KEY(userType),
	KEY(userType)
);

CREATE TABLE Majors(
	majorID CHAR(3),
	majorName CHAR(20) NOT NULL,
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

#I think we need to add a new table for prereq or something...
CREATE TABLE Courses(
	majorID CHAR(3),
	cid CHAR(3),
	secNum CHAR(2),
	semesterID CHAR(2),
	year CHAR(4),
	profID CHAR(9),
	bldCode CHAR(3),
	roomID char(3),
	maxEnroll INTEGER,
	deadline DATETIME,
	prereq VARCHAR(12),
	PRIMARY KEY(majorID, cid, secNum, semesterID, year),
	KEY(cid, secNum, semesterID, year),
	FOREIGN KEY(bldCode, roomID) REFERENCES Classrooms(bldCode, roomID),
	FOREIGN KEY(majorID) REFERENCES Majors(majorID),
	FOREIGN KEY(profID) REFERENCES Users(ruid)
);

CREATE TABLE Transcript(
	ruid CHAR(9),
	semesterID CHAR(2),
	cid CHAR(2),
	year CHAR(2),
	grade CHAR(2),
	majorID CHAR(3),
	enrolled CHAR(5),
	grad CHAR(5) DEFAULT NULL,
	PRIMARY KEY(ruid, majorID, cid), #I think majorID should be in the key
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

#What does this table do? Students don't register...
CREATE TABLE Register(
	ruid CHAR(9),
	registerTime DATETIME,
	majorID CHAR(3),
	cid CHAR(3),
	secNum CHAR(2),
	semesterID CHAR(2),
	year CHAR(4),
	spn CHAR(5) DEFAULT NULL,
	PRIMARY KEY(ruid, majorID, cid, secNum, semesterID),
	FOREIGN KEY(ruid) REFERENCES Students(ruid)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	FOREIGN KEY(majorID) REFERENCES Majors(majorID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	FOREIGN KEY(cid, secNum, semesterID, year) REFERENCES Courses(cid, secNum, semesterID, year)
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
	status CHAR(20),
	reason CHAR(20),
	response CHAR(20) DEFAULT NULL,
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

CREATE TABLE RequestTest(
	majorID CHAR(3),
	cid CHAR(3),
	secNum CHAR(2),
	netid VARCHAR(15),
	status CHAR(20),
	reason CHAR(20),
	response CHAR(20) DEFAULT NULL,
	PRIMARY KEY(netid, majorID, cid, secNum, semesterID, year),
	FOREIGN KEY(majorID) REFERENCES Majors(majorID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	FOREIGN KEY(cid, secNum, semesterID, year) REFERENCES Courses(cid, secNum, semesterID, year)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	FOREIGN KEY(netid) REFERENCES Users(netid)
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
		ON UPDATE NO ACTIOn
);

delimiter //
CREATE TRIGGER check_userType BEFORE INSERT ON Users
	FOR EACH ROW
	BEGIN
    	IF NEW.ruid LIKE '1%' THEN
                	INSERT INTO User(ruid, name, netid, password, useryType)
                	VALUES(NEW.ruid, NEW.name, NEW.netid, NEW.password, '1');
    	ELSEIF NEW.ruid LIKE '2%' THEN
                	INSERT INTO User(ruid, name, netid, password, useryType)
                	VALUES(NEW.ruid, NEW.name, NEW.netid, NEW.password, '2');
    	ELSEIF NEW.ruid LIKE '3%' THEN
                	INSERT INTO User(ruid, name, netid, password, useryType)
                	VALUES(NEW.ruid, NEW.name, NEW.netid, NEW.password, '3');
    	END IF;
	END;//
delimiter ;