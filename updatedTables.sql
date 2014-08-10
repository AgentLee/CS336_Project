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
	email VARCH(25),
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

#I think we need to add a new table for prereq or something
#need to fix the foreign key for prerequisites
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
	prereqMajorID CHAR(3),
	prereqCID CHAR(3),
	PRIMARY KEY(majorID, cid, secNum, semesterID, year),
	KEY(cid, secNum, semesterID, year),
	FOREIGN KEY(bldCode, roomID) REFERENCES Classrooms(bldCode, roomID),
	FOREIGN KEY(majorID) REFERENCES Majors(majorID),
	FOREIGN KEY(profID) REFERENCES Users(ruid),
	FOREIGN KEY(prereqMajorID, prereqCID) REFERENCES prerequisites(prereqMajorID, prereqCID)
);

CREATE TABLE Transcript(
	ruid CHAR(9),
	majorID CHAR(3),
	cid CHAR(3),	
	grade CHAR(2),
	semesterID CHAR(2),
	year CHAR(4),
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

CREATE TABLE prerequisites(
	majorID CHAR(3),
	cid CHAR(3),
	ruid varchar(9)
	PRIMARY KEY(ruid),
	KEY(ruid, majorID, CID),
	FOREIGN KEY(majorID) REFERENCES Majors(majorID),
	FOREIGN KEY(CID) REFERENCES courses(cid),
	FOREIGN KEY(ruid) REFERENCES Students(ruid)
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


#<--Yuan: check if students need spn to register the course. two conditions: 1 late registration, 2 prereq overwrite, not sure if the code works... really need help-->
delimiter //
CREATE TRIGGER check_register BEFORE INSERT ON Register
	FOR EACH ROW
	BEGIN
		IF NEW.registerTime > Course.deadline #<--deadline past-->
			OR 
			0 = (SELECT COUNT(T.cid)
			FROM Transcript T, Course C, NEW
			WHERE NEW.cid = C.cid AND NEW.ruid = T.ruid AND T.cid = C.prereq) #<--the prereq course is not taken-->
			OR
			'C' >= (SELECT T.grade
			FROM Transcript T, Course C, NEW
			WHERE NEW.cid = C.cid AND NEW.ruid = T.ruid AND T.cid = C.prereq)#<--the grade is lower than required-->
			THEN 
				BEGIN 
				IF NEW.spNum = (SELECT R.response
						FROM request R
						WHERE R.ruid = NEW.ruid)
			        THEN INSERT INTO Register(ruid, registerTime, majorId, cid, secNum, semester, spNum) #<--spn need to be provided but how to check if this spNum matches the one provided in the request?-->
                     			VALUES(NEW.ruid, NEW.registerTime, NEW.majorId, NEW.cid, NEW.secNum, NEW.semester, NEW.spNum)
                     		ELSE NO ACTION
                     		END IF
                     		END;

		ELSE INSERT INTO Register(ruid, registerTime, majorId, cid, secNum, semester,spNum)#<--can register without spNum-->
                     VALUES(NEW.ruid, NEW.registerTime, NEW.majorId, NEW.cid, NEW.secNum, NEW.semester);
                END IF;
	END;//
delimiter ;
 
#<--Yuan: before add tuples in request, check if all 10 spn's for such section are used out, if not, add the tuple, if yes reject the action-->
delimiter //
CREATE TRIGGER check_request_spn BEFORE INSERT ON request
	FOR EACH ROW
	BEGIN
		IF 10 <= (SELECT COUNT(R.response)
			FROM request R, NEW
			WHERE R.cid = NEW.cid AND R.secNum = NEW.secNum AND R.response <> NULL)
			THEN
		NO ACTION
		ELSE INSERT INTO request(cid, secNum, ruid, time, status, reason, response)
			VALUES(NEW.cid, NEW.secNum, NEW.ruid, NEW.time, NEW.status, NEW.reason);
		END IF;
	END;//
delimiter ;


#<--Yuan: before prof. give spn to student, check if all spn's are used out-->
delimiter //
CREATE TRIGGER check_give_spn BEFORE UPDATE ON request
	FOR EACH ROW 
	BEGIN	
		IF 10 <=(SELECT COUNT(*)
			FROM request R
			WHERE OLD.cid = R.cid AND OLD.secNum = R.secNum AND R.response <> NULL)
		THEN
		NO ACTION
		ELSE SET OLD.response = NEW.response;
		END IF;
	END;//
delimiter ;