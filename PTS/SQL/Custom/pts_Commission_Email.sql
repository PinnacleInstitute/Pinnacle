EXEC [dbo].pts_CheckProc 'pts_Commission_Email'
GO
--EXEC pts_Commission_Email 9, 0, '5/9/12', '5/9/12'
--EXEC pts_Commission_Email 9, 19545, 0, 0
CREATE PROCEDURE [dbo].pts_Commission_Email
   @CompanyID int ,
   @RefID int ,
   @FromDate datetime ,
   @ToDate datetime
AS

SET NOCOUNT ON

--Get all Emails for a specific payment
IF @RefID > 0
BEGIN
	SELECT me.MemberID 'CommissionID', 
    me.Email 'Notes', MIN(co.Description) 'Description', SUM(co.Total) 'Total'
	FROM Commission AS co
	JOIN Member AS me ON co.OwnerID = me.MemberID AND co.OwnerType = 4
	WHERE co.RefID = @RefID
	GROUP BY me.MemberID, me.Email		
END

--Get all Emails for a specific date range
IF @RefID = 0
BEGIN
	SET @ToDate = DATEADD(d,1,@ToDate)
	SELECT me.MemberID 'CommissionID', 
    me.Email 'Notes', MIN(co.Description) 'Description', SUM(co.Total) 'Total'
	FROM Commission AS co
	JOIN Member AS me ON co.OwnerID = me.MemberID AND co.OwnerType = 4
	WHERE co.CompanyID = @CompanyID AND co.CommDate >= @FromDate AND co.CommDate < @ToDate
	GROUP BY me.MemberID, me.Email		
END

GO