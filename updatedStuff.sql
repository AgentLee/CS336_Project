/*UPDATED STUFF*/

#need this just in case?
update transcript
set grad = '2016';

#we should reorganize for the final copy
alter table transcript
add deptID char(3);