EXEC [dbo].pts_CheckProc 'pts_SIMS_Alert'
GO

--declare @Result varchar(1000) EXEC pts_SIMS_Alert 521, @Result output print @Result

CREATE PROCEDURE [dbo].pts_SIMS_Alert
   @MemberID int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @cnt int, @Alerts varchar(10)
SET @Alerts = ''

SELECT @cnt = COUNT(*) FROM Payment WHERE OwnerType = 4 AND OwnerID = @MemberID AND Status = 4
IF @cnt > 0 SET @Alerts = @Alerts + 'P'

UPDATE Member SET Role = @Alerts WHERE MemberID = @MemberID

SET @Result = CAST( LEN(@Alerts) AS VARCHAR(10))

GO

