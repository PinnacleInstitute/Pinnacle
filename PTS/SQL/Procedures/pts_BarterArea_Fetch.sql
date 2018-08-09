EXEC [dbo].pts_CheckProc 'pts_BarterArea_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_BarterArea_Fetch ( 
   @BarterAreaID int,
   @ParentID int OUTPUT,
   @CountryID int OUTPUT,
   @ConsumerID int OUTPUT,
   @CountryName nvarchar (50) OUTPUT,
   @BarterAreaName varchar (40) OUTPUT,
   @BarterAreaType int OUTPUT,
   @Status int OUTPUT,
   @Children int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @ParentID = bar.ParentID ,
   @CountryID = bar.CountryID ,
   @ConsumerID = bar.ConsumerID ,
   @CountryName = cou.CountryName ,
   @BarterAreaName = bar.BarterAreaName ,
   @BarterAreaType = bar.BarterAreaType ,
   @Status = bar.Status ,
   @Children = bar.Children
FROM BarterArea AS bar (NOLOCK)
LEFT OUTER JOIN Country AS cou (NOLOCK) ON (bar.CountryID = cou.CountryID)
WHERE bar.BarterAreaID = @BarterAreaID

GO