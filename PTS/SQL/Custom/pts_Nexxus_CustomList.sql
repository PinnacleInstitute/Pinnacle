EXEC [dbo].pts_CheckProc 'pts_Nexxus_CustomList'
GO

--EXEC pts_Nexxus_CustomList 11, 0, 0, 12046

CREATE PROCEDURE [dbo].pts_Nexxus_CustomList
   @Status int ,
   @czDate datetime ,
   @Quantity int ,
   @Amount int
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @StartDate datetime, @EndDate datetime, @Days int, @MiningDate datetime, @MemberID int
SET @CompanyID = 21


GO

