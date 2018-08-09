EXEC [dbo].pts_CheckProc 'pts_MemberTitle_ListMember'
GO

CREATE PROCEDURE [dbo].pts_MemberTitle_ListMember
   @MemberID int
AS

SET NOCOUNT ON

SELECT      mt.MemberTitleID, 
         mt.TitleDate, 
         mt.Title, 
         ti.TitleName AS 'TitleName', 
         mt.IsEarned
FROM MemberTitle AS mt (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (mt.MemberID = me.MemberID)
LEFT OUTER JOIN Title AS ti (NOLOCK) ON (me.CompanyID = ti.CompanyID AND mt.Title = ti.TitleNo)
WHERE (mt.MemberID = @MemberID)

ORDER BY   mt.TitleDate DESC

GO