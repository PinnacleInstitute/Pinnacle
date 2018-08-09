EXEC [dbo].pts_CheckProc 'pts_Channel_Add'
 GO

CREATE PROCEDURE [dbo].pts_Channel_Add ( 
   @ChannelID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Channel (
            CompanyID , 
            PubDate , 
            Title , 
            Link , 
            Description , 
            IsActive , 
            Filename , 
            Image , 
            Language
            )
VALUES (
            @CompanyID ,
            @PubDate ,
            @Title ,
            @Link ,
            @Description ,
            @IsActive ,
            @Filename ,
            @Image ,
            @Language            )

SET @mNewID = @@IDENTITY

SET @ChannelID = @mNewID

GO