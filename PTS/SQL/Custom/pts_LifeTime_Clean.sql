EXEC [dbo].pts_CheckProc 'pts_LifeTime_Clean'
GO

--declare @Result varchar(1000) EXEC pts_LifeTime_Clean @Result output print @Result

CREATE PROCEDURE [dbo].pts_LifeTime_Clean
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON

--Delete Members with no status
--SELECT * FROM
DELETE 
Member WHERE Status = 0

-- Delete AuthUsers with no Member
--SELECT * 
DELETE xx
FROM AuthUser AS xx
LEFT OUTER JOIN Member AS me ON xx.AuthUserID = me.AuthUserID
WHERE xx.UserType = 4 AND me.MemberID IS NULL

-- Delete Billing Methods with no Member
--SELECT * 
DELETE xx
FROM Billing AS xx
LEFT OUTER JOIN Member AS me ON xx.BillingID = me.BillingID
WHERE xx.PayType > 0 AND me.MemberID IS NULL

-- Delete Payout Methods with no Member
--SELECT * 
DELETE xx
FROM Billing AS xx
LEFT OUTER JOIN Member AS me ON xx.BillingID = me.PayID
WHERE xx.CommType > 0 AND me.MemberID IS NULL

-- Delete Addresses with no Member
--SELECT * 
DELETE xx
FROM Address AS xx
LEFT OUTER JOIN Member AS me ON xx.OwnerID = me.MemberID
WHERE xx.OwnerType = 4 AND me.MemberID IS NULL

-- Delete Calendars with no Member
--SELECT * 
DELETE xx
FROM Calendar AS xx
LEFT OUTER JOIN Member AS me ON xx.MemberID = me.MemberID
WHERE xx.MemberID > 0 AND me.MemberID IS NULL

-- Delete Downline Parents with no Member
--SELECT * 
DELETE xx
FROM Downline AS xx
LEFT OUTER JOIN Member AS me ON xx.ParentID = me.MemberID
WHERE me.MemberID IS NULL

-- Delete Downline Children with no Member
--SELECT * 
DELETE xx
FROM Downline AS xx
LEFT OUTER JOIN Member AS me ON xx.ChildID = me.MemberID
WHERE me.MemberID IS NULL

-- Delete MemberTitle with no Member
--SELECT * 
DELETE xx
FROM MemberTitle AS xx
LEFT OUTER JOIN Member AS me ON xx.MemberID = me.MemberID
WHERE me.MemberID IS NULL

-- Delete Notes with no Member
--SELECT * 
DELETE xx
FROM Note AS xx
LEFT OUTER JOIN Member AS me ON xx.OwnerID = me.MemberID
WHERE xx.OwnerType = 4 AND me.MemberID IS NULL

-- Delete Prospect with no Member
--SELECT * 
DELETE xx
FROM Prospect AS xx
LEFT OUTER JOIN Member AS me ON xx.MemberID = me.MemberID
WHERE xx.MemberID > 0 AND me.MemberID IS NULL

-- Delete SessionLesson with no Member
--SELECT * 
DELETE sl
FROM SessionLesson AS sl
JOIN Session AS xx ON sl.SessionID = xx.SessionID
LEFT OUTER JOIN Member AS me ON xx.MemberID = me.MemberID
WHERE me.MemberID IS NULL

-- Delete Session with no Member
--SELECT * 
DELETE xx
FROM Session AS xx
LEFT OUTER JOIN Member AS me ON xx.MemberID = me.MemberID
WHERE me.MemberID IS NULL


SET @Result = '1'