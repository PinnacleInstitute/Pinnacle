EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_87'
GO

--TEST
--EXEC pts_Emailee_ListCustom_87 13, '2', '', '', '', ''

-- Business Members 
CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_87
   @CompanyID int ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80) ,
   @Data4 nvarchar (80) ,
   @Data5 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @Status int, @MasterID int, @GroupID int, @Role nvarchar(15)

IF @Data1 != '' 
	SET @Status = CAST(@Data1 AS int)
Else
	SET @Status = 0

IF @Data2 != '' 
	SET @MasterID = CAST(@Data2 AS int)
Else
	SET @MasterID = 0

SET @GroupID = @Data3 
SET @Role = @Data4 

SELECT me.MemberID AS 'EmaileeID', 
       me.Email AS 'Email', 
       me.NameFirst AS 'FirstName', 
       me.NameLast AS 'LastName', 
       CAST(me.Status AS nvarchar(20)) AS 'Data1', 
       ms.CompanyName AS 'Data2',
       CAST(me.GroupID AS nvarchar(20)) AS 'Data3',
       me.Role AS 'Data4',
       '' AS 'Data5'
FROM Member AS me (NOLOCK)
LEFT JOIN Member AS ms ON me.MasterID = ms.MemberID
WHERE ( @CompanyID = 0 OR @CompanyID = me.CompanyID )
AND ( @Status = 0 OR @Status = me.Status )
AND ( me.MasterID > 0 )
AND ( @MasterID = 0 OR @MasterID = me.MasterID )
AND ( @GroupID = 0 OR me.GroupID = @GroupID ) 
AND ( @Role = '' OR me.Role = @Role ) 
AND ( me.IsRemoved = 0 )
AND me.IsMsg != 2

GO
