EXEC [dbo].pts_CheckProc 'pts_SalesOrder_Custom_1_Credit'
GO

--DECLARE @Credit money EXEC pts_SalesOrder_Custom_1_Credit 20, 1000, @Credit OUTPUT PRINT CAST(@Credit AS varchar(15))

CREATE PROCEDURE [dbo].pts_SalesOrder_Custom_1_Credit
   @Title int ,
   @Amt Money ,
   @Credit Money OUTPUT
AS

SET NOCOUNT ON

SET @Credit = 0

-- Preferred Customer
IF @Title = 1 SET @Credit = @Amt * .05
-- Retail Consultant
IF @Title = 2 SET @Credit = @Amt * .10
-- Senior Retail Consultant
IF @Title = 3 SET @Credit = @Amt * .12
-- Premier Retail Consultant
IF @Title = 4 SET @Credit = @Amt * .15
-- Manager
IF @Title = 10 SET @Credit = @Amt * .20
-- Executive Director
IF @Title = 11 SET @Credit = @Amt * .30
-- Regional Director or Vice Presidential Director
IF @Title = 12 OR @Title = 13 SET @Credit = @Amt * .40
-- Presidential Director or Ambassador
IF @Title = 14 OR @Title = 15 SET @Credit = @Amt * .50

GO