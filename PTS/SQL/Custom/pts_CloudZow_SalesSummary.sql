EXEC [dbo].pts_CheckProc 'pts_CloudZow_SalesSummary'
GO

--declare @Result varchar(1000) EXEC pts_CloudZow_SalesSummary '4/30/12', @Result output print @Result

CREATE PROCEDURE [dbo].pts_CloudZow_SalesSummary
   @czDate datetime ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int, @Count int
SET @CompanyID = 5

--	-- Create a record for each member that has any referrals (BV)
INSERT INTO MemberSales (MemberID, SalesDate, PV, GV ) 
	SELECT MemberID, @czDate, BV, QV
	FROM Member 
	WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Level = 1 AND BV > 0

SELECT @Count = COUNT(*) 
FROM MemberSales AS ms 
JOIN Member AS me ON ms.MemberID = me.MemberID
WHERE me.CompanyID = @CompanyID AND ms.SalesDate = @czDate

SET @Result = CAST(@Count AS VARCHAR(10))

GO