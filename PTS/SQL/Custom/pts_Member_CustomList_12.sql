EXEC [dbo].pts_CheckProc 'pts_Member_CustomList_12'
GO

--EXEC pts_Member_CustomList_12 200, 0

CREATE PROCEDURE [dbo].pts_Member_CustomList_12
   @Status int ,
   @Level int
AS

SET NOCOUNT ON
DECLARE @CompanyID int, @MemberID int
SET @CompanyID = 12
SET @MemberID = @Level

-- List Member List
IF @Status = 200
BEGIN
	Select ad.AddressID 'MemberID', 0 'Status', 0 'Level', 
	'"' + CAST(me.MemberID AS VARCHAR(10)) + '","' + CAST(me.ReferralID AS VARCHAR(10)) + '","' + CAST(me.Status AS VARCHAR(10)) + '","' + CAST(me.Level AS VARCHAR(10)) + '","' + me.NameFirst + '","' + me.NameLast + '","' + me.Email + '","' + me.Phone1 + '","' + ad.Street1 + '","' + ad.Street2 + '","' + ad.City + '","' + ad.State + '","' + ad.Zip + '","' + co.CountryName  + '"' AS 'Signature' 
	FROM Member AS me
	JOIN Address AS ad ON me.MemberID = ad.OwnerID
	JOIN Country AS co ON ad.CountryID = co.CountryID
	WHERE me.CompanyID = @CompanyID	
	AND ad.AddressType = 2 AND ad.IsActive <> 0
	ORDER BY me.EnrollDate 
END


GO
