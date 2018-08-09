EXEC [dbo].pts_CheckProc 'pts_Member_SearchDownline'
GO

--DECLARE @Result nvarchar (100) EXEC pts_Member_SearchDownline 17, 12045, 1, 'Linda Helin', 1, @Result OUTPUT PRINT @Result

CREATE PROCEDURE [dbo].pts_Member_SearchDownline
   @CompanyID int ,
   @SponsorID int ,
   @Status int ,
   @CompanyName nvarchar (60) ,
   @Level int ,
   @Result nvarchar (100) OUTPUT
AS

SET NOCOUNT ON

DECLARE @MemberID int, @Pos int, @UplineID int, @tmp int, @Levels int
SET @MemberID = 0
SET @Pos = -1

-- Search by Last Name
IF @Status = 1
BEGIN
	SELECT TOP 1 @MemberID = MemberID FROM Member
	WHERE CompanyID = @CompanyID AND ISNULL(LTRIM(RTRIM(NameFirst)) +  ' '  + LTRIM(RTRIM(NameLast)), '') LIKE @CompanyName + '%'
END
-- Search by MemberID
IF @Status = 2
BEGIN
	SELECT @MemberID = MemberID FROM Member
	WHERE CompanyID = @CompanyID AND MemberID = CAST(@CompanyName AS Int)
END

SET @Levels = 1
IF @MemberID = @SponsorID
BEGIN
	SELECT @Pos = Pos FROM Member WHERE MemberID = @MemberID
END
ELSE
BEGIN
	IF @MemberID > 0
	BEGIN
		SET @UplineID = @MemberID
		WHILE @UplineID > 0
		BEGIN
			SET @tmp = -1
			IF @Level = 1 SELECT @UplineID = ReferralID, @tmp = Pos FROM Member WHERE MemberID = @UplineID
			IF @Level = 2 SELECT @UplineID = SponsorID,  @tmp = Pos FROM Member WHERE MemberID = @UplineID
			IF @Level = 3 SELECT @UplineID = MentorID,   @tmp = Pos FROM Member WHERE MemberID = @UplineID
			IF @Level = 4 SELECT @UplineID = Sponsor2ID, @tmp = Pos FROM Member WHERE MemberID = @UplineID
			IF @Level = 5 SELECT @UplineID = Sponsor3ID, @tmp = Pos FROM Member WHERE MemberID = @UplineID
	
			IF @tmp >= 0
			BEGIN
				IF @UplineID = @SponsorID 
				BEGIN 
					SET @Pos = @tmp
					SET @UplineID = 0 
				END 
				ELSE
					SET @Levels = @Levels + 1
			END
			ELSE SET @UplineID = 0
		END
	END
END

IF @Pos = -1 BEGIN SET @MemberID = 0 SET @Pos = 0 END

SET @Result = CAST(@MemberID AS VARCHAR(10)) + ':' + CAST(@Pos AS VARCHAR(10)) + ':' + CAST(@Levels AS VARCHAR(10))

GO