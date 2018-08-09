EXEC [dbo].pts_CheckProc 'pts_Govid_FetchMember'
GO

CREATE PROCEDURE [dbo].pts_Govid_FetchMember
   @MemberID int ,
   @GovidID int OUTPUT ,
   @CountryID int OUTPUT ,
   @GType int OUTPUT ,
   @GNumber nvarchar (50) OUTPUT ,
   @Issuer nvarchar (2) OUTPUT ,
   @IssueDate datetime OUTPUT ,
   @ExpDate datetime OUTPUT
AS

SET NOCOUNT ON

SELECT      @GovidID = gi.GovidID, 
         @CountryID = gi.CountryID, 
         @MemberID = gi.MemberID, 
         @GType = gi.GType, 
         @GNumber = gi.GNumber, 
         @Issuer = gi.Issuer, 
         @IssueDate = gi.IssueDate, 
         @ExpDate = gi.ExpDate
FROM Govid AS gi (NOLOCK)
WHERE (gi.MemberID = @MemberID)


GO