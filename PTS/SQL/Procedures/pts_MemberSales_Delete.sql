EXEC [dbo].pts_CheckProc 'pts_MemberSales_Delete'
 GO

CREATE PROCEDURE [dbo].pts_MemberSales_Delete ( 
   @MemberSalesID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE ms
FROM MemberSales AS ms
WHERE ms.MemberSalesID = @MemberSalesID

GO