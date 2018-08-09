EXEC [dbo].pts_CheckProc 'pts_Company_CustomList'
GO

--EXEC pts_Company_CustomList 7, 1, '1/29/13', 0, 0

CREATE PROCEDURE [dbo].pts_Company_CustomList
   @CompanyID int ,
   @Status int ,
   @EnrollDate datetime ,
   @Quantity int ,
   @Amount int
AS

SET NOCOUNT ON

IF @CompanyID = 7 EXEC pts_Company_CustomList_7 @Status, @EnrollDate, @Quantity, @Amount

GO