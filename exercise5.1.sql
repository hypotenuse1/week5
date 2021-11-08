#1
select id, c3, c5 from crud where c1 = 11 and c2 =2;
#2
select * from crud where c1 > 18 or c2 < 2;
#3
insert into crud values(DEFAULT, 7, 4, "col101", DEFAULT, 0);
#4
insert into crud values(103, 3, 3, "col103", DEFAULT, 1);
#5
select * from crud where id>100;
#6
update crud set c3 = "col0", c5=0 where c1>4 and c1<9 and c2=1;
#7
select * from crud where c1>4 and c1<9 and c2=1;
#8
delete from crud where c5 = 0;
#9
select * from crud where c5=0;