EXEC [dbo].pts_CheckProc 'pts_MemberContest_Delete'
 GO

CREATE PROCEDURE [dbo].pts_MemberContest_Delete ( 
   @MemberContestID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE mcn
FROM MemberContest AS mcn
WHERE mcn.MemberContestID = @MemberContestID

GO