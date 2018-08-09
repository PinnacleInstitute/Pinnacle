EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_88'
GO

--TEST
--EXEC pts_Emailee_ListCustom_88 13, '2', '', '', '', ''

-- Member Group Role
CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_88
   @CompanyID int ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80) ,
   @Data4 nvarchar (80) ,
   @Data5 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @Status int, @GroupID int, @Role nvarchar(15)

IF @Data1 != '' 
	SET @Status = CAST(@Data1 AS int)
Else
	SET @Status = 0

SET @GroupID = @Data2 
SET @Role = @Data3 

SELECT me.MemberID AS 'EmaileeID', 
       me.Email AS 'Email', 
       me.NameFirst AS 'FirstName', 
       me.NameLast AS 'LastName', 
       CAST(me.Status AS nvarchar(20)) AS 'Data1', 
       CAST(me.GroupID AS nvarchar(20)) AS 'Data2',
       me.Role AS 'Data3',
       '' AS 'Data4',
       '' AS 'Data5'
FROM Member AS me (NOLOCK)
WHERE ( @CompanyID = 0 OR @CompanyID = me.CompanyID )
AND ( @Status = 0 OR @Status = me.Status )
AND ( @GroupID = 0 OR me.GroupID = @GroupID ) 
AND ( @Role = '' OR me.Role = @Role ) 
AND ( me.IsRemoved = 0 )
AND me.IsMsg != 2

GO
