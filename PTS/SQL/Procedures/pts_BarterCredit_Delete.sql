EXEC [dbo].pts_CheckProc 'pts_BarterCredit_Delete'
 GO

CREATE PROCEDURE [dbo].pts_BarterCredit_Delete ( 
   @BarterCreditID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE bac
FROM BarterCredit AS bac
WHERE bac.BarterCreditID = @BarterCreditID

GO