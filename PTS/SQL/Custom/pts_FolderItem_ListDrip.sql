EXEC [dbo].pts_CheckProc 'pts_FolderItem_ListDrip'
GO
--EXEC pts_FolderItem_ListDrip 13, 1, 0

CREATE PROCEDURE [dbo].pts_FolderItem_ListDrip
   @DripCampaignID int ,
   @Target int ,
   @Days int
AS

SET NOCOUNT ON
DECLARE @Today datetime
SET @Today = GETDATE()

-- Get Contacts, Prospects and Customers
IF @Target >= 1 AND @Target <= 3
BEGIN
	SELECT foi.FolderItemID, foi.ItemID, 
	pr.NameFirst + '|' + pr.NameLast + '|' + pr.email + '|' + CAST(me.MemberID AS VARCHAR(10)) + '|' + me.NameFirst + '|' + me.NameLast + '|' + me.email + '|' + me.Phone1 + '|' + me.Signature + '|' + au.Logon AS 'Data'
	FROM FolderItem AS foi (NOLOCK)
	JOIN Folder AS fo ON foi.FolderID = fo.FolderID
	JOIN Prospect AS pr ON foi.ItemID = pr.ProspectID
	JOIN Member AS me ON pr.MemberID = me.MemberID
	JOIN AuthUser AS au ON me.AuthUserID = au.AuthUserID
	WHERE fo.DripCampaignID = @DripCampaignID AND foi.Status = 1
	AND pr.Status < 0 AND pr.EmailStatus <> 3 AND ( pr.email LIKE '%@%' )
	AND DATEDIFF(d, foi.ItemDate, @Today) = @Days
END

-- Get Members
IF @Target = 4
BEGIN
	SELECT foi.FolderItemID, foi.ItemID, 
	me.NameFirst + '|' + me.NameLast + '|' + me.email + '|' + CAST(re.MemberID AS VARCHAR(10)) + '|' + re.NameFirst + '|' + re.NameLast + '|' + re.email + '|' + re.Phone1 + '|' + re.Signature + '|' + au.Logon AS 'Data'
	FROM FolderItem AS foi (NOLOCK)
	JOIN Folder AS fo ON foi.FolderID = fo.FolderID
	JOIN Member AS me ON foi.ItemID = me.MemberID
	JOIN Member AS re ON me.ReferralID = re.MemberID
	JOIN AuthUser AS au ON me.AuthUserID = au.AuthUserID
	WHERE (fo.DripCampaignID = @DripCampaignID)
	AND me.Status < 5 AND ( me.email LIKE '%@%' )
	AND DATEDIFF(d, foi.ItemDate, @Today) = @Days
END

GO