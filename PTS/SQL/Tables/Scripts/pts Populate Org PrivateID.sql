
DECLARE @OrgID int, @IsPublic bit, @PrivateID int

DECLARE Org_cursor CURSOR DYNAMIC FOR 
SELECT  og.OrgID, og.IsPublic, ISNULL(pog.PrivateID,0)
FROM Org AS og
LEFT OUTER JOIN Org AS pog ON og.ParentID = pog.OrgID
ORDER BY og.[Level]

OPEN Org_cursor
FETCH NEXT FROM Org_cursor INTO @OrgID, @IsPublic, @PrivateID 

WHILE @@FETCH_STATUS = 0
BEGIN
--print cast(@orgid as varchar(10)) + ', ' + cast(@IsPublic as varchar(10)) + ', ' + cast(@PrivateID as varchar(10))

	IF @IsPublic = 1
		UPDATE Org SET PrivateID = @PrivateID WHERE OrgID = @OrgID
	ELSE
		UPDATE Org SET PrivateID = @OrgID WHERE OrgID = @OrgID

	FETCH NEXT FROM Org_cursor INTO @OrgID, @IsPublic, @PrivateID 
END

CLOSE Org_cursor
DEALLOCATE Org_cursor

--select * from org where companyid=13
