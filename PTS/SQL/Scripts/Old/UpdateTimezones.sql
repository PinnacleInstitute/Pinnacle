UPDATE Business SET Timezone = -6

UPDATE Calendar SET Timezone = -6 WHERE Timezone = 0
UPDATE Calendar SET Timezone = -5 WHERE Timezone = 1
UPDATE Calendar SET Timezone = -4 WHERE Timezone = 2
UPDATE Calendar SET Timezone = -6 WHERE Timezone = 3
UPDATE Calendar SET Timezone = -7 WHERE Timezone = 4
UPDATE Calendar SET Timezone = -8 WHERE Timezone = 5
UPDATE Calendar SET Timezone = -8 WHERE Timezone = 6
UPDATE Calendar SET Timezone = -9 WHERE Timezone = 7
UPDATE Calendar SET Timezone = -10 WHERE Timezone = 8

UPDATE me
SET me.Timezone = ca.Timezone
FROM Member AS me
JOIN Calendar AS ca ON me.MemberID = ca.MemberID

UPDATE Member SET Timezone = -6 WHERE Timezone = 0



