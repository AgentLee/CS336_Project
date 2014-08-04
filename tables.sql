/*
CREATE TABLE UserTypeID (
	userType INTEGER, 
	userTypeName VARCHAR(12),
	PRIMARY KEY(userType)
);

CREATE TABLE Majors (
	majorid CHAR(3),
	majorNname CHAR(20) NOT NULL,
	PRIMARY KEY(majorid)
);

CREATE TABLE Users (
	ruid CHAR(9),
	name VARCHAR(15),
	netid VARCHAR(15) NOT NULL,
	passWord VARCHAR(15) NOT NULL,
	userType INTEGER,
	PRIMARY KEY (ruid),
	UNIQUE (netid),
	key(ruid, netid),
	FOREIGN KEY (userType) REFERENCES UserTypeID(userType)
		ON DELETE NO ACTION
); 

CREATE TABLE Students (
	ruid CHAR(9),
	netid VARCHAR(15),
	name VARCHAR(15),
	passWord VARCHAR(15),
	majorid CHAR(3),
	PRIMARY KEY (ruid),
	key(ruid),
	FOREIGN KEY (ruid) REFERENCES Users(ruid)
		ON DELETE NO ACTION,
	FOREIGN KEY (majorid) REFERENCES Majors(majorid)
		ON DELETE NO ACTION
);

CREATE TABLE ClassRooms (
	bldCode CHAR(3),
	maxSeating INTEGER,
	roomid CHAR(3),
	key(bldcode, roomid),
	PRIMARY KEY (bldCode,roomid)
);

CREATE TABLE Courses (
	majorid CHAR(3), -- "198" : "336" like mid:cid:sid -->
	cid CHAR (3),
	secNum CHAR(2),
	year CHAR(4),
	semesterid CHAR(2),
	profID CHAR(9),
	bldCode CHAR(3),
	roomid CHAR(3),
	maxEnroll INTEGER,
	deadline DATETIME,
	prereq VARCHAR(12),#--Yuan: Do we need to make preq a single talbe? what if one course has two or more prereq?-->
	PRIMARY KEY (majorid,cid,secNum,year,semesterid),
	key (cid, secnum, year, semesterid),
	FOREIGN KEY (bldCode,roomid) REFERENCES ClassRooms(bldCode,roomid),
	FOREIGN KEY (majorid) REFERENCES Majors (majorid),
	FOREIGN KEY (profID) REFERENCES Users(ruid)
);

CREATE TABLE Transcript (
	ruid CHAR(9),
	semester CHAR(2),
	cid CHAR(3),
	year CHAR(2),
	grade CHAR(2),
	majorid CHAR(3),
	enrolled CHAR(5), 
	grad CHAR(5) DEFAULT NULL,
	PRIMARY KEY (ruid,cid), 
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
#NEEDS TO BE FIXED

CREATE TABLE Courses (
	majorid CHAR(3), -- "198" : "336" like mid:cid:sid -->
	cid CHAR (3),
	secNum CHAR(2),
	year CHAR(4),
	semesterid CHAR(2),
	profID CHAR(9),
	bldCode CHAR(3),
	roomid CHAR(3),
	maxEnroll INTEGER,
	deadline DATETIME,
	prereq VARCHAR(12),#--Yuan: Do we need to make preq a single talbe? what if one course has two or more prereq?-->
	PRIMARY KEY (majorid,cid,secNum,year,semesterid),
	key (cid, secnum, year, semesterid),
	FOREIGN KEY (bldCode,roomid) REFERENCES ClassRooms(bldCode,roomid),
	FOREIGN KEY (majorid) REFERENCES Majors (majorid),
	FOREIGN KEY (profID) REFERENCES Users(ruid)
);

CREATE TABLE Register (
	ruid CHAR(9),
	registerTime DATETIME,  
	majorId CHAR(3), 
	cid CHAR(3),
	secNum CHAR(2),
	semesterid CHAR(2), #format ex:FA -->
	spNum CHAR(5) DEFAULT NULL, #Yuan: I add ane more attr here. considering when spn is required for registration, there should be some place to put it in-->
	year char(4),
	PRIMARY KEY (ruid, majorid, cid,secNum,semesterid),
	foreign key(majorid) references majors(majorid)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	FOREIGN KEY (ruid) REFERENCES Students (ruid)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	FOREIGN KEY (cid,secNum,semesterid,year) REFERENCES Courses
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);

CREATE TABLE Recitation(
	cid CHAR(3),
	secNum CHAR(2),
	maxEnroll INTEGER,
	time CHAR(4),
	roomid CHAR(3),
	bldCode CHAR(3),
	PRIMARY KEY (cid,secNum),
	FOREIGN KEY (cid, secNum) REFERENCES Courses(cid, secNum)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	FOREIGN KEY (roomid, bldCode) REFERENCES classRooms(roomid, bldCode)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);

-- Need to connect response relationship from User to SPN -->
CREATE TABLE request(
	cid CHAR(3),
	secNum CHAR(2),
	ruid CHAR(9),
	time DATETIME,
	status CHAR(20),
	reason CHAR(20),
	response CHAR(20) DEFAULT NULL, <-- If given an spn, itll appear here -->
	FOREIGN KEY (cid, secNum) REFERENCES Courses(cid, secNum)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	FOREIGN KEY (ruid) REFERENCES Student(ruid)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);

CREATE TABLE spns (
	cid CHAR(3),
	secNum CHAR(2),
	quantity INTEGER,
	PRIMARY KEY(cid, secNum),
	FOREIGN KEY(cid, secNum) REFERENCES Course(cid, secNum)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);
#-- is it 10 spns per course or 10 per section? needs to be modified if 10 per course -->

#<--Yuan: check and set the usertype when creating new user tuples in table Users-->
CREATE TRIGGER check_userType BEFORE INSERT ON Users
	FOR EACH ROW
	BEGIN
    	IF NEW.ruid LIKE ‘1%’ THEN
                	INSERT INTO User(ruid, name, netid, password, useryType)
                	VALUES(NEW.ruid, NEW.name, NEW.netid, NEW.password, '1')
    	ELSEIF NEW.ruid LIKE ‘2%’ THEN
                	INSERT INTO User(ruid, name, netid, password, useryType)
                	VALUES(NEW.ruid, NEW.name, NEW.netid, NEW.password, '2')
    	ELSEIF NEW.ruid LIKE ‘3%’ THEN
                	INSERT INTO User(ruid, name, netid, password, useryType)
                	VALUES(NEW.ruid, NEW.name, NEW.netid, NEW.password, '3')
    	END IF;
	END;

#<--Yuan: check if students need spn to register the course. two conditions: 1 late registration, 2 prereq overwrite, not sure if the code works... really need help-->
CREATE TRIGGER check_register BEFORE INSERT ON Register
	FOR EACH ROW
	BEGIN
		IF NEW.registerTime > Course.deadline <--deadline past-->
			OR 
			0 = (SELECT COUNT(T.cid)
			FROM Transcript T, Course C, NEW
			WHERE NEW.cid = C.cid AND NEW.ruid = T.ruid AND T.cid = C.prereq) <--the prereq course is not taken-->
			OR
			'C' >= (SELECT T.grade
			FROM Transcript T, Course C, NEW
			WHERE NEW.cid = C.cid AND NEW.ruid = T.ruid AND T.cid = C.prereq)<--the grade is lower than required-->
			THEN 
				BEGIN 
				IF NEW.spNum = (SELECT R.response
						FROM request R
						WHERE R.ruid = NEW.ruid)
			        THEN INSERT INTO Register(ruid, registerTime, majorId, cid, secNum, semester, spNum) <--spn need to be provided but how to check if this spNum matches the one provided in the request?-->
                     			VALUES(NEW.ruid, NEW.registerTime, NEW.majorId, NEW.cid, NEW.secNum, NEW.semester, NEW.spNum))
                     		ELSE NO ACTION
                     		END IF
                     		END;

		ELSE INSERT INTO Register(ruid, registerTime, majorId, cid, secNum, semester,spNum)<--can register without spNum-->
                     VALUES(NEW.ruid, NEW.registerTime, NEW.majorId, NEW.cid, NEW.secNum, NEW.semester);
                END IF;
	END;

#<--Yuan: before add tuples in request, check if all 10 spn's for such section are used out, if not, add the tuple, if yes reject the action-->
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
	END;

#<--Yuan: before prof. give spn to student, check if all spn's are used out-->
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
	END;




