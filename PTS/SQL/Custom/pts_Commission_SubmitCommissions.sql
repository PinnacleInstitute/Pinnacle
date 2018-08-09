EXEC [dbo].pts_CheckProc 'pts_Commission_SubmitCommissions'
GO

CREATE PROCEDURE [dbo].pts_Commission_SubmitCommissions
   @CompanyID int ,
   @FromDate datetime ,
   @ToDate datetime ,
   @Count int OUTPUT
AS

SET NOCOUNT ON

SELECT @Count = COUNT(*) FROM Commission
WHERE CompanyID = @CompanyID
 AND  Status = 0
 AND  CommDate >= @FromDate
 AND  CommDate <= @ToDate

UPDATE Commission SET Status = 1 
WHERE CompanyID = @CompanyID
 AND  Status = 0
 AND  CommDate >= @FromDate
 AND  CommDate <= @ToDate

GO
