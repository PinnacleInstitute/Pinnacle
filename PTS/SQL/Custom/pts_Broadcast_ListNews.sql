EXEC [dbo].pts_CheckProc 'pts_Broadcast_ListNews'
GO

--EXEC pts_Broadcast_ListNews 1

CREATE PROCEDURE [dbo].pts_Broadcast_ListNews
   @BroadcastID int
AS

SET NOCOUNT ON

SELECT nw.NewsID 'BroadcastID', 
       nw.Title, 
       nw.Image, 
       nw.Description 'Summary'
FROM BroadcastNews AS bn (NOLOCK)
JOIN News AS nw (NOLOCK) ON (bn.NewsID = nw.NewsID)
WHERE bn.BroadcastID = @BroadcastID AND nw.Status = 4
Order By nw.ActiveDate

GO