EXEC [dbo].pts_CheckProc 'pts_Calendar_Update'
 GO

CREATE PROCEDURE [dbo].pts_Calendar_Update ( 
   @CalendarID int,
   @CompanyID int,
   @MemberID int,
   @CalendarName nvarchar (60),
   @Description nvarchar (500),
   @Layout int,
   @IsPrivate bit,
   @IsAppt bit,
   @IsClass bit,
   @IsAssess bit,
   @IsGoal bit,
   @IsProject bit,
   @IsTask bit,
   @IsSales bit,
   @IsActivities bit,
   @IsEvents bit,
   @IsService bit,
   @IsLead bit,
   @Timezone int,
   @Seq int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE cal
SET cal.CompanyID = @CompanyID ,
   cal.MemberID = @MemberID ,
   cal.CalendarName = @CalendarName ,
   cal.Description = @Description ,
   cal.Layout = @Layout ,
   cal.IsPrivate = @IsPrivate ,
   cal.IsAppt = @IsAppt ,
   cal.IsClass = @IsClass ,
   cal.IsAssess = @IsAssess ,
   cal.IsGoal = @IsGoal ,
   cal.IsProject = @IsProject ,
   cal.IsTask = @IsTask ,
   cal.IsSales = @IsSales ,
   cal.IsActivities = @IsActivities ,
   cal.IsEvents = @IsEvents ,
   cal.IsService = @IsService ,
   cal.IsLead = @IsLead ,
   cal.Timezone = @Timezone ,
   cal.Seq = @Seq
FROM Calendar AS cal
WHERE cal.CalendarID = @CalendarID

GO