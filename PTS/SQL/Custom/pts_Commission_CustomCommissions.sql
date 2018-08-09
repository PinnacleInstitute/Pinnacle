EXEC [dbo].pts_CheckProc 'pts_Commission_CustomCommissions'
GO

--DECLARE @Count int EXEC pts_Commission_CustomCommissions 14, 1, '3/9/14', '3/9/14', @Count OUTPUT PRINT @Count

CREATE PROCEDURE [dbo].pts_Commission_CustomCommissions
   @CompanyID int ,
   @CommType int ,
   @FromDate datetime ,
   @ToDate datetime ,
   @Count int OUTPUT
AS

SET NOCOUNT ON

--IF @CompanyID = 5 EXEC pts_Commission_Company_5 @CommType, @FromDate, @ToDate, @Count OUTPUT
IF @CompanyID = 7 EXEC pts_Commission_Company_7 @CommType, @FromDate, @ToDate, @Count OUTPUT
IF @CompanyID = 8 EXEC pts_Commission_Company_8 @CommType, @FromDate, @ToDate, @Count OUTPUT
--IF @CompanyID = 9 EXEC pts_Commission_Company_9 @CommType, @FromDate, @ToDate, @Count OUTPUT
--IF @CompanyID = 10 EXEC pts_Commission_Company_10 @CommType, @FromDate, @ToDate, @Count OUTPUT
IF @CompanyID = 11 EXEC pts_Commission_Company_11 @CommType, @FromDate, @ToDate, @Count OUTPUT
IF @CompanyID = 13 EXEC pts_Commission_Company_13 @CommType, @FromDate, @ToDate, @Count OUTPUT
IF @CompanyID = 14 EXEC pts_Commission_Company_14 @CommType, @FromDate, @ToDate, @Count OUTPUT
IF @CompanyID = 15 EXEC pts_Commission_Company_15 @CommType, @FromDate, @ToDate, @Count OUTPUT
IF @CompanyID = 16 EXEC pts_Commission_Company_16 @CommType, @FromDate, @ToDate, @Count OUTPUT
IF @CompanyID = 17 EXEC pts_Commission_Company_17 @CommType, @FromDate, @ToDate, @Count OUTPUT
IF @CompanyID = 18 EXEC pts_Commission_Company_18 @CommType, @FromDate, @ToDate, @Count OUTPUT
IF @CompanyID = 19 EXEC pts_Commission_Company_19 @CommType, @FromDate, @ToDate, @Count OUTPUT
IF @CompanyID = 20 EXEC pts_Commission_Company_20 @CommType, @FromDate, @ToDate, @Count OUTPUT
IF @CompanyID = 21 EXEC pts_Commission_Company_21 @CommType, @FromDate, @ToDate, @Count OUTPUT
IF @CompanyID = -21 EXEC pts_Commission_Company_21_Reward @CommType, @FromDate, @ToDate, @Count OUTPUT
--IF @CompanyID = 2 EXEC pts_Commission_Company_2 @CommType, @FromDate, @ToDate, @Count OUTPUT
--IF @CompanyID = 6 EXEC pts_Commission_Company_6 @CommType, @FromDate, @ToDate, @Count OUTPUT
--IF @CompanyID = 12 EXEC pts_Commission_Company_12 @CommType, @FromDate, @ToDate, @Count OUTPUT

GO