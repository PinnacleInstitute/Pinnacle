EXEC [dbo].pts_CheckProc 'pts_Member_ExistEmail'
GO

--DECLARE @MemberID int EXEC pts_Member_ExistEmail 21, 'samnikkel@gmail.com', @MemberID OUTPUT print @MemberID
 	
CREATE PROCEDURE [dbo].pts_Member_ExistEmail
   @CompanyID int ,
   @Email nvarchar(80) ,
   @MemberID int OUTPUT
AS

SET NOCOUNT ON
DECLARE @Status int

--Check for special processing
IF LEFT(@Email,2) = '**' 
BEGIN
	SET @Email = SUBSTRING(@Email,3,LEN(@Email))
--	Look for free members only
	SELECT @MemberID = MemberID, @Status = Status FROM Member WHERE CompanyID = @CompanyID AND Email = @Email AND Status = 3
END
ELSE
BEGIN
--	Nexxus - Don't look at Customers	
	IF @CompanyID = 21 
		SELECT @MemberID = MemberID, @Status = Status FROM Member WHERE CompanyID = @CompanyID AND Email = @Email AND Status NOT IN (0,3)
	ELSE
		SELECT @MemberID = MemberID, @Status = Status FROM Member WHERE CompanyID = @CompanyID AND Email = @Email AND Status > 0
END

IF @MemberID IS NULL SET @MemberID = 0

IF @MemberID > 0
BEGIN
--	If Suspended
	IF @Status = 4 SET @MemberID = @MemberID * -1
END

GO