EXEC [dbo].pts_CheckProc 'pts_Payout_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Payout_Delete ( 
   @PayoutID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE po
FROM Payout AS po
WHERE po.PayoutID = @PayoutID

GO