EXEC [dbo].pts_CheckProc 'pts_Company_ListMember'
GO

CREATE PROCEDURE [dbo].pts_Company_ListMember
   @MemberID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      com.CompanyID, 
         com.CompanyName, 
         com.NameFirst, 
         com.NameLast, 
         com.Status, 
         com.CompanyType
FROM Company AS com (NOLOCK)
WHERE (com.MemberID = @MemberID)


GO