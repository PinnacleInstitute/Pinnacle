EXEC [dbo].pts_CheckProc 'pts_Award_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Award_Delete ( 
   @AwardID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE awa
FROM Award AS awa
WHERE awa.AwardID = @AwardID

GO