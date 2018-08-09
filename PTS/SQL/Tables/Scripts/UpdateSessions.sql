
SET NOCOUNT ON

DECLARE	@MemberID int, @SessionID int

DECLARE Session_Cursor CURSOR FOR 
SELECT SessionID FROM Session

OPEN Session_Cursor

FETCH NEXT FROM Session_Cursor INTO @SessionID

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_Session_SetStatus @SessionID, '', @MemberID
	FETCH NEXT FROM Session_Cursor INTO @SessionID
END

CLOSE Session_Cursor
DEALLOCATE Session_Cursor

--select * from session
