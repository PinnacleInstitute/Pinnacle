EXEC [dbo].pts_CheckProc 'pts_CloudZow_Cancel'
GO

--declare @Result varchar(1000) EXEC pts_CloudZow_Cancel 565, @Result output print @Result

CREATE PROCEDURE [dbo].pts_CloudZow_Cancel
   @MemberID int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int, @SponsorID int

SET @CompanyID = 5

-- *******************************************************************
-- Cancelled Affiliate
--  decrease downline count for the upline
-- *******************************************************************
SELECT @SponsorID = SponsorID FROM Member WHERE MemberID = @MemberID
SET @MemberID = @SponsorID

WHILE @MemberID > 0
BEGIN
	SET @SponsorID = -1
	SELECT @SponsorID = SponsorID FROM Member WHERE MemberID = @MemberID
--	TEST if we found the affiliate
	IF @SponsorID >= 0
	BEGIN
--		-- decrease downline count
		UPDATE Member SET BV4 = BV4 - 1 WHERE MemberID = @MemberID 
		SET @MemberID = @SponsorID
	END
	ELSE SET @MemberID = 0
END

SET @Result = '1'

GO