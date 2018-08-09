EXEC [dbo].pts_CheckProc 'pts_MemberNews_Delete'
 GO

CREATE PROCEDURE [dbo].pts_MemberNews_Delete ( 
   @MemberNewsID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE mn
FROM MemberNews AS mn
WHERE mn.MemberNewsID = @MemberNewsID

GO