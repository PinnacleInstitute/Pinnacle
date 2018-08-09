EXEC [dbo].pts_CheckProc 'pts_Pool_List'
GO

CREATE PROCEDURE [dbo].pts_Pool_List
   @MemberID int
AS

SET NOCOUNT ON

SELECT      poo.PoolID, 
         poo.MemberID, 
         poo.PoolDate, 
         poo.PoolType, 
         poo.Amount, 
         poo.Distributed
FROM Pool AS poo (NOLOCK)
WHERE (poo.MemberID = @MemberID)

ORDER BY   poo.PoolDate DESC

GO