EXEC [dbo].pts_CheckProc 'pts_Guest_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Guest_Fetch ( 
   @GuestID int,
   @PartyID int OUTPUT,
   @NameLast nvarchar (15) OUTPUT,
   @NameFirst nvarchar (15) OUTPUT,
   @GuestName nvarchar (32) OUTPUT,
   @Email nvarchar (80) OUTPUT,
   @Status int OUTPUT,
   @Attend bit OUTPUT,
   @Sale money OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @PartyID = gu.PartyID ,
   @NameLast = gu.NameLast ,
   @NameFirst = gu.NameFirst ,
   @GuestName = LTRIM(RTRIM(gu.NameLast)) +  ', '  + LTRIM(RTRIM(gu.NameFirst)) +  ''  ,
   @Email = gu.Email ,
   @Status = gu.Status ,
   @Attend = gu.Attend ,
   @Sale = gu.Sale
FROM Guest AS gu (NOLOCK)
WHERE gu.GuestID = @GuestID

GO