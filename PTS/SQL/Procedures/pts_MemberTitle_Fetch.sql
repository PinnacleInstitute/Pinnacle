EXEC [dbo].pts_CheckProc 'pts_MemberTitle_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_MemberTitle_Fetch ( 
   @MemberTitleID int,
   @MemberID int OUTPUT,
   @TitleName nvarchar (40) OUTPUT,
   @TitleDate datetime OUTPUT,
   @Title int OUTPUT,
   @IsEarned bit OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = mt.MemberID ,
   @TitleName = ti.TitleName ,
   @TitleDate = mt.TitleDate ,
   @Title = mt.Title ,
   @IsEarned = mt.IsEarned
FROM MemberTitle AS mt (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (mt.MemberID = me.MemberID)
LEFT OUTER JOIN Title AS ti (NOLOCK) ON (me.CompanyID = ti.CompanyID AND mt.Title = ti.TitleNo)
WHERE mt.MemberTitleID = @MemberTitleID

GO