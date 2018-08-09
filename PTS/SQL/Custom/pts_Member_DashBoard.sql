EXEC [dbo].pts_CheckProc 'pts_Member_DashBoard'
 GO

--TEST-----------------------------------------------
--DECLARE @Result varchar(1000)
--EXEC pts_Member_DashBoard 84, 0, '1/1/05', 'gGE6', @Result OUTPUT
--PRINT @Result

CREATE PROCEDURE [dbo].pts_Member_DashBoard ( 
	@MemberID int ,
	@AuthUserID int ,
	@VisitDate datetime ,
   	@CompanyName nvarchar (60) ,
	@Result varchar(1000) OUTPUT
    )
AS

DECLARE	@30Date datetime, @Options nvarchar (60)
SET @30Date = DATEADD(day,-30,GETDATE())
SET @Options = @CompanyName

DECLARE @Mentorees int,
	@MentorNotes int,
	@Prospects int,
	@Prospects30 int,
	@ProspectsActive int,
	@Customers int

SET @Mentorees = 0
SET @MentorNotes = 0
SET @Prospects = 0
SET @Prospects30 = 0
SET @ProspectsActive = 0
SET @Customers = 0

-- Get Mentorees
IF CHARINDEX('g', @Options) > 0
BEGIN
	SELECT @Mentorees = COUNT(*) FROM Member WHERE MentorID = @MemberID
END

-- Get Mentor Notes, exclude notes posted by the current user
IF CHARINDEX('G', @Options) > 0 OR CHARINDEX('g', @Options) > 0
BEGIN
	SELECT @MentorNotes = COUNT(nt.noteid)
	FROM Note AS nt
	JOIN Member AS me ON nt.OwnerType = -4 AND nt.OwnerID = me.MemberID
	WHERE nt.NoteDate > @VisitDate AND (me.MemberID = @MemberID OR  me.MentorID = @MemberID)
	AND nt.AuthUserID <> @AuthUserID
END

-- Get New Prospects
IF CHARINDEX('E', @Options) > 0
BEGIN
	SELECT @Prospects = COUNT(ProspectID) FROM Prospect WHERE MemberID = @MemberID AND CreateDate > @VisitDate 

-- Get Prospects within 30 days
	SELECT @Prospects30 = COUNT(ProspectID) FROM Prospect WHERE MemberID = @MemberID AND CreateDate > @30Date

-- Get Active Prospects
	SELECT @ProspectsActive = COUNT(ProspectID) FROM Prospect 
	WHERE MemberID = @MemberID AND Status > 5 AND NextEvent <> 0 AND NextDate <> 0
END

-- Get Customers
IF CHARINDEX('6', @Options) > 0
BEGIN
	SELECT @Customers = COUNT(ProspectID) FROM Prospect WHERE MemberID = @MemberID AND Status = 4
END

SET @Result = '<PTSDB ' + 
'mentorees="'       + CAST(@Mentorees AS VARCHAR(10)) + '" ' +
'mentornotes="'     + CAST(@MentorNotes AS VARCHAR(10)) + '" ' +
'prospects="'       + CAST(@Prospects AS VARCHAR(10)) + '" ' +
'prospects30="'     + CAST(@Prospects30 AS VARCHAR(10)) + '" ' +
'prospectsactive="' + CAST(@ProspectsActive AS VARCHAR(10)) + '" ' +
'customers="'       + CAST(@Customers AS VARCHAR(10)) + '"/>'

GO
