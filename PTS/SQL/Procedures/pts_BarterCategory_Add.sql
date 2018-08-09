EXEC [dbo].pts_CheckProc 'pts_BarterCategory_Add'
 GO

CREATE PROCEDURE [dbo].pts_BarterCategory_Add ( 
   @BarterCategoryID int OUTPUT,
   @ParentID int,
   @BarterCategoryName varchar (40),
   @Status int,
   @CustomFields varchar (2000),
   @Children int,
   @Options varchar (10),
   @Seq int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO BarterCategory (
            ParentID , 
            BarterCategoryName , 
            Status , 
            CustomFields , 
            Children , 
            Options , 
            Seq
            )
VALUES (
            @ParentID ,
            @BarterCategoryName ,
            @Status ,
            @CustomFields ,
            @Children ,
            @Options ,
            @Seq            )

SET @mNewID = @@IDENTITY

SET @BarterCategoryID = @mNewID

GO