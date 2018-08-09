EXEC [dbo].pts_CheckProc 'pts_Member_Custom_1'
GO

--DECLARE @Result varchar(1000) EXEC pts_Member_Custom_1 1, 100, @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_Member_Custom_1
   @MemberID int ,
   @Status int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON

DECLARE @Level int

-- ***********************************************************************
--	Check for Member Credit (Payment)
-- ***********************************************************************
IF @Status = 100
BEGIN
	DECLARE @tmpAmount money
	SET @tmpAmount = 0
	SELECT @tmpAmount = ISNULL(SUM(Total),0) FROM Payment 
	WHERE OwnerType = 4 AND OwnerID = @MemberID AND PayType = 91 AND Total > 0

	SET @Result = CAST( @tmpAmount AS VARCHAR(10) )
END

GO