EXEC [dbo].pts_CheckProc 'pts_DripTarget_ListTarget'
GO
--EXEC pts_DripTarget_ListTarget 3, 1, 4

CREATE PROCEDURE [dbo].pts_DripTarget_ListTarget
   @DripCampaignID int ,
   @Target int ,
   @Days int
AS

SET NOCOUNT ON
DECLARE @Today datetime
SET @Today = GETDATE()

-- Get Contacts
IF @Target = 1
BEGIN
	SELECT det.DripTargetID, det.TargetID, 
	pr.NameFirst + '|' + pr.NameLast + '|' + pr.email + '|' + CAST(me.MemberID AS VARCHAR(10)) + '|' + me.NameFirst + '|' + me.NameLast + '|' + me.email + '|' + me.Phone1 + '|' + me.Signature AS 'Data'
	FROM DripTarget AS det (NOLOCK)
	JOIN Prospect AS pr ON det.TargetID = pr.ProspectID
	JOIN Member AS me ON pr.MemberID = me.MemberID
	WHERE det.DripCampaignID = @DripCampaignID AND det.Status = 2
	AND pr.Status < 0 AND pr.EmailStatus <> 3 AND ( pr.email LIKE '%@%' )
	AND DATEDIFF(d, det.StartDate, @Today) = @Days
END

-- Get Prospects
IF @Target = 2
BEGIN
	SELECT det.DripTargetID, det.TargetID, 
	pr.NameFirst + '|' + pr.NameLast + '|' + pr.email + '|' + CAST(me.MemberID AS VARCHAR(10)) + '|' + me.NameFirst + '|' + me.NameLast + '|' + me.email + '|' + me.Phone1 + '|' + me.Signature AS 'Data'
	FROM DripTarget AS det (NOLOCK)
	JOIN Prospect AS pr ON det.TargetID = pr.ProspectID
	JOIN Member AS me ON pr.MemberID = me.MemberID
	WHERE det.DripCampaignID = @DripCampaignID AND det.Status = 2
	AND pr.Status > 0 AND pr.Status <> 4 AND pr.EmailStatus <> 3 AND ( pr.email LIKE '%@%' )
	AND DATEDIFF(d, det.StartDate, @Today) = @Days
END

-- Get Customers
IF @Target = 3
BEGIN
	SELECT det.DripTargetID, det.TargetID,
	pr.NameFirst + '|' + pr.NameLast + '|' + pr.email + '|' + CAST(me.MemberID AS VARCHAR(10)) + '|' + me.NameFirst + '|' + me.NameLast + '|' + me.email + '|' + me.Phone1 + '|' + me.Signature AS 'Data'
	FROM DripTarget AS det (NOLOCK)
	JOIN Prospect AS pr ON det.TargetID = pr.ProspectID
	JOIN Member AS me ON pr.MemberID = me.MemberID
	WHERE det.DripCampaignID = @DripCampaignID AND det.Status = 2
	AND pr.Status = 4 AND pr.EmailStatus <> 3 AND ( pr.email LIKE '%@%' )
	AND DATEDIFF(d, det.StartDate, @Today) = @Days
END

-- Get Members
IF @Target = 4
BEGIN
	SELECT det.DripTargetID, det.TargetID,
	me.NameFirst + '|' + me.NameLast + '|' + me.email + '|' + CAST(re.MemberID AS VARCHAR(10)) + '|' + re.NameFirst + '|' + re.NameLast + '|' + re.email + '|' + re.Phone1 + '|' + re.Signature AS 'Data'
	FROM DripTarget AS det (NOLOCK)
	JOIN Member AS me ON det.TargetID = me.MemberID
	JOIN Member AS re ON me.ReferralID = re.MemberID
	WHERE (det.DripCampaignID = @DripCampaignID)
	AND det.Status = 2 AND me.Status < 5 AND ( me.email LIKE '%@%' )
	AND DATEDIFF(d, det.StartDate, @Today) = @Days
END

GO