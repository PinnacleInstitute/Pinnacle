EXEC [dbo].pts_CheckProc 'pts_Member_FundRaisingDetail'
GO

--EXEC pts_Member_FundRaisingDetail 84

CREATE PROCEDURE [dbo].pts_Member_FundRaisingDetail
   @MemberID int
AS

SET NOCOUNT ON

SELECT MemberID, 
       CompanyName, 
       EnrollDate, 
       Reference
FROM Member 
WHERE GroupID = @MemberID
AND MemberID != @MemberID
ORDER BY CompanyName

GO