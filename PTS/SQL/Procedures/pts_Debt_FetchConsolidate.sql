EXEC [dbo].pts_CheckProc 'pts_Debt_FetchConsolidate'
GO

CREATE PROCEDURE [dbo].pts_Debt_FetchConsolidate
   @MemberID int ,
   @UserID int ,
   @DebtID int OUTPUT
AS

DECLARE @mDebtID int

SET NOCOUNT ON

SELECT      @mDebtID = de.DebtID
FROM Debt AS de (NOLOCK)
WHERE (de.MemberID = @MemberID)
 AND (de.IsConsolidate <> 0)


SET @DebtID = ISNULL(@mDebtID, 0)
GO