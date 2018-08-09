EXEC [dbo].pts_CheckProc 'pts_Signature_GetPersonal'
GO

CREATE PROCEDURE [dbo].pts_Signature_GetPersonal
   @MemberID int ,
   @UseType int ,
   @UseID int ,
   @Language nvarchar (6) ,
   @Result nvarchar (3000) OUTPUT
AS

SET NOCOUNT ON

SET @Result = ''

SELECT TOP 1 @Result = Data FROM Signature 
WHERE MemberID = @MemberID AND UseType = @UseType AND UseID = @UseID AND [Language] = @Language AND IsActive = 1

IF @Result = '' AND @UseType > 0
BEGIN
	SELECT TOP 1 @Result = Data FROM Signature 
	WHERE MemberID = @MemberID AND UseType = @UseType AND UseID = 0 AND [Language] = @Language AND IsActive = 1
END

GO