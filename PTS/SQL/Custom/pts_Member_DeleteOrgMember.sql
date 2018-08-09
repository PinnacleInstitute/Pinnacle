EXEC [dbo].pts_CheckProc 'pts_Member_DeleteOrgMember'
GO

CREATE PROCEDURE [dbo].pts_Member_DeleteOrgMember
   @MemberID int,
   @OrgID int,
   @UserID int
AS

SET NOCOUNT ON

--decrement counter

DECLARE @MemberCount int, @Hierarchy varchar(100), @ID int

SET @Hierarchy = (SELECT Hierarchy FROM Org WHERE OrgID = @OrgID )

DECLARE Org_cursor CURSOR FOR 
SELECT  OrgID, MemberCount FROM Org
WHERE @Hierarchy LIKE Hierarchy + '%'

OPEN Org_cursor
FETCH NEXT FROM Org_cursor INTO @ID, @MemberCount

WHILE @@FETCH_STATUS = 0
BEGIN

UPDATE Org  
SET MemberCount = (@MemberCount - 1)
WHERE OrgID = @ID

FETCH NEXT FROM Org_cursor INTO @ID, @MemberCount
END

CLOSE Org_cursor
DEALLOCATE Org_cursor

--Delete record

DELETE 
FROM OrgMember
WHERE (MemberID = @MemberID)
AND ((OrgID = @OrgID ) OR (@OrgID  = 0))
	
GO