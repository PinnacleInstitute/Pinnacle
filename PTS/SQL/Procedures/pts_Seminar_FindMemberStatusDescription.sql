EXEC [dbo].pts_CheckProc 'pts_Seminar_FindMemberStatusDescription'
 GO

CREATE PROCEDURE [dbo].pts_Seminar_FindMemberStatusDescription ( 
   @SearchText nvarchar (1000),
   @Bookmark nvarchar (1010),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @Status int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(sem.Description, '') + dbo.wtfn_FormatNumber(sem.SeminarID, 10) 'BookMark' ,
            sem.SeminarID 'SeminarID' ,
            sem.CompanyID 'CompanyID' ,
            sem.MemberID 'MemberID' ,
            sem.SeminarName 'SeminarName' ,
            sem.Description 'Description' ,
            sem.Status 'Status'
FROM Seminar AS sem (NOLOCK)
WHERE ISNULL(sem.Description, '') LIKE '%' + @SearchText + '%'
AND ISNULL(sem.Description, '') + dbo.wtfn_FormatNumber(sem.SeminarID, 10) >= @BookMark
AND         (sem.MemberID = @MemberID)
AND         (sem.Status = @Status)
ORDER BY 'Bookmark'

GO