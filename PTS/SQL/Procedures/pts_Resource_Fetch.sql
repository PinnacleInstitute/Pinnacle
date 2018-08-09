EXEC [dbo].pts_CheckProc 'pts_Resource_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Resource_Fetch ( 
   @ResourceID int,
   @MemberID int OUTPUT,
   @MemberName nvarchar (60) OUTPUT,
   @ShareName nvarchar (60) OUTPUT,
   @ResourceType int OUTPUT,
   @Share int OUTPUT,
   @ShareID int OUTPUT,
   @IsExclude bit OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = rs.MemberID ,
   @MemberName = me.CompanyName ,
   @ShareName = me2.CompanyName ,
   @ResourceType = rs.ResourceType ,
   @Share = rs.Share ,
   @ShareID = rs.ShareID ,
   @IsExclude = rs.IsExclude
FROM Resource AS rs (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (rs.MemberID = me.MemberID)
LEFT OUTER JOIN Member AS me2 (NOLOCK) ON (rs.ShareID = me2.MemberID)
WHERE rs.ResourceID = @ResourceID

GO