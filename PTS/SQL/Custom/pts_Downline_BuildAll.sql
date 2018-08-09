EXEC [dbo].pts_CheckProc 'pts_Downline_BuildAll'
GO

CREATE PROCEDURE [dbo].pts_Downline_BuildAll
   @CompanyID int , 
   @Result int OUTPUT
AS

-- rebuild all active member genealogies
SET NOCOUNT ON
DECLARE @ParentID int, @ChildID int

DECLARE Member_cursor CURSOR STATIC LOCAL FOR 
SELECT ReferralID, MemberID FROM Member 
WHERE CompanyID = @CompanyID AND ReferralID > 0 AND Status <= 5 ORDER BY EnrollDate

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @ParentID, @ChildID
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_Downline_Build @CompanyID, @ParentID, @ChildID, @Result OUTPUT
	FETCH NEXT FROM Member_cursor INTO @ParentID, @ChildID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

GO