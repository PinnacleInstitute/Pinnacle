EXEC [dbo].pts_CheckProc 'pts_PageSection_FindPageSectionName'
 GO

CREATE PROCEDURE [dbo].pts_PageSection_FindPageSectionName ( 
   @SearchText nvarchar (40),
   @Bookmark nvarchar (50),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(ps.PageSectionName, '') + dbo.wtfn_FormatNumber(ps.PageSectionID, 10) 'BookMark' ,
            ps.PageSectionID 'PageSectionID' ,
            ps.CompanyID 'CompanyID' ,
            ps.PageSectionName 'PageSectionName' ,
            ps.FileName 'FileName' ,
            ps.Path 'Path' ,
            ps.Language 'Language' ,
            ps.Width 'Width' ,
            ps.Custom 'Custom'
FROM PageSection AS ps (NOLOCK)
WHERE ISNULL(ps.PageSectionName, '') LIKE @SearchText + '%'
AND ISNULL(ps.PageSectionName, '') + dbo.wtfn_FormatNumber(ps.PageSectionID, 10) >= @BookMark
AND         (ps.CompanyID = @CompanyID)
ORDER BY 'Bookmark'

GO