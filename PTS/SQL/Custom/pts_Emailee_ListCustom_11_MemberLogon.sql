EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_11_MemberLogon'
GO

CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_11_MemberLogon
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
       au.Logon AS 'Data1', 
       au.Password AS 'Data2', 
       '' AS 'Data3',
       '' AS 'Data4',
       '' AS 'Data5'
         
FROM Member AS me (NOLOCK)
JOIN AuthUser AS au ON me.AuthUserID = au.AuthUserID
WHERE me.CompanyID = @CompanyID
AND   me.Status >= 1 AND me.Status <= 3
AND me.IsMsg != 2

GO
