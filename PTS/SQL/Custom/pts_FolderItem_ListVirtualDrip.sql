EXEC [dbo].pts_CheckProc 'pts_FolderItem_ListVirtualDrip'
GO
--EXEC pts_FolderItem_ListVirtualDrip 13, 2, 3	

CREATE PROCEDURE [dbo].pts_FolderItem_ListVirtualDrip
   @CompanyID int ,
   @Target int ,
   @Days int
AS

SET NOCOUNT ON
DECLARE @Today datetime, @Status int, @Level int, @Title int
SET @Today = GETDATE()

-- Get Members BY Status / Level
IF @Target >= 1 AND @Target <= 15 
BEGIN
	 IF (@Target >= 1 AND @Target <= 5) SET @Status = 1
	 IF (@Target >= 6 AND @Target <= 10) SET @Status = 2
	 IF (@Target >= 11 AND @Target <= 15) SET @Status = 3
	 IF (@Target = 1 OR @Target = 6 OR @Target = 11) SET @Level = 0
	 IF (@Target = 2 OR @Target = 7 OR @Target = 12) SET @Level = 1
	 IF (@Target = 3 OR @Target = 8 OR @Target = 13) SET @Level = 2
	 IF (@Target = 4 OR @Target = 9 OR @Target = 14) SET @Level = 3
	 IF (@Target = 5 OR @Target = 10 OR @Target = 15) SET @Level = 4

	SELECT me.MemberID 'FolderItemID', me.MemberID 'ItemID', 
	me.NameFirst + '|' + me.NameLast + '|' + me.email + '|' + CAST(re.MemberID AS VARCHAR(10)) + '|' + re.NameFirst + '|' + re.NameLast + '|' + re.email + '|' + re.Phone1 + '|' + re.Signature + '|' + au.Logon AS 'Data'
	FROM Member AS me
	JOIN Member AS re ON me.ReferralID = re.MemberID
	JOIN AuthUser AS au ON me.AuthUserID = au.AuthUserID
	WHERE me.CompanyID = @CompanyID
	AND me.Status = @Status
	AND ( me.Level = @Level OR @Level = 4 )
	AND me.email LIKE '%@%' 
	AND DATEDIFF(d, me.EnrollDate, @Today) = @Days
END

-- Get Suspended, Inactive and Cancelled Members
IF @Target >= 16 AND @Target <= 18 
BEGIN
	 IF @Target = 16 SET @Status = 4
	 IF @Target = 17 SET @Status = 5
	 IF @Target = 18 SET @Status = 6

	SELECT me.MemberID 'FolderItemID', me.MemberID 'ItemID', 
	me.NameFirst + '|' + me.NameLast + '|' + me.email + '|' + CAST(re.MemberID AS VARCHAR(10)) + '|' + re.NameFirst + '|' + re.NameLast + '|' + re.email + '|' + re.Phone1 + '|' + re.Signature + '|' + au.Logon AS 'Data'
	FROM Member AS me
	JOIN Member AS re ON me.ReferralID = re.MemberID
	JOIN AuthUser AS au ON me.AuthUserID = au.AuthUserID
	WHERE me.CompanyID = @CompanyID
	AND me.Status = @Status
	AND me.email LIKE '%@%' 
	AND me.EndDate > 0 
	AND DATEDIFF(d, me.EndDate, @Today) = @Days
END

GO