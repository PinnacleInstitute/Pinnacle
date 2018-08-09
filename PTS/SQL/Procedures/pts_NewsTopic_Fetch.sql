EXEC [dbo].pts_CheckProc 'pts_NewsTopic_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_NewsTopic_Fetch ( 
   @NewsTopicID int,
   @CompanyID int OUTPUT,
   @NewsTopicName nvarchar (40) OUTPUT,
   @Seq int OUTPUT,
   @IsActive bit OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = nwt.CompanyID ,
   @NewsTopicName = nwt.NewsTopicName ,
   @Seq = nwt.Seq ,
   @IsActive = nwt.IsActive
FROM NewsTopic AS nwt (NOLOCK)
WHERE nwt.NewsTopicID = @NewsTopicID

GO