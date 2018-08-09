EXEC [dbo].pts_CheckProc 'pts_MemberSales_Update'
 GO

CREATE PROCEDURE [dbo].pts_MemberSales_Update ( 
   @MemberSalesID int,
   @MemberID int,
   @CompanyID int,
   @SalesDate datetime,
   @Title int,
   @PV money,
   @GV money,
   @PV2 money,
   @GV2 money,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE ms
SET ms.MemberID = @MemberID ,
   ms.CompanyID = @CompanyID ,
   ms.SalesDate = @SalesDate ,
   ms.Title = @Title ,
   ms.PV = @PV ,
   ms.GV = @GV ,
   ms.PV2 = @PV2 ,
   ms.GV2 = @GV2
FROM MemberSales AS ms
WHERE ms.MemberSalesID = @MemberSalesID

GO