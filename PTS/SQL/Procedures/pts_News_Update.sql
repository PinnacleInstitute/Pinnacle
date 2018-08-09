EXEC [dbo].pts_CheckProc 'pts_News_Update'
 GO

CREATE PROCEDURE [dbo].pts_News_Update ( 
   @NewsID int,
   @CompanyID int,
   @AuthUserID int,
   @NewsTopicID int,
   @Title nvarchar (150),
   @Description nvarchar (1000),
   @CreateDate datetime,
   @ActiveDate datetime,
   @Image nvarchar (80),
   @Tags nvarchar (80),
   @Status int,
   @Seq int,
   @LeadMain int,
   @LeadTopic int,
   @IsBreaking bit,
   @IsBreaking2 bit,
   @IsStrategic bit,
   @IsShare bit,
   @IsEditorial bit,
   @UserRole int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE nw
SET nw.CompanyID = @CompanyID ,
   nw.AuthUserID = @AuthUserID ,
   nw.NewsTopicID = @NewsTopicID ,
   nw.Title = @Title ,
   nw.Description = @Description ,
   nw.CreateDate = @CreateDate ,
   nw.ActiveDate = @ActiveDate ,
   nw.Image = @Image ,
   nw.Tags = @Tags ,
   nw.Status = @Status ,
   nw.Seq = @Seq ,
   nw.LeadMain = @LeadMain ,
   nw.LeadTopic = @LeadTopic ,
   nw.IsBreaking = @IsBreaking ,
   nw.IsBreaking2 = @IsBreaking2 ,
   nw.IsStrategic = @IsStrategic ,
   nw.IsShare = @IsShare ,
   nw.IsEditorial = @IsEditorial ,
   nw.UserRole = @UserRole
FROM News AS nw
WHERE nw.NewsID = @NewsID

GO