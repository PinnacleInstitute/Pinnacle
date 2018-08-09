EXEC [dbo].pts_CheckProc 'pts_Downline_CalcTitleAll'
GO

CREATE PROCEDURE [dbo].pts_Downline_CalcTitleAll
   @CompanyID int , 
   @Result int OUTPUT
AS

-- rebuild all active member's titles
SET NOCOUNT ON
DECLARE @ParentID int, @ChildID int, @Title int

DECLARE Member_cursor CURSOR STATIC LOCAL FOR 
SELECT ReferralID, MemberID, Title FROM Member 
WHERE CompanyID = @CompanyID AND ReferralID > 0 AND Title > 0 AND Status <= 5 
ORDER BY EnrollDate DESC

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @ParentID, @ChildID, @Title
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_Downline_CalcTitle @CompanyID, @ParentID, @ChildID, @Title, 0
	FETCH NEXT FROM Member_cursor INTO @ParentID, @ChildID, @Title
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

GO

