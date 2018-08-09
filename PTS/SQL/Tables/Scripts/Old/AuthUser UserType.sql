UPDATE AUTHUSER
SET UserType = 1 
WHERE UserGroup = 1

UPDATE AUTHUSER
SET UserType = ABS(UserGroup/10) 
WHERE UserGroup > 10
