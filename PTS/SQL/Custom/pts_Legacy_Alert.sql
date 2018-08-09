EXEC [dbo].pts_CheckProc 'pts_Legacy_Alert'
GO

--declare @Result varchar(1000) EXEC pts_Legacy_Alert 521, @Result output print @Result

CREATE PROCEDURE [dbo].pts_Legacy_Alert
   @MemberID int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @cnt int, @Alerts varchar(10), @NoteDate datetime
SET @Alerts = ''
SET @NoteDate = DATEADD(d,-14,GETDATE())

SELECT @cnt = COUNT(*) FROM Payment as pa
JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
WHERE so.MemberID = @MemberID AND pa.Status = 4
IF @cnt > 0
BEGIN
	SET @Alerts = @Alerts + 'P'
	SELECT @cnt = COUNT(*) FROM Note WHERE OwnerType = 4 AND OwnerID = @MemberID AND NoteDate > @NoteDate AND Notes LIKE 'Declined Payment Notice%'
	IF @cnt > 0 SET @Alerts = @Alerts + '*'
	SELECT @cnt = COUNT(*) FROM Note WHERE OwnerType = 4 AND OwnerID = @MemberID AND NoteDate <= @NoteDate AND Notes LIKE 'Declined Payment Notice%'
	IF @cnt > 0 SET @Alerts = @Alerts + '#'
END

UPDATE Member SET Role = @Alerts WHERE MemberID = @MemberID

SET @Result = CAST( LEN(@Alerts) AS VARCHAR(10))

GO

