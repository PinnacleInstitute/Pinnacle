EXEC [dbo].pts_CheckProc 'pts_Pinnacle_DeclineSuspend'
GO

--declare @Result int EXEC pts_Pinnacle_DeclineSuspend 7, '12/25/13', @Result output print @Result

CREATE PROCEDURE [dbo].pts_Pinnacle_DeclineSuspend
   @CompanyID int ,
   @EnrollDate datetime ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

DECLARE @Now datetime
SET @Now = GETDATE()
--preset 
SET @Result = 0

-- Suspend Members with Declined Direct Payments
UPDATE me SET Status = 4, EndDate = @Now 
--SELECT *
FROM Payment AS pa
JOIN Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 3 AND me.Billing = 3
AND  pa.Status = 4 AND pa.PayDate < @EnrollDate

-- Suspend Members with Declined SalesOrder Payments
UPDATE me SET Status = 4, EndDate = @Now 
--SELECT *
FROM Payment AS pa
JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
JOIN Member AS me ON so.MemberID = me.MemberID
WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 3 AND me.Billing = 3
AND  pa.Status = 4 AND pa.PayDate < @EnrollDate


SELECT @Result = COUNT(*) FROM Member WHERE Status = 4 AND EndDate = @Now

GO