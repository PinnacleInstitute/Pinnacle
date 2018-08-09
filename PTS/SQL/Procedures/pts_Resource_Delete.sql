EXEC [dbo].pts_CheckProc 'pts_Resource_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Resource_Delete ( 
   @ResourceID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE rs
FROM Resource AS rs
WHERE rs.ResourceID = @ResourceID

GO