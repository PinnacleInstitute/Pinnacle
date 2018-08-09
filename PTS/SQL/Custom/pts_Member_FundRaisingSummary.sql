EXEC [dbo].pts_CheckProc 'pts_Member_FundRaisingSummary'
GO

--EXEC pts_Member_FundRaisingSummary 84

CREATE PROCEDURE [dbo].pts_Member_FundRaisingSummary
   @MemberID int
AS

SET NOCOUNT ON

SELECT Reference, 
       MIN(MemberID) 'MemberID', 
       COUNT(MemberID) 'Quantity'
FROM Member 
WHERE GroupID = @MemberID
AND MemberID != @MemberID
GROUP BY Reference
ORDER BY 'Quantity' DESC

GO