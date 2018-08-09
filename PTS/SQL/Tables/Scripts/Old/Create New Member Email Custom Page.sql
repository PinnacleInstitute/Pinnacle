
SET NOCOUNT ON

DECLARE	@OrgID int, @PageSectionID int, @Path varchar(100)

DECLARE Org_Cursor CURSOR FOR 
SELECT OrgID FROM Org WHERE ParentID = 0

OPEN Org_Cursor

FETCH NEXT FROM Org_Cursor INTO @OrgID

WHILE @@FETCH_STATUS = 0
BEGIN

	SET @Path = 'C:\PTS\@Web\Sections\Orgs\' + CAST(@OrgID AS varchar(10)) + '\'
--	SET @Path = 'D:\@Source\Pinnacle\PTS\@Web\Sections\Orgs\' + CAST(@OrgID AS varchar(10)) + '\'

	EXEC pts_PageSection_Add @PageSectionID OUTPUT, @OrgID, 'New Member Email', 'newmember.htm', @Path, 'en', 750, 0, 1

	FETCH NEXT FROM Org_Cursor INTO @OrgID

END

CLOSE Org_Cursor
DEALLOCATE Org_Cursor

