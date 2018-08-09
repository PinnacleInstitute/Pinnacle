EXEC [dbo].pts_CheckProc 'pts_NewsTopic_Update'
 GO

CREATE PROCEDURE [dbo].pts_NewsTopic_Update ( 
   @NewsTopicID int,
   @CompanyID int,
   @NewsTopicName nvarchar (40),
   @Seq int,
   @IsActive bit,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE nwt
SET nwt.CompanyID = @CompanyID ,
   nwt.NewsTopicName = @NewsTopicName ,
   nwt.Seq = @Seq ,
   nwt.IsActive = @IsActive
FROM NewsTopic AS nwt
WHERE nwt.NewsTopicID = @NewsTopicID

GO