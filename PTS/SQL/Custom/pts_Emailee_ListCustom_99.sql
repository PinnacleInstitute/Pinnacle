EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_99'
GO

--TEST
--EXEC pts_Emailee_ListCustom_99 11, 1, '', '', '', ''
--EXEC pts_Emailee_ListCustom_99 11, 1, '', '', '', '1'

-- Member Enrollment Date Range
CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_99
   @CompanyID int ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80) ,
   @Data4 nvarchar (80) ,
   @Data5 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @Status int, @FromDate datetime, @ToDate datetime, @Level int, @TextEmail int
DECLARE @Now datetime, @c int
SET @Status = 0
SET @Level = -1
SET @TextEmail = 0
SET @FromDate = 0
SET @ToDate = 0
SET @Now = dbo.wtfn_DateOnly(GETDATE())

IF @Data1 != '' SET @Status = CAST(@Data1 AS int)
IF @Data4 != '' SET @Level = CAST(@Data4 AS int)
IF @Data5 != '' SET @TextEmail = CAST(@Data5 AS int)

IF @Data2 != '' 
BEGIN
	IF CHARINDEX('d', @Data2) > 0
	BEGIN
		SET @Data2 = REPLACE(@Data2,'d','')
		SET @FromDate = DATEADD( day, CAST(@Data2 AS int) * -1, @Now)
	END
	IF CHARINDEX('w', @Data2) > 0
	BEGIN
		SET @Data2 = REPLACE(@Data2,'w','')
		SET @FromDate = DATEADD( week, CAST(@Data2 AS int) * -1, @Now)
	END
	IF CHARINDEX('m', @Data2) > 0
	BEGIN
		SET @Data2 = REPLACE(@Data2,'m','')
		SET @FromDate = DATEADD( month, CAST(@Data2 AS int) * -1, @Now)
	END
	IF @FromDate = 0 SET @FromDate = CAST(@Data2 AS datetime)
END
IF @Data3 != '' 
BEGIN
	IF CHARINDEX('d', @Data3) > 0
	BEGIN
		SET @Data3 = REPLACE(@Data3,'d','')
		SET @ToDate = DATEADD( day, CAST(@Data3 AS int), @FromDate)
	END
	IF CHARINDEX('w', @Data3) > 0
	BEGIN
		SET @Data3 = REPLACE(@Data3,'w','')
		SET @ToDate = DATEADD( week, CAST(@Data3 AS int), @FromDate)
	END
	IF CHARINDEX('m', @Data3) > 0
	BEGIN
		SET @Data3 = REPLACE(@Data3,'m','')
		SET @ToDate = DATEADD( month, CAST(@Data3 AS int), @FromDate)
	END
	IF @ToDate = 0 SET @ToDate = CAST(@Data3 AS datetime)
END

SELECT me.MemberID AS 'EmaileeID', 
       CASE WHEN @TextEmail > 0 THEN me.Email2 ELSE me.Email END AS 'Email', 
       me.NameFirst AS 'FirstName', 
       me.NameLast AS 'LastName', 
       CAST(me.Status AS nvarchar(20)) AS 'Data1', 
       dbo.wtfn_DateOnlyStr(me.EnrollDate) AS 'Data2', 
       CAST(me.Level AS nvarchar(20)) AS 'Data3', 
       '' AS 'Data4',
       '' AS 'Data5'
FROM Member AS me (NOLOCK)
WHERE ( @CompanyID = 0 OR @CompanyID = me.CompanyID )
AND ( @Status = 0 OR @Status = me.Status )
AND ( @Level = -1 OR @Level = me.Level )
AND ( @FromDate = 0 OR me.EnrollDate >= @FromDate ) 
AND ( @ToDate = 0 OR me.EnrollDate <= @ToDate ) 
AND ( me.IsRemoved = 0 )
AND ( CHARINDEX('@', me.Email) > 0 )
AND me.IsMsg != 2
AND me.GroupID <> 100

GO
