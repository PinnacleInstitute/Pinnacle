EXEC [dbo].pts_CheckProc 'pts_Calendar_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Calendar_Fetch ( 
   @CalendarID int,
   @CompanyID int OUTPUT,
   @MemberID int OUTPUT,
   @CalendarName nvarchar (60) OUTPUT,
   @Description nvarchar (500) OUTPUT,
   @Layout int OUTPUT,
   @IsPrivate bit OUTPUT,
   @IsAppt bit OUTPUT,
   @IsClass bit OUTPUT,
   @IsAssess bit OUTPUT,
   @IsGoal bit OUTPUT,
   @IsProject bit OUTPUT,
   @IsTask bit OUTPUT,
   @IsSales bit OUTPUT,
   @IsActivities bit OUTPUT,
   @IsEvents bit OUTPUT,
   @IsService bit OUTPUT,
   @IsLead bit OUTPUT,
   @Timezone int OUTPUT,
   @Seq int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = cal.CompanyID ,
   @MemberID = cal.MemberID ,
   @CalendarName = cal.CalendarName ,
   @Description = cal.Description ,
   @Layout = cal.Layout ,
   @IsPrivate = cal.IsPrivate ,
   @IsAppt = cal.IsAppt ,
   @IsClass = cal.IsClass ,
   @IsAssess = cal.IsAssess ,
   @IsGoal = cal.IsGoal ,
   @IsProject = cal.IsProject ,
   @IsTask = cal.IsTask ,
   @IsSales = cal.IsSales ,
   @IsActivities = cal.IsActivities ,
   @IsEvents = cal.IsEvents ,
   @IsService = cal.IsService ,
   @IsLead = cal.IsLead ,
   @Timezone = cal.Timezone ,
   @Seq = cal.Seq
FROM Calendar AS cal (NOLOCK)
WHERE cal.CalendarID = @CalendarID

GO