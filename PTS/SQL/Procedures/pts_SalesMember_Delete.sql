EXEC [dbo].pts_CheckProc 'pts_SalesMember_Delete'
 GO

CREATE PROCEDURE [dbo].pts_SalesMember_Delete ( 
   @SalesMemberID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE slm
FROM SalesMember AS slm
WHERE slm.SalesMemberID = @SalesMemberID

GO