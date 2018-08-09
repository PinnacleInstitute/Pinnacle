EXEC [dbo].pts_CheckProc 'pts_LeadPage_Add'
 GO

CREATE PROCEDURE [dbo].pts_LeadPage_Add ( 
   @LeadPageID int OUTPUT,
   @LeadCampaignID int,
   @LeadPageName nvarchar (60),
   @Status int,
   @Seq int,
   @IsInput bit,
   @IsCapture bit,
   @IsProspect bit,
   @IsNext bit,
   @NextCaption nvarchar (40),
   @Inputs nvarchar (1000),
   @Language varchar (6),
   @IsLeadURL bit,
   @IsRedirectURL bit,
   @LeadURL varchar (200),
   @RedirectURL varchar (200),
   @TopCode varchar (500),
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
   FROM LeadPage (NOLOCK)
   SET @Seq = @Seq + 10
END

INSERT INTO LeadPage (
            LeadCampaignID , 
            LeadPageName , 
            Status , 
            Seq , 
            IsInput , 
            IsCapture , 
            IsProspect , 
            IsNext , 
            NextCaption , 
            Inputs , 
            Language , 
            IsLeadURL , 
            IsRedirectURL , 
            LeadURL , 
            RedirectURL , 
            TopCode
            )
VALUES (
            @LeadCampaignID ,
            @LeadPageName ,
            @Status ,
            @Seq ,
            @IsInput ,
            @IsCapture ,
            @IsProspect ,
            @IsNext ,
            @NextCaption ,
            @Inputs ,
            @Language ,
            @IsLeadURL ,
            @IsRedirectURL ,
            @LeadURL ,
            @RedirectURL ,
            @TopCode            )

SET @mNewID = @@IDENTITY

SET @LeadPageID = @mNewID

GO