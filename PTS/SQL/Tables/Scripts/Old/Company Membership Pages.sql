DECLARE @ID int, @PageSectionID int

DECLARE Company_cursor CURSOR LOCAL STATIC FOR 
SELECT  CompanyID FROM Company

OPEN Company_cursor
FETCH NEXT FROM Company_cursor INTO @ID

WHILE @@FETCH_STATUS = 0
BEGIN
--	PageSectionID, @CompanyID, @PageSectionName, @FileName, @Path, @Language, @Width, @Custom, @UserID
	EXEC pts_PageSection_Add @PageSectionID OUTPUT, @ID, 'Membership', 'membership.htm', '', 'en', '740', 3, 1

	FETCH NEXT FROM Company_cursor INTO @ID
END

CLOSE Company_cursor
DEALLOCATE Company_cursor

