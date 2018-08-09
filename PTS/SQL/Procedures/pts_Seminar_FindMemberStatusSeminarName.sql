EXEC [dbo].pts_CheckProc 'pts_Seminar_FindMemberStatusSeminarName'
 GO

CREATE PROCEDURE [dbo].pts_Seminar_FindMemberStatusSeminarName ( 
   @SearchText nvarchar (100),
   @Bookmark nvarchar (110),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @Status int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(sem.SeminarName, '') + dbo.wtfn_FormatNumber(sem.SeminarID, 10) 'BookMark' ,
            sem.SeminarID 'SeminarID' ,
            sem.CompanyID 'CompanyID' ,
            sem.MemberID 'MemberID' ,
            sem.SeminarName 'SeminarName' ,
            sem.Description 'Description' ,
            sem.Status 'Status'
FROM Seminar AS sem (NOLOCK)
WHERE ISNULL(sem.SeminarName, '') LIKE @SearchText + '%'
AND ISNULL(sem.SeminarName, '') + dbo.wtfn_FormatNumber(sem.SeminarID, 10) >= @BookMark
AND         (sem.MemberID = @MemberID)
AND         (sem.Status = @Status)
ORDER BY 'Bookmark'

GO