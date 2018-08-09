EXEC [dbo].pts_CheckProc 'pts_Friend_Add'
 GO

CREATE PROCEDURE [dbo].pts_Friend_Add ( 
   @FriendID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Friend (
            MemberID , 
            FriendGroupID , 
            CountryID , 
            NameLast , 
            NameFirst , 
            Email , 
            FriendDate , 
            Status , 
            Zip , 
            DOB
            )
VALUES (
            @MemberID ,
            @FriendGroupID ,
            @CountryID ,
            @NameLast ,
            @NameFirst ,
            @Email ,
            @FriendDate ,
            @Status ,
            @Zip ,
            @DOB            )

SET @mNewID = @@IDENTITY

SET @FriendID = @mNewID

GO