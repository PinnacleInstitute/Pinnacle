EXEC [dbo].pts_CheckProc 'pts_FileUpload_Fetch'
GO

CREATE PROCEDURE [dbo].pts_FileUpload_Fetch
   @FileUploadID int,
   @FileName varchar(128) OUTPUT,
   @FileSize int OUTPUT,
   @Status integer OUTPUT,
   @UploadIP varchar(15) OUTPUT,
   @UploadDate datetime OUTPUT,
   @UserID int OUTPUT
AS

SET NOCOUNT ON

SELECT
   @FileName = FileName,
   @FileSize = FileSize, 
   @Status = Status,
   @UploadIP = UploadIP,
   @UploadDate = UploadDate,
   @UserID = UserID
FROM FileUpload
WHERE FileUploadID = @FileUploadID

GO