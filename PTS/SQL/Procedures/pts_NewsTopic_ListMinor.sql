EXEC [dbo].pts_CheckProc 'pts_NewsTopic_ListMinor'
GO

CREATE PROCEDURE [dbo].pts_NewsTopic_ListMinor
   @CompanyID int ,
   @Seq int
AS

SET NOCOUNT ON

SELECT      nwt.NewsTopicID, 
         nwt.NewsTopicName, 
         nwt.Seq
FROM NewsTopic AS nwt (NOLOCK)
WHERE (nwt.CompanyID = @CompanyID)
 AND (nwt.IsActive <> 0)
 AND (nwt.Seq > @Seq)
 AND (nwt.Seq < @Seq + 100)

ORDER BY   nwt.Seq

GO