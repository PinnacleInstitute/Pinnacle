EXEC [dbo].pts_CheckProc 'pts_CloudZow_ExpiredFreeTrial'
GO

--declare @Result varchar(1000) EXEC pts_CloudZow_ExpiredFreeTrial @Result output print @Result

CREATE PROCEDURE [dbo].pts_CloudZow_ExpiredFreeTrial
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @Today datetime, @ToDate datetime

SET @Today = dbo.wtfn_DateOnly(GETDATE())
SET @ToDate = DATEADD(d, -30, @Today)

UPDATE Member SET Status = 6, EndDate = @Today 
--SELECT * FROM Member
WHERE CompanyID = 5 AND Status = 2 AND Level = 0 AND GroupID <> 100
AND EnrollDate < @Todate

SET @Result = '1'

GO