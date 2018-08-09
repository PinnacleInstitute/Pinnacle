EXEC [dbo].pts_CheckProc 'pts_Channel_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Channel_Fetch ( 
   @ChannelID int,
   @CompanyID int OUTPUT,
   @PubDate datetime OUTPUT,
   @Title nvarchar (80) OUTPUT,
   @Link nvarchar (80) OUTPUT,
   @Description nvarchar (1000) OUTPUT,
   @IsActive bit OUTPUT,
   @Filename nvarchar (20) OUTPUT,
   @Image nvarchar (80) OUTPUT,
   @Language nvarchar (6) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = ch.CompanyID ,
   @PubDate = ch.PubDate ,
   @Title = ch.Title ,
   @Link = ch.Link ,
   @Description = ch.Description ,
   @IsActive = ch.IsActive ,
   @Filename = ch.Filename ,
   @Image = ch.Image ,
   @Language = ch.Language
FROM Channel AS ch (NOLOCK)
WHERE ch.ChannelID = @ChannelID

GO