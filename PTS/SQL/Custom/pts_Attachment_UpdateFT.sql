EXEC [dbo].pts_CheckProc 'pts_Attachment_UpdateFT'
GO

CREATE PROCEDURE [dbo].pts_Attachment_UpdateFT
   @AttachmentID int,
   @AttachName nvarchar (60),
   @Description nvarchar (3000),
   @Result int OUTPUT
AS

DECLARE @ID int

SELECT @ID = @AttachmentID FROM AttachmentFT WHERE AttachmentID = @AttachmentID

IF @ID IS NULL
BEGIN
	INSERT INTO AttachmentFT ( AttachmentID, FT ) VALUES ( @AttachmentID, @AttachName + ' ' + @Description )

	SET @Result = 1
END
IF @ID > 0
BEGIN
	UPDATE AttachmentFT
	SET FT = @AttachName + ' ' + @Description
	WHERE AttachmentID = @AttachmentID

	SET @Result = 2
END

GO