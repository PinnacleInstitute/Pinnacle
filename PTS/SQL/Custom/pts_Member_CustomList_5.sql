EXEC [dbo].pts_CheckProc 'pts_Member_CustomList_5'
GO

--EXEC pts_Member_CustomList_5 100, 4

-- CloudZow
CREATE PROCEDURE [dbo].pts_Member_CustomList_5
   @Status int ,
   @Level int
AS

SET NOCOUNT ON

--	Get member without tokens
IF @Status = 1
BEGIN
	Select me.MemberID, me.BillingID AS 'Status', 0 AS 'Level', 
	me.NameFirst + ' ' + me.NameLast + '|' + me.Email AS 'Signature' 
	FROM Member AS me
	JOIN Billing AS bi ON me.BillingID = bi.BillingID
	WHERE me.CompanyID = 5 AND me.GroupID <> 100 AND bi.Verified = 0
	AND me.Status >= 1 AND me.Status <= 5
END

--	Get member with tokens
IF @Status = 2
BEGIN
	Select me.MemberID, me.BillingID AS 'Status', 0 AS 'Level', 
	me.Reference + '-' + CAST(bi.Token AS VARCHAR(15)) AS 'Signature' 
	FROM Member AS me
	JOIN Billing AS bi ON me.BillingID = bi.BillingID
	WHERE me.CompanyID = 5 AND me.GroupID <> 100 AND bi.Token > 0
	AND me.Status >= 1 AND me.Status <= 5
	AND me.MemberID >= 2618
	AND me.MemberID <= 12617
-- 2617, 
--	order by me.memberid
END

--	Get member with bad tokens
IF @Status = 101
BEGIN
	Select me.MemberID 'MemberID', me.Status AS 'Status', bi.BillingID 'Level',
	'#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast + ' - ' + me.Email AS 'Signature' 
	FROM Member AS me
	JOIN Billing AS bi ON me.BillingID = bi.BillingID
	WHERE me.CompanyID = 5 AND me.GroupID <> 100 AND bi.Verified = 1
	AND me.Status >= 1 AND me.Status <= 5
END


GO
