EXEC [dbo].pts_CheckProc 'pts_Gift_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Gift_Delete ( 
   @GiftID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE gc
FROM Gift AS gc
WHERE gc.GiftID = @GiftID

GO