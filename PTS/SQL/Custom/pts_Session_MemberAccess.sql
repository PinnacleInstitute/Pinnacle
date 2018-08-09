EXEC [dbo].pts_CheckProc 'pts_Session_MemberAccess'
GO

--declare @Quantity int
--EXEC pts_Session_MemberAccess 1053, '10/9/05', '10/20/05', @Quantity OUTPUT
--Print cast(@Quantity as varchar(10))

CREATE PROCEDURE [dbo].pts_Session_MemberAccess
   @OrgID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime ,
   @Quantity int OUTPUT
AS

SET NOCOUNT ON

DECLARE @ParentID int, @IsPublic bit, @CompanyID int

SELECT @CompanyID = CompanyID FROM Org WHERE OrgID = @OrgID

SET @ParentID = 1
WHILE @ParentID > 0
BEGIN
	SELECT @OrgID = OrgID, @ParentID = ParentID, @IsPublic = IsPublic
	FROM Org WHERE OrgID = @OrgID

--	If this folder is private 
	IF @IsPublic = 0
	BEGIN
--		Get the number of members included in this folder within the specified time frame
		SELECT @Quantity = COUNT(*) FROM OrgMember om
		JOIN Member AS me ON om.MemberID = me.MemberID
		WHERE om.OrgID = @OrgID 
		AND me.EnrollDate <= @ReportToDate
		AND (me.EndDate = 0 OR me.EndDate >= @ReportFromDate)

		SET @ParentID = 0
	END
--	Otherwise process the public folder
	ELSE
	BEGIN
--		If this public folder is the very top folder
		IF @ParentID = 0
		BEGIN
--			Get the number of all members in the company within the specified time frame
			SELECT @Quantity = COUNT(*) FROM Member
			WHERE CompanyID = @CompanyID 
			AND EnrollDate <= @ReportToDate
			AND (EndDate = 0 OR EndDate >= @ReportFromDate)
		END
--		Otherwise get the parent folder
		ELSE
		BEGIN
			SET @OrgID = @ParentID	
		END
	END
END	

GO
