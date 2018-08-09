EXEC [dbo].pts_CheckProc 'pts_Resource_Update'
 GO

CREATE PROCEDURE [dbo].pts_Resource_Update ( 
   @ResourceID int,
   @MemberID int,
   @ResourceType int,
   @Share int,
   @ShareID int,
   @IsExclude bit,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE rs
SET rs.MemberID = @MemberID ,
   rs.ResourceType = @ResourceType ,
   rs.Share = @Share ,
   rs.ShareID = @ShareID ,
   rs.IsExclude = @IsExclude
FROM Resource AS rs
WHERE rs.ResourceID = @ResourceID

GO