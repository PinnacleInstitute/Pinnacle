EXEC [dbo].pts_CheckProc 'pts_SalesZip_Delete'
 GO

CREATE PROCEDURE [dbo].pts_SalesZip_Delete ( 
   @SalesZipID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE slz
FROM SalesZip AS slz
WHERE slz.SalesZipID = @SalesZipID

GO