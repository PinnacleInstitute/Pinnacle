DECLARE @MemberID int, @Test
SET @MemberID = 10298

SELECT A.MemberID, A.ReferralID, A.GroupID
--UPDATE A SET GroupID = @MemberID
FROM Member As A
WHERE A.ReferralID = @MemberID

SELECT B.MemberID, B.ReferralID
--UPDATE B SET GroupID = @MemberID
FROM Member As A
JOIN Member AS B ON A.MemberID = B.ReferralID
WHERE A.ReferralID = @MemberID

SELECT C.MemberID, C.ReferralID
--UPDATE C SET GroupID = @MemberID
FROM Member As A
JOIN Member AS B ON A.MemberID = B.ReferralID
JOIN Member AS C ON B.MemberID = C.ReferralID
WHERE A.ReferralID = @MemberID

SELECT D.MemberID, D.ReferralID
--UPDATE D SET GroupID = @MemberID
FROM Member As A
JOIN Member AS B ON A.MemberID = B.ReferralID
JOIN Member AS C ON B.MemberID = C.ReferralID
JOIN Member AS D ON C.MemberID = D.ReferralID
WHERE A.ReferralID = @MemberID

SELECT E.MemberID, E.ReferralID
--UPDATE E SET GroupID = @MemberID
FROM Member As A
JOIN Member AS B ON A.MemberID = B.ReferralID
JOIN Member AS C ON B.MemberID = C.ReferralID
JOIN Member AS D ON C.MemberID = D.ReferralID
JOIN Member AS E ON D.MemberID = E.ReferralID
WHERE A.ReferralID = @MemberID

SELECT F.MemberID, F.ReferralID
--UPDATE F SET GroupID = @MemberID
FROM Member As A
JOIN Member AS B ON A.MemberID = B.ReferralID
JOIN Member AS C ON B.MemberID = C.ReferralID
JOIN Member AS D ON C.MemberID = D.ReferralID
JOIN Member AS E ON D.MemberID = E.ReferralID
JOIN Member AS F ON E.MemberID = F.ReferralID
WHERE A.ReferralID = @MemberID


SELECT G.MemberID, G.ReferralID
--UPDATE G SET GroupID = @MemberID
FROM Member As A
JOIN Member AS B ON A.MemberID = B.ReferralID
JOIN Member AS C ON B.MemberID = C.ReferralID
JOIN Member AS D ON C.MemberID = D.ReferralID
JOIN Member AS E ON D.MemberID = E.ReferralID
JOIN Member AS F ON E.MemberID = F.ReferralID
JOIN Member AS G ON F.MemberID = G.ReferralID
WHERE A.ReferralID = @MemberID

SELECT H.MemberID, H.ReferralID
--UPDATE H SET GroupID = @MemberID
FROM Member As A
JOIN Member AS B ON A.MemberID = B.ReferralID
JOIN Member AS C ON B.MemberID = C.ReferralID
JOIN Member AS D ON C.MemberID = D.ReferralID
JOIN Member AS E ON D.MemberID = E.ReferralID
JOIN Member AS F ON E.MemberID = F.ReferralID
JOIN Member AS G ON F.MemberID = G.ReferralID
JOIN Member AS H ON G.MemberID = H.ReferralID
WHERE A.ReferralID = @MemberID

