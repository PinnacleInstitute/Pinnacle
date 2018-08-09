EXEC [dbo].pts_CheckProc 'pts_MemberTitle_Delete'
 GO

CREATE PROCEDURE [dbo].pts_MemberTitle_Delete ( 
   @MemberTitleID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE mt
FROM MemberTitle AS mt
WHERE mt.MemberTitleID = @MemberTitleID

GO