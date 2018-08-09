EXEC [dbo].pts_CheckProc 'pts_Channel_Update'
 GO

CREATE PROCEDURE [dbo].pts_Channel_Update ( 
   @ChannelID int,
   @CompanyID int,
   @PubDate datetime,
   @Title nvarchar (80),
   @Link nvarchar (80),
   @Description nvarchar (1000),
   @IsActive bit,
   @Filename nvarchar (20),
   @Image nvarchar (80),
   @Language nvarchar (6),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE ch
SET ch.CompanyID = @CompanyID ,
   ch.PubDate = @PubDate ,
   ch.Title = @Title ,
   ch.Link = @Link ,
   ch.Description = @Description ,
   ch.IsActive = @IsActive ,
   ch.Filename = @Filename ,
   ch.Image = @Image ,
   ch.Language = @Language
FROM Channel AS ch
WHERE ch.ChannelID = @ChannelID

GO