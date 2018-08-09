EXEC [dbo].pts_CheckProc 'pts_CommType_Delete'
 GO

CREATE PROCEDURE [dbo].pts_CommType_Delete ( 
   @CommTypeID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE ct
FROM CommType AS ct
WHERE ct.CommTypeID = @CommTypeID

GO