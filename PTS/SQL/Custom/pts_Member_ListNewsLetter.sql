EXEC [dbo].pts_CheckProc 'pts_Member_ListNewsLetter'
GO

CREATE PROCEDURE [dbo].pts_Member_ListNewsLetter
   @MemberID int
AS

SET NOCOUNT ON

DECLARE @NewsLetterID int
SET @NewsLetterID = @MemberID

SELECT me.MemberID, 
       me.Email, 
       me.NameFirst, 
       me.NameLast, 
       me.Phone1
FROM Member AS me
JOIN MemberNews AS mn ON me.MemberID = mn.MemberID
WHERE mn.NewsLetterID = @NewsLetterID

GO