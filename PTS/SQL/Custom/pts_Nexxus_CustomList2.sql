EXEC [dbo].pts_CheckProc 'pts_Nexxus_CustomList2'
GO

--EXEC pts_Nexxus_CustomList2 1, 0, 0, 0, 'CITY:Dallas,Plano'
--EXEC pts_Nexxus_CustomList2 1, 0, 0, 0, 'TX,Texas'

CREATE PROCEDURE [dbo].pts_Nexxus_CustomList2
   @Status int ,
   @czDate datetime ,
   @Quantity int ,
   @Amount int ,
   @Result varchar(1000) 
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @Result2 varchar(100), @pos int
SET @CompanyID = 21
SET @Result2 = ''

IF @Status = 1
BEGIN
	IF LEFT(@Result,5) = 'CITY:'
	BEGIN
		SET @Result = SUBSTRING(@Result, 6, 900)
		SET @pos = CHARINDEX(',', @Result)
		If @pos > 0
		BEGIN
			SET @Result2 = SUBSTRING(@Result, @pos + 1, 100)
			SET @Result = SUBSTRING(@Result, 1, @pos-1)		
		END
		SELECT me.MemberID 'NexxusID',  ad.Zip + ' ' + ad.city + ', ' + Ad.State + ' - ' + ad.Street1 + ' ' + ad.Street2 + ' - #' +  CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast + ' - ' + CAST(me.Title AS VARCHAR(2)) + ' - ' + me.Email AS 'Result' 
		FROM Address AS ad
		JOIN Member AS me ON ad.OwnerID = me.MemberID
		WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND ad.AddressType = 2 AND ad.IsActive = 1
		AND ad.City IN ( @Result, @Result2 )
		ORDER BY Zip
	END
	IF LEFT(@Result,5) != 'CITY:'
	BEGIN
		SET @pos = CHARINDEX(',', @Result)
		If @pos > 0
		BEGIN
			SET @Result2 = SUBSTRING(@Result, @pos + 1, 100)
			SET @Result = SUBSTRING(@Result, 1, @pos-1)		
		END
		SELECT me.MemberID 'NexxusID',  ad.Zip + ' ' + ad.city + ', ' + Ad.State + ' - ' + ad.Street1 + ' ' + ad.Street2 + ' - #' +  CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast + ' - ' + CAST(me.Title AS VARCHAR(2)) + ' - ' + me.Email AS 'Result' 
		FROM Address AS ad
		JOIN Member AS me ON ad.OwnerID = me.MemberID
		WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND ad.AddressType = 2 AND ad.IsActive = 1
		AND ad.State IN ( @Result, @Result2 )
		ORDER BY Zip
	END
END

GO

