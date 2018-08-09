EXEC [dbo].pts_CheckProc 'pts_NewsTopic_ListMajor'
GO

CREATE PROCEDURE [dbo].pts_NewsTopic_ListMajor
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      nwt.NewsTopicID, 
         nwt.NewsTopicName, 
         nwt.Seq
FROM NewsTopic AS nwt (NOLOCK)
WHERE (nwt.CompanyID = @CompanyID)
 AND (nwt.IsActive <> 0)
 AND ((nwt.Seq % 100) = 0)

ORDER BY   nwt.Seq

GO