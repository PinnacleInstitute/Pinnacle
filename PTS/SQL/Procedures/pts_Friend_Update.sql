EXEC [dbo].pts_CheckProc 'pts_Friend_Update'
 GO

CREATE PROCEDURE [dbo].pts_Friend_Update ( 
   @FriendID int,
   @MemberID int,
   @FriendGroupID int,
   @CountryID int,
   @NameLast nvarchar (30),
   @NameFirst nvarchar (30),
   @Email nvarchar (80),
   @FriendDate datetime,
   @Status int,
   @Zip nvarchar (10),
   @DOB datetime,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE fr
SET fr.MemberID = @MemberID ,
   fr.FriendGroupID = @FriendGroupID ,
   fr.CountryID = @CountryID ,
   fr.NameLast = @NameLast ,
   fr.NameFirst = @NameFirst ,
   fr.Email = @Email ,
   fr.FriendDate = @FriendDate ,
   fr.Status = @Status ,
   fr.Zip = @Zip ,
   fr.DOB = @DOB
FROM Friend AS fr
WHERE fr.FriendID = @FriendID

GO