EXEC [dbo].pts_CheckProc 'pts_SalesMember_Add'
 GO

CREATE PROCEDURE [dbo].pts_SalesMember_Add ( 
   @SalesMemberID int OUTPUT,
   @SalesAreaID int,
   @MemberID int,
   @Status int,
   @StatusDate datetime,
   @FTE int,
   @Assignment varchar (40),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO SalesMember (
            SalesAreaID , 
            MemberID , 
            Status , 
            StatusDate , 
            FTE , 
            Assignment
            )
VALUES (
            @SalesAreaID ,
            @MemberID ,
            @Status ,
            @StatusDate ,
            @FTE ,
            @Assignment            )

SET @mNewID = @@IDENTITY

SET @SalesMemberID = @mNewID

GO