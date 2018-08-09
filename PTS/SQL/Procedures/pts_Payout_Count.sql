EXEC [dbo].pts_CheckProc 'pts_Payout_Count'
 GO

CREATE PROCEDURE [dbo].pts_Payout_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Payout AS po (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO