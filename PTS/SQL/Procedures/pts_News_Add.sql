EXEC [dbo].pts_CheckProc 'pts_News_Add'
 GO

CREATE PROCEDURE [dbo].pts_News_Add ( 
   @NewsID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()

IF @Seq=0
BEGIN
   SELECT @Seq = ISNULL(MAX(Seq),0)
   FROM News (NOLOCK)
   SET @Seq = @Seq + 5
END

INSERT INTO News (
            CompanyID , 
            AuthUserID , 
            NewsTopicID , 
            Title , 
            Description , 
            CreateDate , 
            ActiveDate , 
            Image , 
            Tags , 
            Status , 
            Seq , 
            LeadMain , 
            LeadTopic , 
            IsBreaking , 
            IsBreaking2 , 
            IsStrategic , 
            IsShare , 
            IsEditorial , 
            UserRole
            )
VALUES (
            @CompanyID ,
            @AuthUserID ,
            @NewsTopicID ,
            @Title ,
            @Description ,
            @CreateDate ,
            @ActiveDate ,
            @Image ,
            @Tags ,
            @Status ,
            @Seq ,
            @LeadMain ,
            @LeadTopic ,
            @IsBreaking ,
            @IsBreaking2 ,
            @IsStrategic ,
            @IsShare ,
            @IsEditorial ,
            @UserRole            )

SET @mNewID = @@IDENTITY

SET @NewsID = @mNewID

GO