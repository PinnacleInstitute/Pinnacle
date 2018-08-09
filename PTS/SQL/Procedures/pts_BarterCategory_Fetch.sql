EXEC [dbo].pts_CheckProc 'pts_BarterCategory_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_BarterCategory_Fetch ( 
   @BarterCategoryID int,
   @ParentID int OUTPUT,
   @BarterCategoryName varchar (40) OUTPUT,
   @Status int OUTPUT,
   @CustomFields varchar (2000) OUTPUT,
   @Children int OUTPUT,
   @Options varchar (10) OUTPUT,
   @Seq int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @ParentID = bca.ParentID ,
   @BarterCategoryName = bca.BarterCategoryName ,
   @Status = bca.Status ,
   @CustomFields = bca.CustomFields ,
   @Children = bca.Children ,
   @Options = bca.Options ,
   @Seq = bca.Seq
FROM BarterCategory AS bca (NOLOCK)
WHERE bca.BarterCategoryID = @BarterCategoryID

GO