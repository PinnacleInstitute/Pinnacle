EXEC [dbo].pts_CheckProc 'pts_TellAll_CustomList'
GO

-- EXEC pts_TellAll_CustomList 3, 0, 0, 0

CREATE PROCEDURE [dbo].pts_TellAll_CustomList
   @Status int ,
   @czDate datetime ,
   @Quantity int ,
   @Amount int
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @Today datetime, @ToDate datetime
SET @CompanyID = 19
SET @Today = dbo.wtfn_DateOnly(GETDATE())


GO

