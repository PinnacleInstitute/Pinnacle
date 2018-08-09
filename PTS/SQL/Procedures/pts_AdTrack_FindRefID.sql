EXEC [dbo].pts_CheckProc 'pts_AdTrack_FindRefID'
 GO

CREATE PROCEDURE [dbo].pts_AdTrack_FindRefID ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @FromDate datetime,
   @ToDate datetime,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), adk.RefID), '') + dbo.wtfn_FormatNumber(adk.AdTrackID, 10) 'BookMark' ,
            adk.AdTrackID 'AdTrackID' ,
            adk.AdID 'AdID' ,
            adk.Place 'Place' ,
            adk.RefID 'RefID' ,
            adk.UType 'UType' ,
            adk.UID 'UID' ,
            adk.PlaceDate 'PlaceDate' ,
            adk.ClickDate 'ClickDate'
FROM AdTrack AS adk (NOLOCK)
WHERE ISNULL(CONVERT(nvarchar(10), adk.RefID), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), adk.RefID), '') + dbo.wtfn_FormatNumber(adk.AdTrackID, 10) >= @BookMark
AND         (adk.PlaceDate >= @FromDate)
AND         (adk.PlaceDate <= @ToDate)
ORDER BY 'Bookmark'

GO