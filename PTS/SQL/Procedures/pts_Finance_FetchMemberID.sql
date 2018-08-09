EXEC [dbo].pts_CheckProc 'pts_Finance_FetchMemberID'
GO

CREATE PROCEDURE [dbo].pts_Finance_FetchMemberID
   @MemberID int ,
   @UserID int ,
   @FinanceID int OUTPUT
AS

DECLARE @mFinanceID int

SET NOCOUNT ON

SELECT      @mFinanceID = fi.FinanceID
FROM Finance AS fi (NOLOCK)
WHERE (fi.MemberID = @MemberID)


SET @FinanceID = ISNULL(@mFinanceID, 0)
GO