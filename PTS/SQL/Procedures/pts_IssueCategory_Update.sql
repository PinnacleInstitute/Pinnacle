EXEC [dbo].pts_CheckProc 'pts_IssueCategory_Update'
 GO

CREATE PROCEDURE [dbo].pts_IssueCategory_Update ( 
   @IssueCategoryID int,
   @CompanyID int,
   @IssueCategoryName nvarchar (40),
   @Seq int,
   @UserType int,
   @AssignedTo nvarchar (15),
   @InputOptions nvarchar (1000),
   @Email nvarchar (100),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE zic
SET zic.CompanyID = @CompanyID ,
   zic.IssueCategoryName = @IssueCategoryName ,
   zic.Seq = @Seq ,
   zic.UserType = @UserType ,
   zic.AssignedTo = @AssignedTo ,
   zic.InputOptions = @InputOptions ,
   zic.Email = @Email
FROM IssueCategory AS zic
WHERE zic.IssueCategoryID = @IssueCategoryID

GO