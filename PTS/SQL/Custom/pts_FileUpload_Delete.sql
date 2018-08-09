EXEC [dbo].pts_CheckProc 'pts_FileUpload_Delete'
GO

CREATE PROCEDURE [dbo].pts_FileUpload_Delete
   @FileUploadID int
AS

SET NOCOUNT ON

DELETE FileUpload WHERE FileUploadID = @FileUploadID

GO