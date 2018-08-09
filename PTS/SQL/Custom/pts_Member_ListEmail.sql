EXEC [dbo].pts_CheckProc 'pts_Member_ListEmail'
GO

-- Only List Public(Free) Members
CREATE PROCEDURE [dbo].pts_Member_ListEmail
   @CompanyID int ,
   @Email nvarchar (80)
AS

SET NOCOUNT ON

SELECT MemberID, NameLast, NameFirst, EnrollDate
FROM Member 
WHERE CompanyID = @CompanyID AND Email = @Email AND Status = 3
ORDER BY EnrollDate

GO