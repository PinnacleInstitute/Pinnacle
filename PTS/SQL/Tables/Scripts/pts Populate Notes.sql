
DECLARE @NoteID int, @MemberID int, @AffiliateID int, @Notes varchar(1000), @Now datetime

SET @Now = GETDATE()

DECLARE Member_cursor CURSOR DYNAMIC FOR 
SELECT  MemberID, Notes FROM Member WHERE Notes != ''

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @Notes 

WHILE @@FETCH_STATUS = 0
BEGIN
--   	NoteID, OwnerType, OwnerID, AuthUserID, NoteDate, Notes, IsLocked, IsFrozen, UserID int
	EXEC pts_Note_Add @NoteID OUTPUT, 4, @MemberID, 0, @Now, @Notes, 0, 0, 1

	FETCH NEXT FROM Member_cursor INTO @MemberID, @Notes 
END

CLOSE Member_cursor
DEALLOCATE Member_cursor

DECLARE Affiliate_cursor CURSOR DYNAMIC FOR 
SELECT  AffiliateID, Notes FROM Affiliate WHERE Notes != ''

OPEN Affiliate_cursor
FETCH NEXT FROM Affiliate_cursor INTO @AffiliateID, @Notes 

WHILE @@FETCH_STATUS = 0
BEGIN
--   	NoteID, OwnerType, OwnerID, AuthUserID, NoteDate, Notes, IsLocked, IsFrozen, UserID int
	EXEC pts_Note_Add @NoteID OUTPUT, 6, @AffiliateID, 0, @Now, @Notes, 0, 0, 1

	FETCH NEXT FROM Affiliate_cursor INTO @AffiliateID, @Notes 
END

CLOSE Affiliate_cursor
DEALLOCATE Affiliate_cursor

DECLARE @NoteID int, @MemberID int, @AffiliateID int, @Notes varchar(1000), @Now datetime

SET @Now = GETDATE()
DECLARE @TrainerID int

DECLARE Trainer_cursor CURSOR DYNAMIC FOR 
SELECT  TrainerID, Notes FROM Trainer WHERE Notes != ''

OPEN Trainer_cursor
FETCH NEXT FROM Trainer_cursor INTO @TrainerID, @Notes 

WHILE @@FETCH_STATUS = 0
BEGIN
--   	NoteID, OwnerType, OwnerID, AuthUserID, NoteDate, Notes, IsLocked, IsFrozen, UserID int
	EXEC pts_Note_Add @NoteID OUTPUT, 3, @TrainerID, 0, @Now, @Notes, 0, 0, 1

	FETCH NEXT FROM Trainer_cursor INTO @TrainerID, @Notes 
END

CLOSE Trainer_cursor
DEALLOCATE Trainer_cursor

