EXEC [dbo].pts_CheckProc 'pts_Friend_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Friend_Fetch ( 
   @FriendID int,
   @MemberID int OUTPUT,
   @FriendGroupID int OUTPUT,
   @CountryID int OUTPUT,
   @FriendGroupName nvarchar (40) OUTPUT,
   @CountryName nvarchar (50) OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @FriendName nvarchar (62) OUTPUT,
   @Email nvarchar (80) OUTPUT,
   @FriendDate datetime OUTPUT,
   @Status int OUTPUT,
   @Zip nvarchar (10) OUTPUT,
   @DOB datetime OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = fr.MemberID ,
   @FriendGroupID = fr.FriendGroupID ,
   @CountryID = fr.CountryID ,
   @FriendGroupName = frg.FriendGroupName ,
   @CountryName = cou.CountryName ,
   @NameLast = fr.NameLast ,
   @NameFirst = fr.NameFirst ,
   @FriendName = LTRIM(RTRIM(fr.NameLast)) +  ', '  + LTRIM(RTRIM(fr.NameFirst)) ,
   @Email = fr.Email ,
   @FriendDate = fr.FriendDate ,
   @Status = fr.Status ,
   @Zip = fr.Zip ,
   @DOB = fr.DOB
FROM Friend AS fr (NOLOCK)
LEFT OUTER JOIN FriendGroup AS frg (NOLOCK) ON (fr.FriendGroupID = frg.FriendGroupID)
LEFT OUTER JOIN Country AS cou (NOLOCK) ON (fr.CountryID = cou.CountryID)
WHERE fr.FriendID = @FriendID

GO