EXEC [dbo].pts_CheckProc 'pts_Channel_ListChannels'
GO

CREATE PROCEDURE [dbo].pts_Channel_ListChannels
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      ch.ChannelID, 
         ch.PubDate, 
         ch.Title, 
         ch.Link, 
         ch.Description, 
         ch.Filename, 
         ch.Image, 
         ch.IsActive, 
         ch.Language
FROM Channel AS ch (NOLOCK)
WHERE (ch.CompanyID = @CompanyID)

ORDER BY   ch.Title

GO