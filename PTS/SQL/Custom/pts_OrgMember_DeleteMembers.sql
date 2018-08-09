EXEC [dbo].pts_CheckProc 'pts_OrgMember_DeleteMembers'
GO

CREATE PROCEDURE [dbo].pts_OrgMember_DeleteMembers
   @MemberID int ,
   @UserID int
AS

DECLARE @mID int

SET NOCOUNT ON

--Delete org members in orgmember with memberid 

				DECLARE OrgMember_cursor CURSOR FOR 
				SELECT  OrgID  FROM OrgMember
				WHERE   MemberID = @MemberID ORDER BY [OrgID] DESC

				OPEN OrgMember_cursor
				FETCH NEXT FROM OrgMember_cursor INTO @mID

				WHILE @@FETCH_STATUS = 0
				BEGIN

				EXEC pts_Member_DeleteOrgMember @MemberID,@mID,@UserID

				FETCH NEXT FROM OrgMember_cursor INTO @mID

				END

				CLOSE OrgMember_cursor
				DEALLOCATE OrgMember_cursor


GO