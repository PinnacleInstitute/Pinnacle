EXEC [dbo].pts_CheckProc 'pts_Emailee_ListTeam'
GO

--EXEC pts_Emailee_ListTeam 6528, '1', '3', '', '', ''

CREATE PROCEDURE [dbo].pts_Emailee_ListTeam
   @CompanyID int ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80) ,
   @Data4 nvarchar (80) ,
   @Data5 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @MemberID int, @Status int, @Level int, @Title int, @FromDate datetime, @ToDate datetime
SET @MemberID = @CompanyID

IF @Data1 != '' 
	SET @Status = CAST(@Data1 AS int)
Else
	SET @Status = -1

IF @Data2 != '' 
	SET @Level = CAST(@Data2 AS int)
Else
	SET @Level = -1

IF @Data3 != '' 
	SET @Title = CAST(@Data3 AS int)
Else
	SET @Title = -1

IF @Data4 != '' 
	SET @FromDate = CAST(@Data4 AS int)
Else
	SET @FromDate = 0

IF @Data5 != '' 
	SET @ToDate = CAST(@Data5 AS int)
Else
	SET @ToDate = '1/1/2099'

SELECT MemberID AS 'EmaileeID', 
       Email AS 'Email', 
       NameFirst AS 'FirstName', 
       NameLast AS 'LastName', 
       CAST(Status AS nvarchar(10)) AS 'Data1', 
       CAST(Level AS nvarchar(10)) AS 'Data2', 
       CAST(Title AS nvarchar(10)) AS 'Data3', 
       CAST(EnrollDate AS nvarchar(20)) AS 'Data4', 
       Email2 AS 'Data5' 
FROM Member (NOLOCK)
WHERE GroupID = @MemberID
AND ( @Status = -1 OR Status = @Status )
AND ( Status >= 1 AND Status <= 4 ) 
AND ( @Level = -1 OR Level = @Level )
AND ( @Title = -1 OR Title = @Title )
AND EnrollDate >= @FromDate
AND EnrollDate <= @ToDate
AND IsMsg != 2

GO