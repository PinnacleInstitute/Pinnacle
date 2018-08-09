EXEC [dbo].pts_CheckProc 'pts_NewsLetter_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_NewsLetter_Fetch ( 
   @NewsLetterID int,
   @CompanyID int OUTPUT,
   @MemberID int OUTPUT,
   @CompanyName nvarchar (60) OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @MemberName nvarchar (62) OUTPUT,
   @NewsLetterName nvarchar (60) OUTPUT,
   @Status int OUTPUT,
   @Description nvarchar (200) OUTPUT,
   @MemberCnt int OUTPUT,
   @ProspectCnt int OUTPUT,
   @IsAttached bit OUTPUT,
   @IsFeatured bit OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = nl.CompanyID ,
   @MemberID = nl.MemberID ,
   @CompanyName = co.CompanyName ,
   @NameLast = me.NameLast ,
   @NameFirst = me.NameFirst ,
   @MemberName = LTRIM(RTRIM(me.NameFirst)) +  ' '  + LTRIM(RTRIM(me.NameLast)) ,
   @NewsLetterName = nl.NewsLetterName ,
   @Status = nl.Status ,
   @Description = nl.Description ,
   @MemberCnt = nl.MemberCnt ,
   @ProspectCnt = nl.ProspectCnt ,
   @IsAttached = nl.IsAttached ,
   @IsFeatured = nl.IsFeatured
FROM NewsLetter AS nl (NOLOCK)
LEFT OUTER JOIN Company AS co (NOLOCK) ON (nl.CompanyID = co.CompanyID)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (nl.MemberID = me.MemberID)
WHERE nl.NewsLetterID = @NewsLetterID

GO