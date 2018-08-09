EXEC [dbo].pts_CheckProc 'pts_Goal_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Goal_Fetch ( 
   @GoalID int,
   @MemberID int OUTPUT,
   @ParentID int OUTPUT,
   @AssignID int OUTPUT,
   @CompanyID int OUTPUT,
   @ProspectID int OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @MemberName nvarchar (62) OUTPUT,
   @AssignNameLast nvarchar (30) OUTPUT,
   @AssignNameFirst nvarchar (30) OUTPUT,
   @AssignName nvarchar (62) OUTPUT,
   @ProspectName nvarchar (60) OUTPUT,
   @GoalName nvarchar (60) OUTPUT,
   @Description nvarchar (2000) OUTPUT,
   @GoalType int OUTPUT,
   @Priority int OUTPUT,
   @Status int OUTPUT,
   @CreateDate datetime OUTPUT,
   @CommitDate datetime OUTPUT,
   @CompleteDate datetime OUTPUT,
   @Variance int OUTPUT,
   @RemindDate datetime OUTPUT,
   @Template int OUTPUT,
   @Children int OUTPUT,
   @Qty int OUTPUT,
   @ActQty int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = go.MemberID ,
   @ParentID = go.ParentID ,
   @AssignID = go.AssignID ,
   @CompanyID = go.CompanyID ,
   @ProspectID = go.ProspectID ,
   @NameLast = me.NameLast ,
   @NameFirst = me.NameFirst ,
   @MemberName = LTRIM(RTRIM(me.NameFirst)) +  ' '  + LTRIM(RTRIM(me.NameLast)) ,
   @AssignNameLast = au.NameLast ,
   @AssignNameFirst = au.NameFirst ,
   @AssignName = LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)) ,
   @ProspectName = pr.ProspectName ,
   @GoalName = go.GoalName ,
   @Description = go.Description ,
   @GoalType = go.GoalType ,
   @Priority = go.Priority ,
   @Status = go.Status ,
   @CreateDate = go.CreateDate ,
   @CommitDate = go.CommitDate ,
   @CompleteDate = go.CompleteDate ,
   @Variance = go.Variance ,
   @RemindDate = go.RemindDate ,
   @Template = go.Template ,
   @Children = go.Children ,
   @Qty = go.Qty ,
   @ActQty = go.ActQty
FROM Goal AS go (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (go.MemberID = me.MemberID)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (go.AssignID = au.AuthUserID)
LEFT OUTER JOIN Prospect AS pr (NOLOCK) ON (go.ProspectID = pr.ProspectID)
WHERE go.GoalID = @GoalID

GO