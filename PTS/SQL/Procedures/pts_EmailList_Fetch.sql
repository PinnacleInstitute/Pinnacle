EXEC [dbo].pts_CheckProc 'pts_EmailList_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_EmailList_Fetch ( 
   @EmailListID int,
   @CompanyID int OUTPUT,
   @EmailSourceID int OUTPUT,
   @EmailListName nvarchar (60) OUTPUT,
   @SourceType int OUTPUT,
   @CustomID int OUTPUT,
   @Param1 nvarchar (30) OUTPUT,
   @Param2 nvarchar (30) OUTPUT,
   @Param3 nvarchar (30) OUTPUT,
   @Param4 nvarchar (30) OUTPUT,
   @Param5 nvarchar (30) OUTPUT,
   @Unsubscribe bit OUTPUT,
   @Query varchar (500) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = eml.CompanyID ,
   @EmailSourceID = eml.EmailSourceID ,
   @EmailListName = eml.EmailListName ,
   @SourceType = eml.SourceType ,
   @CustomID = eml.CustomID ,
   @Param1 = eml.Param1 ,
   @Param2 = eml.Param2 ,
   @Param3 = eml.Param3 ,
   @Param4 = eml.Param4 ,
   @Param5 = eml.Param5 ,
   @Unsubscribe = eml.Unsubscribe ,
   @Query = eml.Query
FROM EmailList AS eml (NOLOCK)
WHERE eml.EmailListID = @EmailListID

GO