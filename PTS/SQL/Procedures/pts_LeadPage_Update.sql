EXEC [dbo].pts_CheckProc 'pts_LeadPage_Update'
 GO

CREATE PROCEDURE [dbo].pts_LeadPage_Update ( 
   @LeadPageID int,
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

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE lp
SET lp.LeadCampaignID = @LeadCampaignID ,
   lp.LeadPageName = @LeadPageName ,
   lp.Status = @Status ,
   lp.Seq = @Seq ,
   lp.IsInput = @IsInput ,
   lp.IsCapture = @IsCapture ,
   lp.IsProspect = @IsProspect ,
   lp.IsNext = @IsNext ,
   lp.NextCaption = @NextCaption ,
   lp.Inputs = @Inputs ,
   lp.Language = @Language ,
   lp.IsLeadURL = @IsLeadURL ,
   lp.IsRedirectURL = @IsRedirectURL ,
   lp.LeadURL = @LeadURL ,
   lp.RedirectURL = @RedirectURL ,
   lp.TopCode = @TopCode
FROM LeadPage AS lp
WHERE lp.LeadPageID = @LeadPageID

GO