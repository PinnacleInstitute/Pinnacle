EXEC [dbo].pts_CheckProc 'pts_ProjectType_Delete'
 GO

CREATE PROCEDURE [dbo].pts_ProjectType_Delete ( 
   @ProjectTypeID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE pjt
FROM ProjectType AS pjt
WHERE pjt.ProjectTypeID = @ProjectTypeID

GO