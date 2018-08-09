EXEC [dbo].pts_CheckProc 'pts_Emailee_Unsubscribe'
GO

CREATE PROCEDURE [dbo].pts_Emailee_Unsubscribe
   @EmaileeID int ,
   @EmailListID int,
   @Status int,
   @Return int OUTPUT

AS

SET         NOCOUNT ON

DECLARE @Source int

--Source is passed in as status
SET @Source = @Status

IF @Source = 0
BEGIN
	UPDATE Emailee SET Status = 3 WHERE EmaileeID = @EmaileeID
END
--IF @Source = 1
--BEGIN
--	UPDATE Guest SET EmailStatus = 3 WHERE GuestID = @EmaileeID
--END

SET @Return = 1

GO