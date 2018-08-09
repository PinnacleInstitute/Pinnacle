EXEC [dbo].pts_CheckProc 'pts_Legacy_Qualified'
GO
--589
--542
--declare @Result varchar(1000) EXEC pts_Legacy_Qualified 2, '12/31/14', @Result output print @Result

CREATE PROCEDURE [dbo].pts_Legacy_Qualified
   @Status int ,
   @czDate datetime ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int, @MemberID int, @Count int, @Result2 int
SET @CompanyID = 14

--Initialize bad status members
IF @Status = 1 UPDATE Member SET Qualify = 0 WHERE CompanyID = @CompanyID AND Status <= 5 AND Qualify != 0
IF @Status = 2 UPDATE Member SET IsIncluded = 0 WHERE CompanyID = @CompanyID AND Status <= 5 AND IsIncluded != 0
	
DECLARE Member_cursor CURSOR FOR 
SELECT MemberID FROM Member WHERE CompanyID = @CompanyID
OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_Legacy_QualifiedMember @MemberID, @Status, @czDate, @Result2
	FETCH NEXT FROM Member_cursor INTO @MemberID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

--Get Qualified member count
IF @Status = 1 SELECT @Count = COUNT(*) FROM Member WHERE CompanyID = @CompanyID AND Qualify > 1
IF @Status = 2 SELECT @Count = COUNT(*) FROM Member WHERE CompanyID = @CompanyID AND IsIncluded != 0

SET @Result = CAST(@Count AS VARCHAR(10))

GO