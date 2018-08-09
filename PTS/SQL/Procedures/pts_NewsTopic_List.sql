EXEC [dbo].pts_CheckProc 'pts_NewsTopic_List'
GO

CREATE PROCEDURE [dbo].pts_NewsTopic_List
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      nwt.NewsTopicID, 
         nwt.NewsTopicName, 
         nwt.Seq, 
         nwt.IsActive
FROM NewsTopic AS nwt (NOLOCK)
WHERE (nwt.CompanyID = @CompanyID)

ORDER BY   nwt.Seq

GO