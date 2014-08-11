insert into usertypeid values(1, 'Student');
insert into usertypeid values(2, 'Professor');
insert into usertypeid values(3, 'Admin');

insert into majors values('198', 'Computer Science');
insert into majors values('640', 'Math');
insert into majors values('730', 'Physics');

insert into users values('123456789', 'Jon Lee', 'jl1424', 'root', 1);
insert into users values('234567891', 'root', 'root', 'root', 1);
insert into users values('345678912', 'groot', 'groot', 'groot', 2);
insert into users values('456789123', 'Admin', 'admin', 'admin', 3);

insert into students values('123456789', 'jl1424', 'Jon Lee', '198', '1@email.com');
insert into students values('234567891', 'root', 'root', '640', '2@email.com');

insert into classrooms values('SEC', 60, '208');
insert into classrooms values('TIL', 60, '210');
insert into classrooms values('ENG', 120, '111');

insert into courses values('198', '111', '01', 'FA', '2014', '345678912','ENG', '111', 120, '2014-9-21', null, null);
insert into courses values('198', '112', '01', 'FA', '2014', '345678912', 'ENG', '111', 120, '2014-9-21', null, null);
insert into courses values('198', '211', '01', 'FA', '2014', '345678912','ENG', '111', 120, '2014-9-21', null, null);
insert into courses values('198', '111', '01', 'SP', '2013', '345678912','ENG', '111', 120, '2013-1-21', null, null);
insert into courses values('198', '112', '01', 'FA', '2013', '345678912','ENG', '111', 120, '2013-9-21', null, null);
insert into courses values('198', '211', '01', 'SP', '2014', '345678912','ENG', '111', 120, '2014-1-21', null, null);
insert into courses values('198', '336', '01', 'SU', '2014', '345678912','ENG', '111', 120, '2014-6-21', null, null);
insert into courses values('198', '205', '01', 'FA', '2013', '345678912','ENG', '111', 120, '2013-9-21', null, null);
insert into courses values('198', '206', '01', 'SP', '2014', '345678912','ENG', '111', 120, '2014-1-21', null, null);
insert into courses values('640', '152', '01', 'FA', '2012', '345678912','ENG', '111', 120, '2012-9-21', null, null);
insert into courses values('640', '250', '01', 'SP', '2013', '345678912','ENG', '111', 120, '2013-9-21', null, null); 

insert into recitation values('198', '111', '01', 'FA', '2014', 100, '3:00', '111', 'ENG', 10);

insert into spns values ('198', '111', '01', 'FA', '2014', '11110');
insert into spns values ('198', '111', '01', 'FA', '2014', '11111');
insert into spns values ('198', '111', '01', 'FA', '2014', '11112');
insert into spns values ('198', '111', '01', 'FA', '2014', '11113');
insert into spns values ('198', '111', '01', 'FA', '2014', '11114');
insert into spns values ('198', '111', '01', 'FA', '2014', '11115');
insert into spns values ('198', '111', '01', 'FA', '2014', '11116');
insert into spns values ('198', '111', '01', 'FA', '2014', '11117');
insert into spns values ('198', '111', '01', 'FA', '2014', '11118');
insert into spns values ('198', '111', '01', 'FA', '2014', '11119');

insert into Request values ('198', '111', '01', 'FA', '2014', '234567891', null , null ,'because', null , 11110 );

insert into transcript values('123456789', '640', '152', 'A', 'FA', '2012', '2012', null);
insert into transcript values('123456789', '640', '250', 'A', 'SP', '2013', '2012', null);
insert into transcript values('123456789', '198', '111', 'A', 'SP', '2013', '2012', null);
insert into transcript values('123456789', '198', '112', 'A', 'FA', '2013', '2012', null);
insert into transcript values('123456789', '198', '205', 'A', 'FA', '2013', '2012', null);
insert into transcript values('123456789', '198', '206', 'A', 'SP', '2014', '2012', null);
insert into transcript values('123456789', '198', '211', 'A', 'SP', '2014', '2012', null);
