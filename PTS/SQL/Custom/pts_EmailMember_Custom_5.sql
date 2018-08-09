EXEC [dbo].pts_CheckProc 'pts_EmailMember_Custom_5'
GO

--DECLARE @Result varchar(1000) EXEC pts_EmailMember_Custom_5 614, @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_EmailMember_Custom_5
   @MemberID int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @MemberID2 int, @ReferralID int, @SponsorID int, @Title int, @Level int, @Now datetime, @cnt int, @inc int
DECLARE @Email varchar(100),@ManagerEmail varchar(100),@DirectorEmail varchar(100),@ExecEmail varchar(100)

SET @CompanyID = 5


-- Process all affiliates at the bottom of the enroller hierarchy
--	-- Walk up the sponsor line and store the EmailId for upline Manager,Director and Executive
	
	--SELECT @SponsorID = SponsorID FROM Member WHERE CompanyID = @CompanyID AND [Level] = 1 AND Status >= 1 AND Status <= 5 and MemberId = @MemberID
	SET @SponsorID = @MemberID
		SET @ManagerEmail = ''
		SET @DirectorEmail = ''
		SET @ExecEmail = ''
		
		WHILE @SponsorID > 0
		BEGIN
						
--			-- Get the current Affiliate's sponsor, Email and title
			SELECT @SponsorID = SponsorID, @Email = Email, @Title = Title FROM Member WHERE MemberID = @SponsorID
--			-- TEST if we found the affiliate
			IF @SponsorID >= 0
			BEGIN
--				--Check for highest title
			   
				IF @Title >= 2 and @ManagerEmail = '' SET @ManagerEmail = @Email
				IF @Title >= 3 and @DirectorEmail = '' SET @DirectorEmail = @Email
				IF @Title >= 4 and @ExecEmail = '' SET @ExecEmail = @Email
				
				If @ExecEmail <> '' SET @SponsorID = 0
		
			END
			
		END
		

SET @Result = @ManagerEmail

If CHARINDEX (@DirectorEmail,@Result) = 0 SET @Result = @Result + ',' + @DirectorEmail
If CHARINDEX (@ExecEmail,@Result) = 0 SET @Result = @Result + ',' + @ExecEmail


GO
