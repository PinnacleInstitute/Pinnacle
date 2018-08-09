EXEC [dbo].pts_CheckProc 'pts_Member_ReportAuthLog'
GO

CREATE PROCEDURE [dbo].pts_Member_ReportAuthLog
   @CompanyID int
AS

SET NOCOUNT ON
(
SELECT me.MemberID, me.CompanyName 'MemberName', co.CompanyName, COUNT(al.AuthLogID) 'Quantity' 
FROM AuthLog AS al
JOIN Member AS me ON al.AuthUserID = me.AuthUserID
JOIN Company AS co ON me.CompanyID = co.CompanyID
WHERE (@CompanyID = 0 OR me.CompanyID = @CompanyID)
AND me.AccessLimit != 'NONE' AND co.Status != 3
GROUP BY me.MemberID, me.CompanyName, co.CompanyName
HAVING COUNT(al.AuthLogID) >= 4
)
UNION
(
SELECT -1 * me.MemberID 'MemberID', me.CompanyName 'MemberName', co.CompanyName, COUNT(al.AuthLogID) 'Quantity' 
FROM AuthLog AS al
JOIN Member AS me ON al.AuthUserID = me.AuthUserID
JOIN Company AS co ON me.CompanyID = co.CompanyID
WHERE (@CompanyID = 0 OR me.CompanyID = @CompanyID)
AND (me.AccessLimit = 'NONE' OR co.Status = 3)
GROUP BY me.MemberID, me.CompanyName, co.CompanyName
HAVING COUNT(al.AuthLogID) >= 4
)
ORDER BY Quantity DESC

GO