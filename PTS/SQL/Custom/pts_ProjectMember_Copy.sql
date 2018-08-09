EXEC [dbo].pts_CheckProc 'pts_ProjectMember_Copy'
GO
CREATE PROCEDURE [dbo].pts_ProjectMember_Copy
   @ProjectID int,
   @MemberID int,
   @Result int OUTPUT
AS

SET NOCOUNT ON

DECLARE @CopyFromID int
SET @CopyFromID = @MemberID

INSERT INTO ProjectMember ( ProjectID, MemberID, Status )
SELECT @ProjectID, MemberID, 1
FROM ProjectMember
WHERE ProjectID = @CopyFromID
AND MemberID NOT IN (SELECT MemberID FROM ProjectMember WHERE ProjectID = @ProjectID)

GO
