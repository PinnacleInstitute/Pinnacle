EXEC [dbo].pts_CheckProc 'pts_NewsTopic_Delete'
 GO

CREATE PROCEDURE [dbo].pts_NewsTopic_Delete ( 
   @NewsTopicID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE nwt
FROM NewsTopic AS nwt
WHERE nwt.NewsTopicID = @NewsTopicID

GO