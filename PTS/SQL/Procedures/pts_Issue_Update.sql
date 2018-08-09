EXEC [dbo].pts_CheckProc 'pts_Issue_Update'
 GO

CREATE PROCEDURE [dbo].pts_Issue_Update ( 
   @IssueID int,
   @CompanyID int,
   @IssueCategoryID int,
   @SubmitID int,
   @IssueDate datetime,
   @IssueName nvarchar (60),
   @SubmittedBy nvarchar (40),
   @SubmitType int,
   @Priority int,
   @Description nvarchar (1000),
   @AssignedTo nvarchar (15),
   @Status int,
   @Notes nvarchar (2000),
   @ChangeDate datetime,
   @DueDate datetime,
   @DoneDate datetime,
   @Variance int,
   @InputValues nvarchar (500),
   @Rating int,
   @Outsource nvarchar (20),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE zis
SET zis.CompanyID = @CompanyID ,
   zis.IssueCategoryID = @IssueCategoryID ,
   zis.SubmitID = @SubmitID ,
   zis.IssueDate = @IssueDate ,
   zis.IssueName = @IssueName ,
   zis.SubmittedBy = @SubmittedBy ,
   zis.SubmitType = @SubmitType ,
   zis.Priority = @Priority ,
   zis.Description = @Description ,
   zis.AssignedTo = @AssignedTo ,
   zis.Status = @Status ,
   zis.Notes = @Notes ,
   zis.ChangeDate = @ChangeDate ,
   zis.DueDate = @DueDate ,
   zis.DoneDate = @DoneDate ,
   zis.Variance = @Variance ,
   zis.InputValues = @InputValues ,
   zis.Rating = @Rating ,
   zis.Outsource = @Outsource
FROM Issue AS zis
WHERE zis.IssueID = @IssueID

GO