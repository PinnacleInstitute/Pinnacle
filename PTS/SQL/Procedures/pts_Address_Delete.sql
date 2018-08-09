EXEC [dbo].pts_CheckProc 'pts_Address_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Address_Delete ( 
   @AddressID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE ad
FROM Address AS ad
WHERE ad.AddressID = @AddressID

GO