EXEC [dbo].pts_CheckProc 'pts_NewsTopic_Add'
 GO

CREATE PROCEDURE [dbo].pts_NewsTopic_Add ( 
   @NewsTopicID int OUTPUT,
   @CompanyID int,
   @NewsTopicName nvarchar (40),
   @Seq int,
   @IsActive bit,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO NewsTopic (
            CompanyID , 
            NewsTopicName , 
            Seq , 
            IsActive
            )
VALUES (
            @CompanyID ,
            @NewsTopicName ,
            @Seq ,
            @IsActive            )

SET @mNewID = @@IDENTITY

SET @NewsTopicID = @mNewID

GO