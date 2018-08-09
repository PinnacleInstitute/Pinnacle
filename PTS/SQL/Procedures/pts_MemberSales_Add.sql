EXEC [dbo].pts_CheckProc 'pts_MemberSales_Add'
 GO

CREATE PROCEDURE [dbo].pts_MemberSales_Add ( 
   @MemberSalesID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO MemberSales (
            MemberID , 
            CompanyID , 
            SalesDate , 
            Title , 
            PV , 
            GV , 
            PV2 , 
            GV2
            )
VALUES (
            @MemberID ,
            @CompanyID ,
            @SalesDate ,
            @Title ,
            @PV ,
            @GV ,
            @PV2 ,
            @GV2            )

SET @mNewID = @@IDENTITY

SET @MemberSalesID = @mNewID

GO