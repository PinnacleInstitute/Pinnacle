EXEC [dbo].pts_CheckProc 'pts_CloudZow_LeaderEmails'
GO

--DECLARE @Result varchar(1000) EXEC pts_CloudZow_LeaderEmails 661, @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_CloudZow_LeaderEmails
   @MemberID int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @SponsorID int, @Title int, @Email varchar(100),@ManagerEmail varchar(100),@DirectorEmail varchar(100),@ExecEmail varchar(100)
SET @CompanyID = 5

-- Process all affiliates at the bottom of the enroller hierarchy
--	-- Walk up the sponsor line and get the Email for upline Manager,Director and Executive
	
	--SELECT @SponsorID = SponsorID FROM Member WHERE CompanyID = @CompanyID AND [Level] = 1 AND Status >= 1 AND Status <= 5 and MemberId = @MemberID
		SET @ManagerEmail = ''
		SET @DirectorEmail = ''
		SET @ExecEmail = ''
		
		WHILE @MemberID > 0
		BEGIN
			SET @SponsorID = -1						
--			-- Get the current Affiliate's sponsor, Email and title
			SELECT @SponsorID = SponsorID, @Email = Email, @Title = Title FROM Member WHERE MemberID = @MemberID
--			-- TEST if we found the affiliate
			IF @SponsorID >= 0
			BEGIN
--				--Check for highest title
			   
				IF @Title >= 4 and @ManagerEmail = '' SET @ManagerEmail = @Email
				IF @Title >= 5 and @DirectorEmail = '' SET @DirectorEmail = @Email
				IF @Title >= 6 and @ExecEmail = '' SET @ExecEmail = @Email
				
				If @ExecEmail <> ''
					SET @MemberID = 0
				Else	
					SET @MemberID = @SponsorID
			END
			ELSE
				SET @MemberID = 0
		END

SET @Result = @ManagerEmail

If CHARINDEX (@DirectorEmail,@Result) = 0 SET @Result = @Result + ',' + @DirectorEmail
If CHARINDEX (@ExecEmail,@Result) = 0 SET @Result = @Result + ',' + @ExecEmail


GO
