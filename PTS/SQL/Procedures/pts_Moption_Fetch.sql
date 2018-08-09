EXEC [dbo].pts_CheckProc 'pts_Moption_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Moption_Fetch ( 
   @MoptionID int,
   @MemberID int OUTPUT,
   @IsActivity bit OUTPUT,
   @ActivityTracks varchar (20) OUTPUT,
   @TrackTheme int OUTPUT,
   @MenuColors varchar (200) OUTPUT,
   @Portal varchar (100) OUTPUT,
   @Options0 varchar (50) OUTPUT,
   @Options1 varchar (50) OUTPUT,
   @Options2 varchar (50) OUTPUT,
   @Options3 varchar (50) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = mop.MemberID ,
   @IsActivity = mop.IsActivity ,
   @ActivityTracks = mop.ActivityTracks ,
   @TrackTheme = mop.TrackTheme ,
   @MenuColors = mop.MenuColors ,
   @Portal = mop.Portal ,
   @Options0 = mop.Options0 ,
   @Options1 = mop.Options1 ,
   @Options2 = mop.Options2 ,
   @Options3 = mop.Options3
FROM Moption AS mop (NOLOCK)
WHERE mop.MoptionID = @MoptionID

GO