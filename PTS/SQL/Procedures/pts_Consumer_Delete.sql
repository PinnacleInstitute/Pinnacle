EXEC [dbo].pts_CheckProc 'pts_Consumer_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Consumer_Delete ( 
   @ConsumerID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE csm
FROM Consumer AS csm
WHERE csm.ConsumerID = @ConsumerID

GO