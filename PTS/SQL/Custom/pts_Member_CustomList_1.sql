EXEC [dbo].pts_CheckProc 'pts_Member_CustomList_1'
GO

-- To The Nines
CREATE PROCEDURE [dbo].pts_Member_CustomList_1
   @Status int ,
   @Level int
AS

SET NOCOUNT ON

--	Get mailing list for New Consultants
IF @Status = 1
BEGIN
--	Get the CSV Mailing List for all these new members
	Select me.MemberID, 0 AS 'Status', 0 AS 'Level', 
	'"' + me.NameFirst + ' ' + me.NameLast + '","' + ad.Street1  + '","' + ad.Street2  + '","' + ad.City  + '","' + ad.State  + '","' + ad.Zip + '","' + co.CountryName + '"' AS 'Signature' 
	FROM Member AS me
	JOIN Address AS ad ON me.MemberID = ad.OwnerID AND ad.OwnerType = 4
	JOIN Country AS co ON ad.CountryID = co.CountryID
	WHERE me.CompanyID = 1 AND me.Process = 0 AND ad.AddressType = 2
END

GO
