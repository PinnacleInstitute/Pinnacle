EXEC [dbo].pts_CheckProc 'pts_Goal_Update'
 GO

CREATE PROCEDURE [dbo].pts_Goal_Update ( 
   @GoalID int,
   @MemberID int,
   @ParentID int,
   @AssignID int,
   @CompanyID int,
   @ProspectID int,
   @GoalName nvarchar (60),
   @Description nvarchar (2000),
   @GoalType int,
   @Priority int,
   @Status int,
   @CreateDate datetime,
   @CommitDate datetime,
   @CompleteDate datetime,
   @Variance int,
   @RemindDate datetime,
   @Template int,
   @Children int,
   @Qty int,
   @ActQty int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE go
SET go.MemberID = @MemberID ,
   go.ParentID = @ParentID ,
   go.AssignID = @AssignID ,
   go.CompanyID = @CompanyID ,
   go.ProspectID = @ProspectID ,
   go.GoalName = @GoalName ,
   go.Description = @Description ,
   go.GoalType = @GoalType ,
   go.Priority = @Priority ,
   go.Status = @Status ,
   go.CreateDate = @CreateDate ,
   go.CommitDate = @CommitDate ,
   go.CompleteDate = @CompleteDate ,
   go.Variance = @Variance ,
   go.RemindDate = @RemindDate ,
   go.Template = @Template ,
   go.Children = @Children ,
   go.Qty = @Qty ,
   go.ActQty = @ActQty
FROM Goal AS go
WHERE go.GoalID = @GoalID

GO