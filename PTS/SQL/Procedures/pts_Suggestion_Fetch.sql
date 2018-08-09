EXEC [dbo].pts_CheckProc 'pts_Suggestion_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Suggestion_Fetch ( 
   @SuggestionID int,
   @OrgID int OUTPUT,
   @MemberID int OUTPUT,
   @OrgName nvarchar (60) OUTPUT,
   @CompanyID int OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @MemberName nvarchar (62) OUTPUT,
   @Subject nvarchar (60) OUTPUT,
   @Description nvarchar (2000) OUTPUT,
   @Status int OUTPUT,
   @SuggestionDate datetime OUTPUT,
   @Response nvarchar (1000) OUTPUT,
   @ChangeDate datetime OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @OrgID = sg.OrgID ,
   @MemberID = sg.MemberID ,
   @OrgName = og.OrgName ,
   @CompanyID = og.CompanyID ,
   @NameLast = me.NameLast ,
   @NameFirst = me.NameFirst ,
   @MemberName = LTRIM(RTRIM(me.NameLast)) +  ', '  + LTRIM(RTRIM(me.NameFirst)) ,
   @Subject = sg.Subject ,
   @Description = sg.Description ,
   @Status = sg.Status ,
   @SuggestionDate = sg.SuggestionDate ,
   @Response = sg.Response ,
   @ChangeDate = sg.ChangeDate
FROM Suggestion AS sg (NOLOCK)
LEFT OUTER JOIN Org AS og (NOLOCK) ON (sg.OrgID = og.OrgID)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (sg.MemberID = me.MemberID)
WHERE sg.SuggestionID = @SuggestionID

GO