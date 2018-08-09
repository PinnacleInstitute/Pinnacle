EXEC [dbo].pts_CheckProc 'pts_Trainer_ListEmail'
GO

CREATE PROCEDURE [dbo].pts_Trainer_ListEmail
   @Email nvarchar (80) ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      tr.TrainerID, 
         LTRIM(RTRIM(tr.NameLast)) +  ', '  + LTRIM(RTRIM(tr.NameFirst)) AS 'TrainerName', 
         tr.City, 
         tr.State
FROM Trainer AS tr (NOLOCK)
WHERE (tr.Email = @Email)

ORDER BY   'TrainerName'

GO