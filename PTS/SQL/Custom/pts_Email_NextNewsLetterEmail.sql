EXEC [dbo].pts_CheckProc 'pts_Email_NextNewsLetterEmail'
 GO

CREATE PROCEDURE [dbo].pts_Email_NextNewsLetterEmail (
	@EmailID int OUTPUT
	)
AS

SET NOCOUNT ON

DECLARE @Now datetime

SET @Now = dbo.wtfn_DateOnly(GETDATE())

SELECT TOP 1 @EmailID = EmailID FROM Email
WHERE	Status = 2
AND     SendDate <= @Now
AND     EmailType = 3

IF @EmailID IS NULL
	SET @EmailID = 0

GO

