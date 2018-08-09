EXEC [dbo].pts_CheckProc 'pts_Org_CreateHierarchy'
 GO

CREATE PROCEDURE [dbo].pts_Org_CreateHierarchy ( 
	@CompanyID int
      )
AS

SET         NOCOUNT ON

DECLARE	@OrgID int, @ParentID int
DECLARE	@Level int, @Hierarchy varchar(100)

DECLARE Org_cursor CURSOR FOR 
SELECT  OrgID, ParentID FROM Org
WHERE CompanyID = @CompanyID
ORDER BY [Level] ASC

OPEN Org_cursor
FETCH NEXT FROM Org_cursor INTO @OrgID, @ParentID

WHILE @@FETCH_STATUS = 0
BEGIN
	IF @ParentID = 0
	BEGIN
		SET @Level = 1
		SET @Hierarchy = '/'
	END
	ELSE
	BEGIN
		SELECT @Level = [Level] + 1, @Hierarchy = Hierarchy
		FROM Org
		WHERE OrgID = @ParentID
	END

	UPDATE Org
	SET [Level] = @Level, Hierarchy = @Hierarchy + LTRIM(RTRIM(CAST(OrgID AS varchar(10)))) + '/'
	WHERE OrgID = @OrgID

	FETCH NEXT FROM Org_cursor INTO @OrgID, @ParentID
END

CLOSE Org_cursor
DEALLOCATE Org_cursor

GO