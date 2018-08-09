EXEC [dbo].pts_CheckProc 'pts_Moption_Update'
 GO

CREATE PROCEDURE [dbo].pts_Moption_Update ( 
   @MoptionID int,
   @MemberID int,
   @IsActivity bit,
   @ActivityTracks varchar (20),
   @TrackTheme int,
   @MenuColors varchar (200),
   @Portal varchar (100),
   @Options0 varchar (50),
   @Options1 varchar (50),
   @Options2 varchar (50),
   @Options3 varchar (50),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE mop
SET mop.MemberID = @MemberID ,
   mop.IsActivity = @IsActivity ,
   mop.ActivityTracks = @ActivityTracks ,
   mop.TrackTheme = @TrackTheme ,
   mop.MenuColors = @MenuColors ,
   mop.Portal = @Portal ,
   mop.Options0 = @Options0 ,
   mop.Options1 = @Options1 ,
   mop.Options2 = @Options2 ,
   mop.Options3 = @Options3
FROM Moption AS mop
WHERE mop.MoptionID = @MoptionID

GO