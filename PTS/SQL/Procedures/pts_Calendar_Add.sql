EXEC [dbo].pts_CheckProc 'pts_Calendar_Add'
 GO

CREATE PROCEDURE [dbo].pts_Calendar_Add ( 
   @CalendarID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()

IF @Seq=0
BEGIN
   SELECT @Seq = ISNULL(MAX(Seq),0)
   FROM Calendar (NOLOCK)
   SET @Seq = @Seq + 10
END

INSERT INTO Calendar (
            CompanyID , 
            MemberID , 
            CalendarName , 
            Description , 
            Layout , 
            IsPrivate , 
            IsAppt , 
            IsClass , 
            IsAssess , 
            IsGoal , 
            IsProject , 
            IsTask , 
            IsSales , 
            IsActivities , 
            IsEvents , 
            IsService , 
            IsLead , 
            Timezone , 
            Seq
            )
VALUES (
            @CompanyID ,
            @MemberID ,
            @CalendarName ,
            @Description ,
            @Layout ,
            @IsPrivate ,
            @IsAppt ,
            @IsClass ,
            @IsAssess ,
            @IsGoal ,
            @IsProject ,
            @IsTask ,
            @IsSales ,
            @IsActivities ,
            @IsEvents ,
            @IsService ,
            @IsLead ,
            @Timezone ,
            @Seq            )

SET @mNewID = @@IDENTITY

SET @CalendarID = @mNewID

GO