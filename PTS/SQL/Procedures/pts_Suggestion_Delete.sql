EXEC [dbo].pts_CheckProc 'pts_Suggestion_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Suggestion_Delete ( 
   @SuggestionID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE sg
FROM Suggestion AS sg
WHERE sg.SuggestionID = @SuggestionID

GO