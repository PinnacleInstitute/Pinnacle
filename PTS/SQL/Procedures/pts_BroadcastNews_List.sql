EXEC [dbo].pts_CheckProc 'pts_BroadcastNews_List'
GO

CREATE PROCEDURE [dbo].pts_BroadcastNews_List
   @BroadcastID int
AS

SET NOCOUNT ON

SELECT      bcn.BroadcastNewsID, 
         bcn.NewsID, 
         nw.Title AS 'Title'
FROM BroadcastNews AS bcn (NOLOCK)
LEFT OUTER JOIN News AS nw (NOLOCK) ON (bcn.NewsID = nw.NewsID)
WHERE (bcn.BroadcastID = @BroadcastID)

ORDER BY   nw.ActiveDate DESC

GO