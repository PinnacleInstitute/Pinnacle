EXEC [dbo].pts_CheckProc 'pts_Member_SetCommTitle'
GO

CREATE PROCEDURE [dbo].pts_Member_SetCommTitle
   @CompanyID int,
   @CommDate datetime
AS

SET NOCOUNT ON

DECLARE	@MemberID int, @Title int, @CommTitle int, @LastTitle int
IF @CommDate = 0 SET @CommDate = GETDATE()

DECLARE Member_cursor CURSOR FOR 
SELECT  MemberID, Title, CommTitle FROM Member WHERE CompanyID = @CompanyID AND Status < 6 

OPEN Member_cursor

FETCH NEXT FROM Member_cursor INTO @MemberID, @Title, @CommTitle

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @LastTitle = @Title
	SELECT TOP 1 @LastTitle = Title FROM MemberTitle WHERE MemberID = @MemberID AND TitleDate <= @CommDate ORDER BY TitleDate DESC

	IF @LastTitle <> @CommTitle UPDATE Member SET CommTitle = @LastTitle WHERE MemberID = @MemberID

	FETCH NEXT FROM Member_cursor INTO @MemberID, @Title, @CommTitle
END

CLOSE Member_cursor
DEALLOCATE Member_cursor







GO