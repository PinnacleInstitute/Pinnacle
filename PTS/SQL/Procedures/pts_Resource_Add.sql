EXEC [dbo].pts_CheckProc 'pts_Resource_Add'
 GO

CREATE PROCEDURE [dbo].pts_Resource_Add ( 
   @ResourceID int OUTPUT,
   @MemberID int,
   @ResourceType int,
   @Share int,
   @ShareID int,
   @IsExclude bit,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Resource (
            MemberID , 
            ResourceType , 
            Share , 
            ShareID , 
            IsExclude
            )
VALUES (
            @MemberID ,
            @ResourceType ,
            @Share ,
            @ShareID ,
            @IsExclude            )

SET @mNewID = @@IDENTITY

SET @ResourceID = @mNewID

GO