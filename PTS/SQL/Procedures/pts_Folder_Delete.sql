EXEC [dbo].pts_CheckProc 'pts_Folder_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Folder_Delete ( 
   @FolderID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE fo
FROM Folder AS fo
WHERE fo.FolderID = @FolderID

GO