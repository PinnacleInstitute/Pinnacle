EXEC [dbo].pts_CheckProc 'pts_Address_Activate'
GO

CREATE PROCEDURE [dbo].pts_Address_Activate
   @OwnerType int ,
   @OwnerID int ,
   @AddressType int ,
   @AddressID int ,
   @CopyID int OUTPUT
AS

SET NOCOUNT ON

UPDATE Address SET IsActive = 0 
WHERE OwnerType = @OwnerType AND OwnerID = @OwnerID AND AddressType = @AddressType AND AddressID != @AddressID

GO