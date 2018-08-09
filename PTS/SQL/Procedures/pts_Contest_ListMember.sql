EXEC [dbo].pts_CheckProc 'pts_Contest_ListMember'
GO

CREATE PROCEDURE [dbo].pts_Contest_ListMember
   @MemberID int
AS

SET NOCOUNT ON

SELECT      .ContestID, 
         .ContestName, 
         .Description, 
         .Status, 
         .Metric, 
         .StartDate, 
         .EndDate, 
         .IsPrivate, 
         .MemberContestID
FROM Contest AS con (NOLOCK)
WHERE (con.MemberID = @MemberID)

ORDER BY   .ContestName

GO