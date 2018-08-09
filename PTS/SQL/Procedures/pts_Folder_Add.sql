EXEC [dbo].pts_CheckProc 'pts_Folder_Add'
 GO

CREATE PROCEDURE [dbo].pts_Folder_Add ( 
   @FolderID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Folder (
            ParentID , 
            CompanyID , 
            MemberID , 
            DripCampaignID , 
            FolderName , 
            Entity , 
            Seq , 
            IsShare , 
            Virtual , 
            Data
            )
VALUES (
            @ParentID ,
            @CompanyID ,
            @MemberID ,
            @DripCampaignID ,
            @FolderName ,
            @Entity ,
            @Seq ,
            @IsShare ,
            @Virtual ,
            @Data            )

SET @mNewID = @@IDENTITY

SET @FolderID = @mNewID

GO