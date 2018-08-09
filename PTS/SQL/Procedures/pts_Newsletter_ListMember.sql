EXEC [dbo].pts_CheckProc 'pts_NewsLetter_ListMember'
GO

CREATE PROCEDURE [dbo].pts_NewsLetter_ListMember
   @MemberID int
AS

SET NOCOUNT ON

SELECT      nl.NewsLetterID, 
         nl.NewsLetterName, 
         nl.Description, 
         nl.Status, 
         nl.IsFeatured, 
         nl.MemberCnt, 
         nl.ProspectCnt
FROM NewsLetter AS nl (NOLOCK)
WHERE (nl.MemberID = @MemberID)

ORDER BY   nl.NewsLetterName

GO