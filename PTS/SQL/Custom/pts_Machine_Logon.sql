EXEC [dbo].pts_CheckProc 'pts_Machine_Logon'
GO

--DECLARE @Result nvarchar (20)
--EXEC pts_Machine_Logon 'bob@pinnaclep.com', '12345678', @Result OUTPUT
--PRINT @Result

CREATE PROCEDURE [dbo].pts_Machine_Logon
   @Email nvarchar (80) ,
   @Password nvarchar (20) ,
   @Result nvarchar (20) OUTPUT
AS
-- RETURN VALUES
-- E1 ... Machine Email not found
-- E2 ... Password doesn't match machine email
-- C? ... Found Customer
-- M? ... Found Machine

SET NOCOUNT ON

DECLARE @MachineID int, @MemberID int,  @MachinePassword nvarchar (20),  @MemberEmail nvarchar (80)
SET @Result = 'E1'
SET @MachineID = 0
SET @MemberID = 0

-- find computer with email and password
SELECT @MachineID = MachineID, @MemberID = MemberID, @MachinePassword = [Password] FROM Machine WHERE Email = @Email

-- if found, check if the email is the same as the customer email
-- if so, return memberid (negated) else return machineid
IF @MachineID > 0
BEGIN
	IF @MachinePassword = @Password
	BEGIN
		SELECT @MemberEmail = Email FROM Member WHERE MemberID = @MemberID
		IF @MemberEmail = @Email
			SET @Result = 'C' + CAST(@MemberID AS VARCHAR(10))
		ELSE
			SET @Result = 'M' + CAST(@MachineID AS VARCHAR(10))
	END
	ELSE
	BEGIN
		SET @Result = 'E2'
	END
END

GO