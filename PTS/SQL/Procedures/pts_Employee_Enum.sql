EXEC [dbo].pts_CheckProc 'pts_Employee_Enum'
 GO

CREATE PROCEDURE [dbo].pts_Employee_Enum ( 
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT         em.EmployeeID 'ID' ,
            LTRIM(RTRIM(em.NameFirst)) +  ' '  + LTRIM(RTRIM(em.NameLast)) +  ''  'Name'
FROM Employee AS em (NOLOCK)
ORDER BY LTRIM(RTRIM(em.NameFirst)) +  ' '  + LTRIM(RTRIM(em.NameLast)) +  '' 

GO