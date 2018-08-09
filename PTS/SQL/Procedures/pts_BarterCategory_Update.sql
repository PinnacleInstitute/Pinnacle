EXEC [dbo].pts_CheckProc 'pts_BarterCategory_Update'
 GO

CREATE PROCEDURE [dbo].pts_BarterCategory_Update ( 
   @BarterCategoryID int,
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

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE bca
SET bca.ParentID = @ParentID ,
   bca.BarterCategoryName = @BarterCategoryName ,
   bca.Status = @Status ,
   bca.CustomFields = @CustomFields ,
   bca.Children = @Children ,
   bca.Options = @Options ,
   bca.Seq = @Seq
FROM BarterCategory AS bca
WHERE bca.BarterCategoryID = @BarterCategoryID

GO