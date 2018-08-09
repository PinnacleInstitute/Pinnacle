EXEC [dbo].pts_CheckProc 'pts_Employee_FindEmail'
 GO

CREATE PROCEDURE [dbo].pts_Employee_FindEmail ( 
   @SearchText nvarchar (80),
   @Bookmark nvarchar (90),
   @MaxRows tinyint OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(em.Email, '') + dbo.wtfn_FormatNumber(em.EmployeeID, 10) 'BookMark' ,
            em.EmployeeID 'EmployeeID' ,
            em.AuthUserID 'AuthUserID' ,
            em.MemberID 'MemberID' ,
            au.UserGroup 'UserGroup' ,
            au.UserStatus 'UserStatus' ,
            em.NameLast 'NameLast' ,
            em.NameFirst 'NameFirst' ,
            LTRIM(RTRIM(em.NameFirst)) +  ' '  + LTRIM(RTRIM(em.NameLast)) +  ''  'EmployeeName' ,
            em.Email 'Email' ,
            em.Street 'Street' ,
            em.Unit 'Unit' ,
            em.City 'City' ,
            em.State 'State' ,
            em.Zip 'Zip' ,
            em.Country 'Country' ,
            em.Phone 'Phone' ,
            em.Mobile 'Mobile' ,
            em.Title 'Title' ,
            em.Status 'Status' ,
            em.Notes 'Notes' ,
            em.Security 'Security'
FROM Employee AS em (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (em.AuthUserID = au.AuthUserID)
WHERE ISNULL(em.Email, '') LIKE @SearchText + '%'
AND ISNULL(em.Email, '') + dbo.wtfn_FormatNumber(em.EmployeeID, 10) >= @BookMark
ORDER BY 'Bookmark'

GO