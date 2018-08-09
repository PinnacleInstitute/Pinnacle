EXEC [dbo].pts_CheckProc 'pts_Consumer_Logon'
GO

--DECLARE @Result int EXEC pts_Consumer_Logon '4697671511', '123456', @Result OUTPUT PRINT @Result

CREATE PROCEDURE [dbo].pts_Consumer_Logon
   @Email nvarchar (80) ,
   @Password nvarchar (20) ,
   @Result int OUTPUT
AS
-- RETURN VALUES
-- >0 ... Found ConsumerID
-- -1000002 ... Consumer Email Address not found
-- -1000003 ... Consumer Phone Number not found
-- -1000004 ... Password not found
-- -1000005 ... Inactive Account

SET NOCOUNT ON

DECLARE @ConsumerID int, @logonemail int, @logonphone int, @Password1 nvarchar (20), @Status int

SET @logonemail = CHARINDEX( '@', @Email )
IF @logonemail = 0 SET @logonphone = 1 ELSE SET @logonphone = 0
SET @Result = 0
SET @ConsumerID = 0
	
IF @logonemail > 0 SELECT @ConsumerID = ConsumerID, @Password1 = Password, @Status = Status FROM Consumer WHERE Email = @Email
IF @logonphone > 0 SELECT @ConsumerID = ConsumerID, @Password1 = Password, @Status = Status FROM Consumer WHERE Phone = @Email
	
IF @ConsumerID > 0
BEGIN
	SET @Result = -1000004
	IF @Password = @Password1 SET @Result = @ConsumerID
	IF @Status <> 2 SET @Result = -1000005	
END
ELSE
BEGIN 
	IF @logonemail > 0 SET @Result = -1000002	
	IF @logonphone > 0 SET @Result = -1000003	
END	

GO