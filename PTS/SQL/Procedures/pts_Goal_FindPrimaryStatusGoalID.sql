EXEC [dbo].pts_CheckProc 'pts_Goal_FindPrimaryStatusGoalID'
 GO

CREATE PROCEDURE [dbo].pts_Goal_FindPrimaryStatusGoalID ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @Status int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), go.GoalID), '') + dbo.wtfn_FormatNumber(go.GoalID, 10) 'BookMark' ,
            go.GoalID 'GoalID' ,
            go.MemberID 'MemberID' ,
            go.ParentID 'ParentID' ,
            go.AssignID 'AssignID' ,
            go.CompanyID 'CompanyID' ,
            go.ProspectID 'ProspectID' ,
            me.NameLast 'NameLast' ,
            me.NameFirst 'NameFirst' ,
            LTRIM(RTRIM(me.NameFirst)) +  ' '  + LTRIM(RTRIM(me.NameLast)) 'MemberName' ,
            au.NameLast 'AssignNameLast' ,
            au.NameFirst 'AssignNameFirst' ,
            LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)) 'AssignName' ,
            pr.ProspectName 'ProspectName' ,
            go.GoalName 'GoalName' ,
            go.Description 'Description' ,
            go.GoalType 'GoalType' ,
            go.Priority 'Priority' ,
            go.Status 'Status' ,
            go.CreateDate 'CreateDate' ,
            go.CommitDate 'CommitDate' ,
            go.CompleteDate 'CompleteDate' ,
            go.Variance 'Variance' ,
            go.RemindDate 'RemindDate' ,
            go.Template 'Template' ,
            go.Children 'Children' ,
            go.Qty 'Qty' ,
            go.ActQty 'ActQty'
FROM Goal AS go (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (go.MemberID = me.MemberID)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (go.AssignID = au.AuthUserID)
LEFT OUTER JOIN Prospect AS pr (NOLOCK) ON (go.ProspectID = pr.ProspectID)
WHERE ISNULL(CONVERT(nvarchar(10), go.GoalID), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), go.GoalID), '') + dbo.wtfn_FormatNumber(go.GoalID, 10) >= @BookMark
AND         (go.MemberID = @MemberID)
AND         (go.Status = @Status)
AND         (go.ParentID = 0)
AND         (go.Template <> 1)
AND         (go.Template <> 2)
ORDER BY 'Bookmark'

GO