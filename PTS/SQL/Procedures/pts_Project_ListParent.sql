EXEC [dbo].pts_CheckProc 'pts_Project_ListParent'
GO

CREATE PROCEDURE [dbo].pts_Project_ListParent
   @ParentID int
AS

SET NOCOUNT ON

SELECT      pj.ProjectID, 
         pj.ParentID, 
         LTRIM(RTRIM(me.NameFirst)) +  ' '  + LTRIM(RTRIM(me.NameLast)) AS 'MemberName', 
         pjt.ProjectTypeName AS 'ProjectTypeName', 
         pj.ProjectName, 
         pj.Description, 
         pj.Status, 
         pj.EstStartDate, 
         pj.ActStartDate, 
         pj.EstEndDate, 
         pj.ActEndDate, 
         pj.EstCost, 
         pj.TotCost, 
         pj.ForumID, 
         pj.IsChat, 
         pj.IsForum, 
         pj.Secure
FROM Project AS pj (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (pj.MemberID = me.MemberID)
LEFT OUTER JOIN ProjectType AS pjt (NOLOCK) ON (pj.ProjectTypeID = pjt.ProjectTypeID)
WHERE (pj.ParentID = @ParentID)

ORDER BY   pj.Seq , pj.ProjectName

GO