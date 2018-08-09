EXEC [dbo].pts_CheckProc 'pts_SalesArea_Add'
 GO

CREATE PROCEDURE [dbo].pts_SalesArea_Add ( 
   @SalesAreaID int OUTPUT,
   @ParentID int,
   @MemberID int,
   @SalesAreaName varchar (40),
   @Status int,
   @StatusDate datetime,
   @Level int,
   @Density int,
   @Population int,
   @FTE money,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO SalesArea (
            ParentID , 
            MemberID , 
            SalesAreaName , 
            Status , 
            StatusDate , 
            Level , 
            Density , 
            Population , 
            FTE
            )
VALUES (
            @ParentID ,
            @MemberID ,
            @SalesAreaName ,
            @Status ,
            @StatusDate ,
            @Level ,
            @Density ,
            @Population ,
            @FTE            )

SET @mNewID = @@IDENTITY

SET @SalesAreaID = @mNewID

GO