EXEC [dbo].pts_CheckProc 'pts_Advance_FetchMember'
GO

CREATE PROCEDURE [dbo].pts_Advance_FetchMember
   @MemberID int ,
   @AdvanceID int OUTPUT ,
   @Personal int OUTPUT ,
   @Group int OUTPUT ,
   @Title int OUTPUT ,
   @IsLocked bit OUTPUT ,
   @Title1 int OUTPUT ,
   @Title2 int OUTPUT ,
   @Title3 int OUTPUT ,
   @Title4 int OUTPUT ,
   @Title5 int OUTPUT
AS

SET NOCOUNT ON

SELECT      @AdvanceID = av.AdvanceID, 
         @Personal = av.Personal, 
         @Group = av.[Group], 
         @Title = av.Title, 
         @IsLocked = av.IsLocked, 
         @Title1 = av.Title1, 
         @Title2 = av.Title2, 
         @Title3 = av.Title3, 
         @Title4 = av.Title4, 
         @Title5 = av.Title5
FROM Advance AS av (NOLOCK)
WHERE (av.MemberID = @MemberID)


GO