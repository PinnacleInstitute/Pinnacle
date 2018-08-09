EXEC [dbo].pts_CheckProc 'pts_LeadAd_Add'
 GO

CREATE PROCEDURE [dbo].pts_LeadAd_Add ( 
   @LeadAdID int OUTPUT,
   @CompanyID int,
   @GroupID int,
   @LeadAdName nvarchar (60),
   @Status int,
   @Target nvarchar (30),
   @Link nvarchar (500),
   @Seq int,
   @Image nvarchar (25),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO LeadAd (
            CompanyID , 
            GroupID , 
            LeadAdName , 
            Status , 
            Target , 
            Link , 
            Seq , 
            Image
            )
VALUES (
            @CompanyID ,
            @GroupID ,
            @LeadAdName ,
            @Status ,
            @Target ,
            @Link ,
            @Seq ,
            @Image            )

SET @mNewID = @@IDENTITY

SET @LeadAdID = @mNewID

GO