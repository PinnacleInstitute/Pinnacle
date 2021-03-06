EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_8_MemberReference'
GO

CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_8_MemberReference
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80) ,
   @Data4 nvarchar (80) ,
   @Data5 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @CompanyID int
IF @Data1 != '' 
	SET @CompanyID = CAST(@Data1 AS int)
Else
	SET @CompanyID = 0

SELECT me.MemberID AS 'EmaileeID', 
       me.Email AS 'Email', 
       me.NameFirst AS 'FirstName', 
       me.NameLast AS 'LastName', 
       co.CompanyID AS 'Data1', 
       co.CompanyName AS 'Data2', 
       me.Reference AS 'Data3', 
       me.Referral AS 'Data4',
       '' AS 'Data5'
FROM Member AS me (NOLOCK)
JOIN Company AS co ON me.CompanyID = co.CompanyID

WHERE ( @CompanyID = 0 OR @CompanyID = me.CompanyID )
AND ( me.Status = 1 OR me.Status = 2 )
AND me.IsDiscount = 1
AND me.IsMsg != 2

GO