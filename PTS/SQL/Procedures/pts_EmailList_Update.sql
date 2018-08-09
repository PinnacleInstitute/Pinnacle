EXEC [dbo].pts_CheckProc 'pts_EmailList_Update'
 GO

CREATE PROCEDURE [dbo].pts_EmailList_Update ( 
   @EmailListID int,
   @CompanyID int,
   @EmailSourceID int,
   @EmailListName nvarchar (60),
   @SourceType int,
   @CustomID int,
   @Param1 nvarchar (30),
   @Param2 nvarchar (30),
   @Param3 nvarchar (30),
   @Param4 nvarchar (30),
   @Param5 nvarchar (30),
   @Unsubscribe bit,
   @Query varchar (500),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE eml
SET eml.CompanyID = @CompanyID ,
   eml.EmailSourceID = @EmailSourceID ,
   eml.EmailListName = @EmailListName ,
   eml.SourceType = @SourceType ,
   eml.CustomID = @CustomID ,
   eml.Param1 = @Param1 ,
   eml.Param2 = @Param2 ,
   eml.Param3 = @Param3 ,
   eml.Param4 = @Param4 ,
   eml.Param5 = @Param5 ,
   eml.Unsubscribe = @Unsubscribe ,
   eml.Query = @Query
FROM EmailList AS eml
WHERE eml.EmailListID = @EmailListID

GO