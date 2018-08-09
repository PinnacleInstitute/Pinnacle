EXEC [dbo].pts_CheckProc 'pts_Nexxus_Sales2'
GO

--declare @Result varchar(1000) EXEC pts_Nexxus_Sales2 @Result output print @Result

-- *******************************************************************
-- Recalculate all group sales volumes for matrix
-- *******************************************************************
CREATE PROCEDURE [dbo].pts_Nexxus_Sales2
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int, @MemberID int, @cnt int
SET @CompanyID = 21

--	Clear personal volume(BV2), group volume(QV2) and max title for all active affiliates
UPDATE Member SET BV2 = 0, QV2 = 0, QV3 = 0
WHERE CompanyID = @CompanyID 
--AND Status >= 1 AND Status <= 4

--	Set the Personal Referrals (active affiliates) (store in BV2) 
UPDATE me 
SET BV2 = (SELECT COUNT(MemberID) FROM Member WHERE SponsorID = me.MemberID AND Status >= 1 AND Status <= 4)
FROM Member AS me WHERE me.CompanyID = @CompanyID AND Status >= 1 AND me.Status <= 4

-- Set the number matrix members on the 3rd level
--UPDATE Member SET QV3 = (
--	SELECT COUNT(C.MemberID)
--	FROM Member As A
--	JOIN Member AS B ON A.MemberID = B.SponsorID
--	JOIN Member AS C ON B.MemberID = C.SponsorID
--	WHERE A.SponsorID = Member.MemberID AND C.Status >= 1 AND C.Status <= 4
--)
--WHERE CompanyID = @CompanyID

--	Process all affiliates at the bottom of the sponsor(matrix) hierarchy (BV2=0)
--	Walk up the referral line and store the Group Totals for each member in QV2 and the highest title in MaxMembers
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT SponsorID
FROM Member WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND BV2 = 0 AND SponsorID > 0
ORDER BY MemberID

SET @cnt = 0
OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID
WHILE @@FETCH_STATUS = 0
BEGIN
--SET @cnt = @cnt + 1
--print CAST(@cnt AS VARCHAR(10)) + ': ' + CAST(@MemberID AS VARCHAR(10)) + ' - ' + CAST(GETDATE() AS VARCHAR(20))
	EXEC pts_Nexxus_SetTotals2 @MemberID, 1, 1, @Result output
	FETCH NEXT FROM Member_cursor INTO @MemberID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

SET @Result = '1'

GO
