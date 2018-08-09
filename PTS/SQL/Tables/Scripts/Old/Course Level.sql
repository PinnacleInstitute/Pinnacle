-- swap course level 1 and 2
update course set courselevel = 99 where courselevel = 1
update course set courselevel = 1 where courselevel = 2
update course set courselevel = 2 where courselevel = 99
