EXEC [dbo].pts_CheckProc 'pts_News_Avatar'
GO

--DECLARE @Image nvarchar(80) EXEC pts_News_Avatar 101, @Image OUTPUT PRINT @Image

CREATE PROCEDURE [dbo].pts_News_Avatar
   @AuthUserID int ,
   @Image nvarchar (80) OUTPUT
AS

SET NOCOUNT ON
DECLARE @UserGroup int, @MemberID int 

SET @Image = ''

SELECT @UserGroup = UserGroup FROM AuthUser WHERE AuthUserID = @AuthUserID

--Member
IF @UserGroup = 41
BEGIN
	SELECT @Image = Image FROM Member WHERE AuthUserID = @AuthUserID
END

--Org
IF @UserGroup = 51 OR @UserGroup = 52
BEGIN
	SET @MemberID = 0
	SELECT @MemberID = MemberID FROM Org WHERE AuthUserID = @AuthUserID
	IF @MemberID > 0
	BEGIN
		SELECT @Image = Image FROM Member WHERE MemberID = @MemberID
	END
END

--Employee
IF @UserGroup = 21 OR @UserGroup = 22 OR @UserGroup = 23 OR @UserGroup = 24
BEGIN
	SET @MemberID = 0
	SELECT @MemberID = MemberID FROM Employee WHERE AuthUserID = @AuthUserID
	IF @MemberID > 0
	BEGIN
		SELECT @Image = Image FROM Member WHERE MemberID = @MemberID
	END
END

GO