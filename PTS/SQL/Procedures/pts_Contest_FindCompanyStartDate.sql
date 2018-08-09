EXEC [dbo].pts_CheckProc 'pts_Contest_FindCompanyStartDate'
 GO

CREATE PROCEDURE [dbo].pts_Contest_FindCompanyStartDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20
IF (@Bookmark = '') SET @Bookmark = '99991231'
IF (ISDATE(@SearchText) = 1)
            SET @SearchText = CONVERT(nvarchar(10), CONVERT(datetime, @SearchText), 112)
ELSE
            SET @SearchText = ''


SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), con.StartDate, 112), '') + dbo.wtfn_FormatNumber(con.ContestID, 10) 'BookMark' ,
            con.ContestID 'ContestID' ,
            con.CompanyID 'CompanyID' ,
            con.MemberID 'MemberID' ,
            con.ContestName 'ContestName' ,
            con.Description 'Description' ,
            con.Status 'Status' ,
            con.Metric 'Metric' ,
            con.StartDate 'StartDate' ,
            con.EndDate 'EndDate' ,
            con.IsPrivate 'IsPrivate' ,
            con.Custom1 'Custom1' ,
            con.Custom2 'Custom2' ,
            con.Custom3 'Custom3' ,
            con.Custom4 'Custom4' ,
            con.Custom5 'Custom5'
FROM Contest AS con (NOLOCK)
WHERE ISNULL(CONVERT(nvarchar(10), con.StartDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), con.StartDate, 112), '') + dbo.wtfn_FormatNumber(con.ContestID, 10) <= @BookMark
AND         (con.CompanyID = @CompanyID)
AND         (con.MemberID = 0)
ORDER BY 'Bookmark' DESC

GO