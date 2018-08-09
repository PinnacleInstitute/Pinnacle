-----------------------------
-- Calculate Nexxus sponsors from GCR teams
-----------------------------
--12694
--13523
DECLARE @MemberID int, @Reference int, @ID int, @ReferralID int, @NexxusID int
--select * from Member where ReferralID = 12607
DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT memberid, CAST(Reference AS int) from Member where companyid = 21 and status = 1 and isnumeric(reference)=1
and memberid = 38273
--37786
--38560
--38869
--38444

--12694

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID, @Reference
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @ReferralID = 0
	SELECT @ReferralID = ISNULL(ReferralID,0) FROM Member WHERE CompanyID = 17 AND MemberID = @Reference
PRINT '---'
	WHILE @ReferralID > 0
	BEGIN
PRINT 'ReferralID: ' + CAST(@ReferralID AS VARCHAR(10))
		SET @NexxusID = 0
		SELECT @NexxusID = MemberID FROM Member WHERE CompanyID = 21 AND Status = 1 AND Reference = CAST(@ReferralID AS VARCHAR(10))

PRINT 'NexxusID: ' + CAST(@NexxusID AS VARCHAR(10))
		
		IF @NexxusID > 0
		BEGIN
			UPDATE Member SET ReferralID = @NexxusID WHERE MemberID = @MemberID
			SET @ReferralID = 0
			PRINT 'UPDATE: ' + CAST(@NexxusID AS VARCHAR(10))
		END
		ELSE 
		BEGIN
			SELECT @ReferralID = ISNULL(ReferralID,0) FROM Member WHERE CompanyID = 17 AND MemberID = @ReferralID
		END
	END

	FETCH NEXT FROM Member_Cursor INTO @MemberID, @Reference
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor


