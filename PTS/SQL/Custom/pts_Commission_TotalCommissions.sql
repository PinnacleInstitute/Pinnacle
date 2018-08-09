EXEC [dbo].pts_CheckProc 'pts_Commission_TotalCommissions'
GO

--DECLARE @Amount money EXEC pts_Commission_TotalCommissions 5, '2/7/13', @Amount OUTPUT PRINT @Amount

CREATE PROCEDURE [dbo].pts_Commission_TotalCommissions
   @CompanyID int ,
   @FromDate datetime ,
   @Amount money OUTPUT
AS

SET NOCOUNT ON
SELECT @Amount = ISNULL(SUM(Amount),0) FROM Commission WHERE CompanyID = @CompanyID AND dbo.wtfn_DateOnly(CommDate) = @FromDate 

GO