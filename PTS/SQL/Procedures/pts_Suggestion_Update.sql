EXEC [dbo].pts_CheckProc 'pts_Suggestion_Update'
 GO

CREATE PROCEDURE [dbo].pts_Suggestion_Update ( 
   @SuggestionID int,
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

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE sg
SET sg.OrgID = @OrgID ,
   sg.MemberID = @MemberID ,
   sg.Subject = @Subject ,
   sg.Description = @Description ,
   sg.Status = @Status ,
   sg.SuggestionDate = @SuggestionDate ,
   sg.Response = @Response ,
   sg.ChangeDate = @ChangeDate
FROM Suggestion AS sg
WHERE sg.SuggestionID = @SuggestionID

GO