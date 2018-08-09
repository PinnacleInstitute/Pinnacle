EXEC [dbo].pts_CheckProc 'pts_Guest_Update'
GO

CREATE PROCEDURE [dbo].pts_Guest_Update
   @GuestID int,
   @PartyID int,
   @NameLast nvarchar (15),
   @NameFirst nvarchar (15),
   @Email nvarchar (80),
   @Status int,
   @Attend bit,
   @Sale money,
   @UserID int
AS

DECLARE @mNow datetime, 
         @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()
UPDATE gu
SET gu.PartyID = @PartyID ,
   gu.NameLast = @NameLast ,
   gu.NameFirst = @NameFirst ,
   gu.Email = @Email ,
   gu.Status = @Status ,
   gu.Attend = @Attend ,
   gu.Sale = @Sale
FROM Guest AS gu
WHERE (gu.GuestID = @GuestID)


EXEC pts_Party_CalcSales
   @PartyID

GO