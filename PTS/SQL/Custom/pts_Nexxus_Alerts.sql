EXEC [dbo].pts_CheckProc 'pts_Nexxus_Alerts'
GO

--declare @Result varchar(1000) EXEC pts_Nexxus_Alerts 0, @Result output print @Result

CREATE PROCEDURE [dbo].pts_Nexxus_Alerts
   @MemberID int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
DECLARE @CompanyID int
SET @CompanyID = 21
SET @Result = '0'

IF @MemberID > 0
BEGIN
	EXEC pts_Nexxus_Alert @MemberID, @Result output
END

IF @MemberID = 0
BEGIN
	DECLARE @cnt int
	SET @cnt = 0
--	Clear all cancelled member alerts	
	UPDATE Member SET Role = '' WHERE CompanyID = @CompanyID AND Status > 5 AND Role <> ''
	
	DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
	SELECT MemberID FROM Member WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 5

	OPEN Member_cursor
	FETCH NEXT FROM Member_cursor INTO @MemberID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @Result = '0'
		EXEC pts_Nexxus_Alert @MemberID, @Result output
		IF @Result != '0' SET @cnt = @cnt + 1
		FETCH NEXT FROM Member_cursor INTO @MemberID
	END
	CLOSE Member_cursor
	DEALLOCATE Member_cursor
	
	SET @Result = CAST(@cnt AS VARCHAR(10))
END

GO