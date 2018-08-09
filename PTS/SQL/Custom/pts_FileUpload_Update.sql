EXEC [dbo].pts_CheckProc 'pts_FileUpload_Update'
GO

CREATE PROCEDURE [dbo].pts_FileUpload_Update
   @FileUploadID int,
   @FileName varchar(128),
   @FileSize int,
   @Status int,
   @UploadIP varchar(15),
   @UploadDate datetime,
   @UserID int
AS

SET NOCOUNT ON

UPDATE FileUpload 
SET
   FileName = @FileName,
   FileSize = @FileSize, 
   Status = @Status,
   UploadIP = @UploadIP,
   UploadDate = @UploadDate,
   UserID = @UserID
WHERE FileUploadID = @FileUploadID

GO