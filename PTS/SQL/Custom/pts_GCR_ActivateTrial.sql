EXEC [dbo].pts_CheckProc 'pts_GCR_ActivateTrial'
GO

CREATE PROCEDURE [dbo].pts_GCR_ActivateTrial
   @PaymentID int ,
   @MemberID int 
AS

SET NOCOUNT ON

DECLARE @Status int, @Now datetime, @Purpose nvarchar (100)

SELECT @Status = Status FROM Member WHERE MemberID = @MemberID
IF @Status = 2
BEGIN
	SET @Now = GETDATE()
	UPDATE Member SET Status = 1, EnrollDate = @Now WHERE MemberID = @MemberID
	SELECT @Purpose = Purpose FROM Payment WHERE PaymentID = @PaymentID
	IF CHARINDEX(@Purpose, '202,203,204,205,206,207,208') > 0
	BEGIN
		SET @Purpose = '10' + RIGHT(@Purpose,1)
		UPDATE Payment SET Purpose = @Purpose WHERE PaymentID = @PaymentID
	END
END

GO 
