EXEC [dbo].pts_CheckProc 'pts_BarterArea_Add'
 GO

CREATE PROCEDURE [dbo].pts_BarterArea_Add ( 
   @BarterAreaID int OUTPUT,
   @ParentID int,
   @CountryID int,
   @ConsumerID int,
   @BarterAreaName varchar (40),
   @BarterAreaType int,
   @Status int,
   @Children int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO BarterArea (
            ParentID , 
            CountryID , 
            ConsumerID , 
            BarterAreaName , 
            BarterAreaType , 
            Status , 
            Children
            )
VALUES (
            @ParentID ,
            @CountryID ,
            @ConsumerID ,
            @BarterAreaName ,
            @BarterAreaType ,
            @Status ,
            @Children            )

SET @mNewID = @@IDENTITY

SET @BarterAreaID = @mNewID

GO