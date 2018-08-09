EXEC [dbo].pts_CheckProc 'pts_Favorite_Add'
 GO

CREATE PROCEDURE [dbo].pts_Favorite_Add ( 
   @FavoriteID int OUTPUT,
   @MemberID int,
   @RefType int,
   @RefID int,
   @FavoriteDate datetime,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Favorite (
            MemberID , 
            RefType , 
            RefID , 
            FavoriteDate
            )
VALUES (
            @MemberID ,
            @RefType ,
            @RefID ,
            @FavoriteDate            )

SET @mNewID = @@IDENTITY

SET @FavoriteID = @mNewID

GO