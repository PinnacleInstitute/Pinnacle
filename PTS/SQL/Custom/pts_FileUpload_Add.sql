EXEC [dbo].pts_CheckProc 'pts_FileUpload_Add'
GO

CREATE PROCEDURE [dbo].pts_FileUpload_Add
   @FileUploadID int OUTPUT,
   @FileName varchar(128),
   @FileSize int,
   @Status int,
   @UploadIP varchar(15),
   @UploadDate datetime,
   @UserID int
AS

SET NOCOUNT ON

INSERT INTO FileUpload VALUES ( @FileName, @FileSize, @Status, @UploadIP, @UploadDate, @UserID )

SET @FileUploadID = @@IDENTITY

GO