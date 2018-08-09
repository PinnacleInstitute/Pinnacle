EXEC [dbo].pts_CheckProc 'pts_Suggestion_Add'
 GO

CREATE PROCEDURE [dbo].pts_Suggestion_Add ( 
   @SuggestionID int OUTPUT,
   @OrgID int,
   @MemberID int,
   @Subject nvarchar (60),
   @Description nvarchar (2000),
   @Status int,
   @SuggestionDate datetime,
   @Response nvarchar (1000),
   @ChangeDate datetime,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Suggestion (
            OrgID , 
            MemberID , 
            Subject , 
            Description , 
            Status , 
            SuggestionDate , 
            Response , 
            ChangeDate
            )
VALUES (
            @OrgID ,
            @MemberID ,
            @Subject ,
            @Description ,
            @Status ,
            @SuggestionDate ,
            @Response ,
            @ChangeDate            )

SET @mNewID = @@IDENTITY

SET @SuggestionID = @mNewID

GO