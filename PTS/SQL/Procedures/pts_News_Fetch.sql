EXEC [dbo].pts_CheckProc 'pts_News_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_News_Fetch ( 
   @NewsID int,
   @CompanyID int OUTPUT,
   @AuthUserID int OUTPUT,
   @NewsTopicID int OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @UserName nvarchar (62) OUTPUT,
   @NewsTopicName nvarchar (80) OUTPUT,
   @Title nvarchar (150) OUTPUT,
   @Description nvarchar (1000) OUTPUT,
   @CreateDate datetime OUTPUT,
   @ActiveDate datetime OUTPUT,
   @Image nvarchar (80) OUTPUT,
   @Tags nvarchar (80) OUTPUT,
   @Status int OUTPUT,
   @Seq int OUTPUT,
   @LeadMain int OUTPUT,
   @LeadTopic int OUTPUT,
   @IsBreaking bit OUTPUT,
   @IsBreaking2 bit OUTPUT,
   @IsStrategic bit OUTPUT,
   @IsShare bit OUTPUT,
   @IsEditorial bit OUTPUT,
   @UserRole int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = nw.CompanyID ,
   @AuthUserID = nw.AuthUserID ,
   @NewsTopicID = nw.NewsTopicID ,
   @NameLast = au.NameLast ,
   @NameFirst = au.NameFirst ,
   @UserName = LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)) ,
   @NewsTopicName = nwt.NewsTopicName ,
   @Title = nw.Title ,
   @Description = nw.Description ,
   @CreateDate = nw.CreateDate ,
   @ActiveDate = nw.ActiveDate ,
   @Image = nw.Image ,
   @Tags = nw.Tags ,
   @Status = nw.Status ,
   @Seq = nw.Seq ,
   @LeadMain = nw.LeadMain ,
   @LeadTopic = nw.LeadTopic ,
   @IsBreaking = nw.IsBreaking ,
   @IsBreaking2 = nw.IsBreaking2 ,
   @IsStrategic = nw.IsStrategic ,
   @IsShare = nw.IsShare ,
   @IsEditorial = nw.IsEditorial ,
   @UserRole = nw.UserRole
FROM News AS nw (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (nw.AuthUserID = au.AuthUserID)
LEFT OUTER JOIN NewsTopic AS nwt (NOLOCK) ON (nw.NewsTopicID = nwt.NewsTopicID)
WHERE nw.NewsID = @NewsID

GO