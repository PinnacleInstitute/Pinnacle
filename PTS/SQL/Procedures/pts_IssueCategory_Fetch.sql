EXEC [dbo].pts_CheckProc 'pts_IssueCategory_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_IssueCategory_Fetch ( 
   @IssueCategoryID int,
   @CompanyID int OUTPUT,
   @IssueCategoryName nvarchar (40) OUTPUT,
   @Seq int OUTPUT,
   @UserType int OUTPUT,
   @AssignedTo nvarchar (15) OUTPUT,
   @InputOptions nvarchar (1000) OUTPUT,
   @Email nvarchar (100) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = zic.CompanyID ,
   @IssueCategoryName = zic.IssueCategoryName ,
   @Seq = zic.Seq ,
   @UserType = zic.UserType ,
   @AssignedTo = zic.AssignedTo ,
   @InputOptions = zic.InputOptions ,
   @Email = zic.Email
FROM IssueCategory AS zic (NOLOCK)
WHERE zic.IssueCategoryID = @IssueCategoryID

GO