EXEC [dbo].pts_CheckProc 'pts_Schedule_Update'
 GO

CREATE PROCEDURE [dbo].pts_Schedule_Update ( 
   @ScheduleID int,
   @CompanyID int,
   @MemberID int,
   @ScheduleName nvarchar (60),
   @Description nvarchar (500),
   @Layout int,
   @IsPrivate bit,
   @IsAppt bit,
   @IsClass bit,
   @IsAssess bit,
   @IsCert bit,
   @IsGoal bit,
   @IsProject bit,
   @IsTask bit,
   @IsSales bit,
   @IsActivities bit,
   @DailyStart int,
   @DailyEnd int,
   @Timezone int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE sch
SET sch.CompanyID = @CompanyID ,
   sch.MemberID = @MemberID ,
   sch.ScheduleName = @ScheduleName ,
   sch.Description = @Description ,
   sch.Layout = @Layout ,
   sch.IsPrivate = @IsPrivate ,
   sch.IsAppt = @IsAppt ,
   sch.IsClass = @IsClass ,
   sch.IsAssess = @IsAssess ,
   sch.IsCert = @IsCert ,
   sch.IsGoal = @IsGoal ,
   sch.IsProject = @IsProject ,
   sch.IsTask = @IsTask ,
   sch.IsSales = @IsSales ,
   sch.IsActivities = @IsActivities ,
   sch.DailyStart = @DailyStart ,
   sch.DailyEnd = @DailyEnd ,
   sch.Timezone = @Timezone
FROM Schedule AS sch
WHERE sch.ScheduleID = @ScheduleID

GO