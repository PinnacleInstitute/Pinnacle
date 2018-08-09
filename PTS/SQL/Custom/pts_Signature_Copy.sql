EXEC [dbo].pts_CheckProc 'pts_Signature_Copy'
GO

CREATE PROCEDURE [dbo].pts_Signature_Copy
   @MemberID int ,
   @UseID int ,
   @Language nvarchar (6) ,
   @CopyID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON
SET @Result = 0

IF @UseID <> @CopyID
BEGIN
	DELETE Signature WHERE MemberID = @MemberID AND UseID = @UseID AND Language = @Language AND UseType >= 7

	INSERT INTO Signature ( MemberID, UseType, UseID, IsActive, Data, Language )
		SELECT @MemberID, UseType, @UseID, 1, Data, @Language FROM Signature
		WHERE MemberID = @MemberID AND UseID = @CopyID AND Language = @Language AND UseType >= 7
END
GO

