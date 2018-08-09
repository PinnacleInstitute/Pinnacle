EXEC [dbo].pts_CheckProc 'pts_FreeLoyalty_CustomList'
GO

-- EXEC pts_FreeLoyalty_CustomList 3, 0, 0, 0

CREATE PROCEDURE [dbo].pts_FreeLoyalty_CustomList
   @Status int ,
   @czDate datetime ,
   @Quantity int ,
   @Amount int
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @Today datetime, @ToDate datetime
SET @CompanyID = 18
SET @Today = dbo.wtfn_DateOnly(GETDATE())


GO

