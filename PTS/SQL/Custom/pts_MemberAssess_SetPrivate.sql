EXEC [dbo].pts_CheckProc 'pts_MemberAssess_SetPrivate'
GO

CREATE PROCEDURE [dbo].pts_MemberAssess_SetPrivate
   @MemberAssessID int ,
   @IsPrivate int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

UPDATE MemberAssess SET IsPrivate = @IsPrivate WHERE MemberAssessID = @MemberAssessID
SET @Result = @IsPrivate
GO