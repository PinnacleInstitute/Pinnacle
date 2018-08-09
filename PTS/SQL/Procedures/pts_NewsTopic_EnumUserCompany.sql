EXEC [dbo].pts_CheckProc 'pts_NewsTopic_EnumUserCompany'
GO

CREATE PROCEDURE [dbo].pts_NewsTopic_EnumUserCompany
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      nwt.NewsTopicID AS 'ID', 
         CASE WHEN (Seq % 100) != 0 THEN '.....' ELSE '' END + nwt.NewsTopicName AS 'Name'
FROM NewsTopic AS nwt (NOLOCK)
WHERE (nwt.CompanyID = @CompanyID)
 AND (nwt.IsActive <> 0)

ORDER BY   nwt.Seq

GO