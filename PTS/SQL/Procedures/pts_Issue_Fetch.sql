EXEC [dbo].pts_CheckProc 'pts_Issue_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Issue_Fetch ( 
   @IssueID int,
   @CompanyID int OUTPUT,
   @IssueCategoryID int OUTPUT,
   @SubmitID int OUTPUT,
   @IssueCategoryName nvarchar (20) OUTPUT,
   @InputOptions nvarchar (1000) OUTPUT,
   @IssueDate datetime OUTPUT,
   @IssueName nvarchar (60) OUTPUT,
   @SubmittedBy nvarchar (40) OUTPUT,
   @SubmitType int OUTPUT,
   @Priority int OUTPUT,
   @Description nvarchar (1000) OUTPUT,
   @AssignedTo nvarchar (15) OUTPUT,
   @Status int OUTPUT,
   @Notes nvarchar (2000) OUTPUT,
   @ChangeDate datetime OUTPUT,
   @DueDate datetime OUTPUT,
   @DoneDate datetime OUTPUT,
   @Variance int OUTPUT,
   @InputValues nvarchar (500) OUTPUT,
   @Rating int OUTPUT,
   @Outsource nvarchar (20) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = zis.CompanyID ,
   @IssueCategoryID = zis.IssueCategoryID ,
   @SubmitID = zis.SubmitID ,
   @IssueCategoryName = zic.IssueCategoryName ,
   @InputOptions = zic.InputOptions ,
   @IssueDate = zis.IssueDate ,
   @IssueName = zis.IssueName ,
   @SubmittedBy = zis.SubmittedBy ,
   @SubmitType = zis.SubmitType ,
   @Priority = zis.Priority ,
   @Description = zis.Description ,
   @AssignedTo = zis.AssignedTo ,
   @Status = zis.Status ,
   @Notes = zis.Notes ,
   @ChangeDate = zis.ChangeDate ,
   @DueDate = zis.DueDate ,
   @DoneDate = zis.DoneDate ,
   @Variance = zis.Variance ,
   @InputValues = zis.InputValues ,
   @Rating = zis.Rating ,
   @Outsource = zis.Outsource
FROM Issue AS zis (NOLOCK)
LEFT OUTER JOIN IssueCategory AS zic (NOLOCK) ON (zic.IssueCategoryID = zis.IssueCategoryID)
WHERE zis.IssueID = @IssueID

GO