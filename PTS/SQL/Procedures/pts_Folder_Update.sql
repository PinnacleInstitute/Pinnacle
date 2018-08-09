EXEC [dbo].pts_CheckProc 'pts_Folder_Update'
 GO

CREATE PROCEDURE [dbo].pts_Folder_Update ( 
   @FolderID int,
   @ParentID int,
   @CompanyID int,
   @MemberID int,
   @DripCampaignID int,
   @FolderName nvarchar (60),
   @Entity int,
   @Seq int,
   @IsShare bit,
   @Virtual int,
   @Data nvarchar (20),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE fo
SET fo.ParentID = @ParentID ,
   fo.CompanyID = @CompanyID ,
   fo.MemberID = @MemberID ,
   fo.DripCampaignID = @DripCampaignID ,
   fo.FolderName = @FolderName ,
   fo.Entity = @Entity ,
   fo.Seq = @Seq ,
   fo.IsShare = @IsShare ,
   fo.Virtual = @Virtual ,
   fo.Data = @Data
FROM Folder AS fo
WHERE fo.FolderID = @FolderID

GO