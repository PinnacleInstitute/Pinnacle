EXEC [dbo].pts_CheckProc 'pts_MemberNews_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_MemberNews_Fetch ( 
   @MemberNewsID int,
   @MemberID int OUTPUT,
   @NewsLetterID int OUTPUT,
   @NewsLetterName nvarchar (60) OUTPUT,
   @Description nvarchar (200) OUTPUT,
   @CompanyName nvarchar (60) OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @MemberName nvarchar (62) OUTPUT,
   @EnrollDate datetime OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = mn.MemberID ,
   @NewsLetterID = mn.NewsLetterID ,
   @NewsLetterName = nl.NewsLetterName ,
   @Description = nl.Description ,
   @CompanyName = co.CompanyName ,
   @NameLast = me.NameLast ,
   @NameFirst = me.NameFirst ,
   @MemberName = LTRIM(RTRIM(me.NameFirst)) +  ' '  + LTRIM(RTRIM(me.NameLast)) ,
   @EnrollDate = mn.EnrollDate
FROM MemberNews AS mn (NOLOCK)
LEFT OUTER JOIN NewsLetter AS nl (NOLOCK) ON (mn.NewsLetterID = nl.NewsLetterID)
LEFT OUTER JOIN Company AS co (NOLOCK) ON (nl.CompanyID = co.CompanyID)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (mn.MemberID = me.MemberID)
WHERE mn.MemberNewsID = @MemberNewsID

GO