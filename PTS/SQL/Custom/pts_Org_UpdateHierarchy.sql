EXEC [dbo].pts_CheckProc 'pts_Org_UpdateHierarchy'
 GO

CREATE PROCEDURE [dbo].pts_Org_UpdateHierarchy ( 
	@CompanyID int,
	@OrgID int,
	@ParentID int,
	@Level int,
	@Hierarchy varchar(100)
      )
AS

SET NOCOUNT ON

DECLARE	@LevelDiff int, @NewParentLevel int, @HSearch varchar(100), @HReplace varchar(100)
SELECT @HSearch = Hierarchy FROM Org WHERE OrgID = @OrgID
SELECT @HReplace = Hierarchy + CAST(@OrgID as varchar(10)) + '/', @NewParentLevel = [Level]
FROM Org WHERE OrgID = @ParentID
-- The old parent level = org.level - 1 (leveldiff = old parent level - new parent level)
SET @LevelDiff = (@Level-1) - @NewParentLevel

--UPDATE the org and all suborgs with the new Hierarchy and level
UPDATE Org
SET [Level]= [Level] - @LevelDiff, Hierarchy = REPLACE(Hierarchy, @HSearch, @HReplace)
WHERE CompanyID = @CompanyID AND Hierarchy LIKE @Hierarchy + '%'

GO