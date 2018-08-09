EXEC [dbo].pts_CheckProc 'pts_Member_AddOrgMember'
GO

CREATE PROCEDURE [dbo].pts_Member_AddOrgMember
   @MemberID int,
   @OrgID int,
   @Exists int OUTPUT,
   @UserID int
   
AS

SET NOCOUNT ON

DECLARE  @Hierarchy varchar(100), @MemberCount int, @ID int

SELECT @Exists = OrgMemberID
	FROM OrgMember
	WHERE (MemberID = @MemberID) AND (OrgID = @OrgID)

IF (@Exists IS NULL)
BEGIN
INSERT INTO OrgMember (
	OrgID,
	MemberID )
VALUES (
	@OrgID,
	@MemberID )

END

--update member counter

IF (@Exists IS NULL)
BEGIN

		SET @Hierarchy = (SELECT Hierarchy FROM Org WHERE OrgID = @OrgID)

		DECLARE Org_cursor CURSOR FOR 
		SELECT  OrgID, MemberCount FROM Org
		WHERE @Hierarchy LIKE Hierarchy + '%'

		OPEN Org_cursor
		FETCH NEXT FROM Org_cursor INTO @ID, @MemberCount

		WHILE @@FETCH_STATUS = 0
		BEGIN

		UPDATE Org  
		SET MemberCount = (@MemberCount + 1)
		WHERE OrgID = @ID

		FETCH NEXT FROM Org_cursor INTO @ID, @MemberCount
		END

		CLOSE Org_cursor
		DEALLOCATE Org_cursor
END
IF (@Exists IS NULL)
    SET @Exists = 0			
GO