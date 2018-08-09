EXEC [dbo].pts_CheckProc 'pts_Commission_AffiliateExec'
GO

CREATE PROCEDURE [dbo].pts_Commission_AffiliateExec
   @AffiliateID int OUTPUT
AS

SET NOCOUNT ON

--DECLARE @SponsorID int, @Rank int, @Status int
--
--SET @Status = 0
--SET @Rank = 0
--
--WHILE @AffiliateID > 0 AND @Status != 2 AND @Rank < 2
--BEGIN
	SET @SponsorID = 0
--	SELECT @SponsorID = SponsorID, @Status = Status, @Rank = Rank FROM Affiliate WHERE AffiliateID = @AffiliateID
--	SET @AffiliateID = @SponsorID
--END

GO
