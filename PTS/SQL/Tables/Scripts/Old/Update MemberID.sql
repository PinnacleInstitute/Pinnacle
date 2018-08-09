
--SET IDENTITY_INSERT to ON.
SET	IDENTITY_INSERT Member ON

--Add New Member
INSERT INTO Member (MemberID, NameLast, NameFirst) VALUES ( 1, 'Wood', 'Bob' )

SET IDENTITY_INSERT Member OFF


