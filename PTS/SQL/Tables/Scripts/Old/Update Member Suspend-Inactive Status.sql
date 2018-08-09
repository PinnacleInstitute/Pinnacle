
DECLARE @Now datetime, @NoteID int, @MemberID int, @ChangeDate datetime
SET @Now = GETDATE()

DECLARE Member_cursor CURSOR FOR 
SELECT MemberID, ChangeDate
FROM Member WHERE CompanyID = 13 AND Status = 4

OPEN Member_cursor

FETCH NEXT FROM Member_cursor INTO @MemberID, @ChangeDate

WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE Member SET Status = 5, EndDate = @ChangeDate WHERE MemberID = @MemberID

--	-- Add Note for Change
--      --  @NoteID,@OwnerType,@OwnerID,@AuthUserID,@NoteDate,@Notes,@IsLocked,@IsFrozen,@IsReminder,@UserID
	EXEC pts_Note_Add @NoteID OUTPUT, 4, @MemberID, 1, @Now, 'Status Changed from Suspended to Inactive', 1,0,0,1
	
	FETCH NEXT FROM Member_cursor INTO @MemberID, @ChangeDate
END

CLOSE Member_cursor
DEALLOCATE Member_cursor

DECLARE Member_cursor CURSOR FOR 
SELECT MemberID
FROM Member WHERE CompanyID = 13 AND Status = 5
OPEN Member_cursor

FETCH NEXT FROM Member_cursor INTO @MemberID 

WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE Member SET Status = 3 WHERE MemberID = @MemberID

--	-- Add Note for Change
--      --  @NoteID,@OwnerType,@OwnerID,@AuthUserID,@NoteDate,@Notes,@IsLocked,@IsFrozen,@IsReminder,@UserID
	EXEC pts_Note_Add @NoteID OUTPUT, 4, @MemberID, 1, @Now, 'Status Changed from Inactive to Development', 1,0,0,1
	
	FETCH NEXT FROM Member_cursor INTO @MemberID
END

CLOSE Member_cursor
DEALLOCATE Member_cursor

UPDATE au SET UserStatus = 1 
--select * 
FROM AuthUser AS au
JOIN Member AS me ON me.authuserid = au.authuserid
WHERE me.companyid = 13 AND au.userstatus = 2
