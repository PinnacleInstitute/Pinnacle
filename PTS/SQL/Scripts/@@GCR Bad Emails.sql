----------------------------
-- GCR Bad emails
----------------------------

DECLARE @NoteID int, @MemberID int, @Today datetime
SET @Today = GETDATE()

DECLARE @tmp TABLE(
   Email nvarchar (80)
)
INSERT INTO @tmp (Email) VALUES  
('INSERT EMAIL ADDRESS AFTER THIS'),
('LAST ROW - do not delete this')

DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID FROM Member 
WHERE CompanyID = 17 AND Email IN (SELECT Email FROM @tmp)

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID
WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE Member SET IsMsg = 2 WHERE MemberID = @MemberID 

--	NoteID,OwnerType,OwnerID,AuthUserID,NoteDate,Notes,IsLocked,IsFrozen,IsReminder,UserID
--	EXEC pts_Note_Add @NoteID OUTPUT, 4, @MemberID, 1, @Today, 'Inactivated due to bad email account', 0, 0, 0, 1

	FETCH NEXT FROM Member_cursor INTO @MemberID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

GO


