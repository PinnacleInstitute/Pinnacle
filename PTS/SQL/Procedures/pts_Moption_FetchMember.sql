EXEC [dbo].pts_CheckProc 'pts_Moption_FetchMember'
GO

CREATE PROCEDURE [dbo].pts_Moption_FetchMember
   @MemberID int ,
   @MoptionID int OUTPUT ,
   @ActivityTracks nvarchar (20) OUTPUT ,
   @TrackTheme int OUTPUT ,
   @MenuColors nvarchar (200) OUTPUT ,
   @Portal nvarchar (100) OUTPUT ,
   @Options0 nvarchar (50) OUTPUT ,
   @Options1 nvarchar (50) OUTPUT ,
   @Options2 nvarchar (50) OUTPUT ,
   @Options3 nvarchar (50) OUTPUT
AS

SET NOCOUNT ON

SELECT      @MoptionID = mop.MoptionID, 
         @ActivityTracks = mop.ActivityTracks, 
         @TrackTheme = mop.TrackTheme, 
         @MenuColors = mop.MenuColors, 
         @Portal = mop.Portal, 
         @Options0 = mop.Options0, 
         @Options1 = mop.Options1, 
         @Options2 = mop.Options2, 
         @Options3 = mop.Options3
FROM Moption AS mop (NOLOCK)
WHERE (mop.MemberID = @MemberID)


GO