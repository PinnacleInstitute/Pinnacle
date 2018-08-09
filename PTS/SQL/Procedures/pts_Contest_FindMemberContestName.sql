EXEC [dbo].pts_CheckProc 'pts_Contest_FindMemberContestName'
 GO

CREATE PROCEDURE [dbo].pts_Contest_FindMemberContestName ( 
   @SearchText nvarchar (40),
   @Bookmark nvarchar (50),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @MemberID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(con.ContestName, '') + dbo.wtfn_FormatNumber(con.ContestID, 10) 'BookMark' ,
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
WHERE ISNULL(con.ContestName, '') LIKE @SearchText + '%'
AND ISNULL(con.ContestName, '') + dbo.wtfn_FormatNumber(con.ContestID, 10) >= @BookMark
AND         (con.CompanyID = @CompanyID)
AND         (con.MemberID = @MemberID)
ORDER BY 'Bookmark'

GO