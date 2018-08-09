EXEC [dbo].pts_CheckProc 'pts_BarterArea_Update'
 GO

CREATE PROCEDURE [dbo].pts_BarterArea_Update ( 
   @BarterAreaID int,
   @ParentID int,
   @CountryID int,
   @ConsumerID int,
   @BarterAreaName varchar (40),
   @BarterAreaType int,
   @Status int,
   @Children int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE bar
SET bar.ParentID = @ParentID ,
   bar.CountryID = @CountryID ,
   bar.ConsumerID = @ConsumerID ,
   bar.BarterAreaName = @BarterAreaName ,
   bar.BarterAreaType = @BarterAreaType ,
   bar.Status = @Status ,
   bar.Children = @Children
FROM BarterArea AS bar
WHERE bar.BarterAreaID = @BarterAreaID

GO