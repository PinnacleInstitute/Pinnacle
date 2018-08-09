EXEC [dbo].pts_CheckProc 'pts_Ad_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Ad_Delete ( 
   @AdID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE adv
FROM Ad AS adv
WHERE adv.AdID = @AdID

GO