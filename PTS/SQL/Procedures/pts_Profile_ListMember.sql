EXEC [dbo].pts_CheckProc 'pts_Profile_ListMember'
GO

CREATE PROCEDURE [dbo].pts_Profile_ListMember
   @MemberID int
AS

SET NOCOUNT ON

SELECT      pro.ProfileID, 
         pro.ProfileDate, 
         pro.ProfileType, 
         pro.Status, 
         pro.VQClarity_I, 
         pro.VQClarity_E, 
         pro.VQClarity_S, 
         pro.VQBias_I, 
         pro.VQBias_E, 
         pro.VQBias_S, 
         pro.SQClarity_I, 
         pro.SQClarity_E, 
         pro.SQClarity_S, 
         pro.SQBias_I, 
         pro.SQBias_E, 
         pro.SQBias_S
FROM Profile AS pro (NOLOCK)
WHERE (pro.MemberID = @MemberID)

ORDER BY   pro.ProfileDate

GO