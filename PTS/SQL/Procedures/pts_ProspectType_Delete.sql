EXEC [dbo].pts_CheckProc 'pts_ProspectType_Delete'
 GO

CREATE PROCEDURE [dbo].pts_ProspectType_Delete ( 
   @ProspectTypeID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE pt
FROM ProspectType AS pt
WHERE pt.ProspectTypeID = @ProspectTypeID

GO