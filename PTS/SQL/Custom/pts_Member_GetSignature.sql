EXEC [dbo].pts_CheckProc 'pts_Member_GetSignature'
GO

CREATE PROCEDURE [dbo].pts_Member_GetSignature
   @MemberID int ,
   @Quantity int ,
   @Amount int ,
   @Fax nvarchar (30) ,
   @Result nvarchar (3000) OUTPUT
AS

SET NOCOUNT ON

DECLARE @UseType int, @UseID int, @Language nvarchar (30)
SET @UseType = @Quantity
SET @UseID = @Amount
SET @Language = @Fax
SET @Result = ''

SELECT TOP 1 @Result = Data FROM Signature 
WHERE MemberID = @MemberID AND UseType = @UseType AND UseID = @UseID AND [Language] = @Language AND IsActive = 1

IF @Result = '' AND @UseType > 0
BEGIN
	SELECT TOP 1 @Result = Data FROM Signature 
	WHERE MemberID = @MemberID AND UseType = @UseType AND UseID = 0 AND [Language] = @Language AND IsActive = 1
END

IF @Result = ''
BEGIN
	SELECT TOP 1 @Result = Data FROM Signature 
	WHERE MemberID = @MemberID AND UseType = 1 AND [Language] = @Language AND IsActive = 1
END

GO
