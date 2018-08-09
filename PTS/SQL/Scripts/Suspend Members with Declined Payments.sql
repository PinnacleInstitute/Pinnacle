--SELECT au.Logon, me.NameFirst, me.NameLast, me.Email, au.Password 
--FROM Member AS me
--JOIN Address AS ad ON me.MemberID = ad.OwnerID
--JOIN AuthUser AS au ON me.AuthUserID = au.AuthUserID
--WHERE CompanyID = 5 AND Status = 1 AND Level = 1
--AND ad.AddressType = 2 AND ad.IsActive = 0 AND ad.CountryID <> 224
--AND me.ConfLine = ''
--order by me.NameLast, me.namefirst

DECLARE @MemberID int, @Logon varchar(30), @PayID int, @ID int, @Now datetime
SET @Now = GETDATE()
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
select me.MemberID, au.Logon, me.PayID 
FROM Member AS me
JOIN Address AS ad ON me.MemberID = ad.OwnerID
JOIN AuthUser AS au ON me.AuthUserID = au.AuthUserID
WHERE CompanyID = 5 AND Status = 1 AND Level = 1
AND ad.AddressType = 2 AND ad.IsActive = 0 AND ad.CountryID <> 224
AND me.ConfLine = ''
and me.memberid=5342

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @Logon, @PayID
WHILE @@FETCH_STATUS = 0
BEGIN
	IF @PayID = 0
	BEGIN
--		-- BillingID,CountryID,Token,TokenType,Verified,BillingName,Street1,Street2,City,State,Zip,PayType,CommType,
--		-- CardType,CardNumber,CardMo,CardYr,CardName,CardCode,CheckBank,CheckRoute,CheckAccount,CheckAcctType,CheckNumber,CheckName,UpdatedDate,UserID
		EXEC pts_Billing_Add @ID OUTPUT,0,0,0,0,'','','','','','',0,4,0,@Logon,0,0,'','','','','',0,'','',@Now,1		
		UPDATE Member SET ConfLine = @Logon, PayID = @ID WHERE MemberID = @MemberID
	END
	ELSE
	BEGIN
		UPDATE Billing SET CommType=4, CardNumber=@Logon, UpdatedDate=@Now WHERE BillingID = @PayID AND CommType <>1 and CommType <> 2
		UPDATE Member SET ConfLine = @Logon WHERE MemberID = @MemberID
	END

	FETCH NEXT FROM Member_cursor INTO @MemberID, @Logon, @PayID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

--select * from Billing order by BillingID desc
--update Member set PayID = 4662 where MemberID = 5346