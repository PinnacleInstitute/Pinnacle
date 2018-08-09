EXEC [dbo].pts_CheckProc 'pts_Seminar_FindMemberID'
 GO

CREATE PROCEDURE [dbo].pts_Seminar_FindMemberID ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), sem.MemberID), '') + dbo.wtfn_FormatNumber(sem.SeminarID, 10) 'BookMark' ,
            sem.SeminarID 'SeminarID' ,
            sem.CompanyID 'CompanyID' ,
            sem.MemberID 'MemberID' ,
            sem.SeminarName 'SeminarName' ,
            sem.Description 'Description' ,
            sem.Status 'Status'
FROM Seminar AS sem (NOLOCK)
WHERE ISNULL(CONVERT(nvarchar(10), sem.MemberID), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), sem.MemberID), '') + dbo.wtfn_FormatNumber(sem.SeminarID, 10) >= @BookMark
AND         (sem.CompanyID = @CompanyID)
ORDER BY 'Bookmark'

GO